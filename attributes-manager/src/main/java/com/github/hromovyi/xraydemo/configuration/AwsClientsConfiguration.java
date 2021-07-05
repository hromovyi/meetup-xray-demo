package com.github.hromovyi.xraydemo.configuration;

import com.amazonaws.services.dynamodbv2.AmazonDynamoDB;
import com.amazonaws.services.dynamodbv2.AmazonDynamoDBClientBuilder;
import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBMapper;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class AwsClientsConfiguration {

    @Bean
    public DynamoDBMapper mapper() {
        AmazonDynamoDB client = AmazonDynamoDBClientBuilder.standard()
                .build();
        return new DynamoDBMapper(client);
    }
}
