package com.github.hromovyi.xraydemo.controller;

import com.github.hromovyi.xraydemo.entity.Hotel;
import com.github.hromovyi.xraydemo.repository.Hotels;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/hotel")
public class HotelController {
    private final Logger log = LoggerFactory.getLogger(this.getClass());
    private final Hotels hotels;

    public HotelController(Hotels hotels) {
        this.hotels = hotels;
    }

    @GetMapping("/{hotelUuid}")
    public Hotel getHotel(@PathVariable String hotelUuid) {
        log.info("Getting hotel by uuid [{}]", hotelUuid);
        return hotels.getHotel(hotelUuid);
    }
}
