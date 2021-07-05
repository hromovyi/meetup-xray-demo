package com.github.hromovyi.xraydemo.repository;

import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBMapper;
import com.github.hromovyi.xraydemo.entity.Hotel;
import org.springframework.stereotype.Repository;

@Repository
public class Hotels {
    private final DynamoDBMapper mapper;

    public Hotels(DynamoDBMapper mapper) {
        this.mapper = mapper;
    }

    public Hotel getHotel(String hotelUuid) {
        return mapper.load(Hotel.class, hotelUuid);
    }
}
