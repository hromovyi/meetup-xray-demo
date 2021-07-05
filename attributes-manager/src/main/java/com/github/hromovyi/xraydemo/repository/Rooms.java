package com.github.hromovyi.xraydemo.repository;

import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBMapper;
import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBQueryExpression;
import com.github.hromovyi.xraydemo.entity.Room;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class Rooms {
    private final DynamoDBMapper mapper;

    public Rooms(DynamoDBMapper mapper) {
        this.mapper = mapper;
    }

    public List<Room> getRooms(String hotelUuid) {
        DynamoDBQueryExpression<Room> query = new DynamoDBQueryExpression<>();
        query.setHashKeyValues(new Room().setHotelUuid(hotelUuid));
        return mapper.query(Room.class, query);
    }
}
