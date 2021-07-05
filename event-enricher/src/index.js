const awsXRay = require('aws-xray-sdk'),
  AWS = awsXRay.captureAWS(require('aws-sdk')),
  sns = new AWS.SNS(),
  logger = require('./logger'),
  fetch = require('node-fetch');

awsXRay.captureHTTPsGlobal(require('http')); // Globally instrument http client
awsXRay.captureHTTPsGlobal(require('https')); // Globally instrument https client
awsXRay.capturePromise();

exports.handler = async (event) => {
  logger.info(`Received event: ${JSON.stringify(event)}`);
  await Promise.all(event.Records.map(processRecord));
  return 'Ok';
};

async function processRecord(sqsRecord) {
  logger.info(`Received following message: ${sqsRecord.body}`);
  const sourceEvent = JSON.parse(sqsRecord.body);

  const subsegment = awsXRay.getSegment().addNewSubsegment('enrichEvent');
  const enrichedEvent = await enrichEvent(sourceEvent);
  subsegment.close();

  const params = {
    Message: JSON.stringify(enrichedEvent),
    TopicArn: process.env.SNS_TOPIC_ARN
  };
  const response = await sns.publish(params)
    .promise();
  logger.info('Published MessageId:', {messageId: response.MessageId});
}

async function enrichEvent(sourceEvent) {
  const {hotelUuid} = sourceEvent;

  const hotelResponse = await fetch(`http://${process.env.ATTRIBUTES_MANAGER_URL}/api/hotel/${hotelUuid}`);
  const hotelResponseBody = await hotelResponse.json();
  sourceEvent.hotelDetails = {
    name: hotelResponseBody.name,
    address: hotelResponseBody.address,
    viewType: hotelResponseBody.viewType
  }

  const roomsResponse = await fetch(`http://${process.env.ATTRIBUTES_MANAGER_URL}/api/room/${hotelUuid}`);
  const roomsResponseBody = await roomsResponse.json();
  sourceEvent.rooms = roomsResponseBody.map(room => ({
    uuid: room.uuid,
    name: room.name,
    occupancy: room.occupancy
  }));

  return sourceEvent;
}
