const awsXRay = require('aws-xray-sdk-core'),
  AWS = awsXRay.captureAWS(require('aws-sdk')),
  sns = new AWS.SNS(),
  logger = require('./logger');

exports.handler = async (event) => {
  logger.info(`Received event: ${JSON.stringify(event)}`);
  await Promise.all(event.Records.map(processRecord));
  return 'Ok';
};

async function processRecord(sqsRecord) {
  logger.info(`Received following message: ${sqsRecord.body}`);
  const sourceEvent = JSON.parse(sqsRecord.body);

  const enrichedEvent = enrichEvent(sourceEvent);

  const params = {
    Message: JSON.stringify(enrichedEvent),
    TopicArn: process.env.SNS_TOPIC_ARN
  };
  const response = await sns.publish(params)
    .promise();
  logger.info('Published MessageId:', {messageId: response.MessageId});
}

function enrichEvent(sourceEvent) {
  return sourceEvent;
}
