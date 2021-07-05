package com.github.hromovyi.xraydemo.entity;

import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBAttribute;
import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBHashKey;
import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBTable;
import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBTypeConvertedEnum;
import com.github.hromovyi.xraydemo.Constants;

@DynamoDBTable(tableName = Constants.TableNames.HOTEL_TABLE_NAME)
public class Hotel {
    @DynamoDBHashKey
    private String uuid;
    @DynamoDBAttribute
    private String name;
    @DynamoDBAttribute
    private String address;
    @DynamoDBAttribute
    @DynamoDBTypeConvertedEnum
    private Constants.ViewType viewType;

    public String getUuid() {
        return uuid;
    }

    public Hotel setUuid(String uuid) {
        this.uuid = uuid;
        return this;
    }

    public String getName() {
        return name;
    }

    public Hotel setName(String name) {
        this.name = name;
        return this;
    }

    public String getAddress() {
        return address;
    }

    public Hotel setAddress(String address) {
        this.address = address;
        return this;
    }

    public Constants.ViewType getViewType() {
        return viewType;
    }

    public Hotel setViewType(Constants.ViewType viewType) {
        this.viewType = viewType;
        return this;
    }
}
