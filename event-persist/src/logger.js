const winston = require('winston');
const awsXRay = require('aws-xray-sdk-core');

module.exports = winston.createLogger({
  level: 'info',
  format: winston.format.json(),
  defaultMeta: {
    service: 'event-persist',
    get correlationId() {
      return awsXRay.utils.processTraceData(process.env._X_AMZN_TRACE_ID).Root;
    }
  },
  transports: [
    new winston.transports.Console({
      format: winston.format.simple()
    })
  ]
});
