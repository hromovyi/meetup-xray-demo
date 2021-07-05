package com.github.hromovyi.xraydemo.controller;

import com.github.hromovyi.xraydemo.entity.Room;
import com.github.hromovyi.xraydemo.repository.Rooms;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/room")
public class RoomController {
    private final Logger log = LoggerFactory.getLogger(this.getClass());
    private final Rooms rooms;

    public RoomController(Rooms rooms) {
        this.rooms = rooms;
    }

    @GetMapping("/{hotelUuid}")
    public List<Room> getRooms(@PathVariable String hotelUuid) {
        log.info("Getting rooms by hotel uuid [{}]", hotelUuid);
        return rooms.getRooms(hotelUuid);
    }
}
