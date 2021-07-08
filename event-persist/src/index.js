const awsXRay = require('aws-xray-sdk-core'),
  AWS = awsXRay.captureAWS(require('aws-sdk')),
  s3 = new AWS.S3(),
  logger = require('./logger'),
  uuidv4 = require('uuid').v4;

exports.handler = async (event) => {
  logger.info(`Received event: ${JSON.stringify(event)}`);
  await Promise.all(event.Records.map(processRecord));
  return 'Ok';
};

async function processRecord(record) {
  const body = record.Sns.Message;

  if (body.includes('error')) {
    throw new Error('Error found in incoming message');
  }

  const params = {
    Bucket: process.env.BUCKET_NAME,
    Key: `${uuidv4()}.json`,
    Body: body
  };

  await s3.upload(params).promise();
  console.log(`File uploaded successfully.`);
}
