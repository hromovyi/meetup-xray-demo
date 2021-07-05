package com.github.hromovyi.xraydemo.entity;

import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBAttribute;
import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBHashKey;
import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBRangeKey;
import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBTable;
import com.github.hromovyi.xraydemo.Constants;

@DynamoDBTable(tableName = Constants.TableNames.ROOM_TABLE_NAME)
public class Room {
    @DynamoDBRangeKey
    private String uuid;
    @DynamoDBHashKey
    private String hotelUuid;
    @DynamoDBAttribute
    private String name;
    @DynamoDBAttribute
    private Integer occupancy;

    public String getUuid() {
        return uuid;
    }

    public Room setUuid(String uuid) {
        this.uuid = uuid;
        return this;
    }

    public String getHotelUuid() {
        return hotelUuid;
    }

    public Room setHotelUuid(String hotelUuid) {
        this.hotelUuid = hotelUuid;
        return this;
    }

    public String getName() {
        return name;
    }

    public Room setName(String name) {
        this.name = name;
        return this;
    }

    public Integer getOccupancy() {
        return occupancy;
    }

    public Room setOccupancy(Integer occupancy) {
        this.occupancy = occupancy;
        return this;
    }
}
