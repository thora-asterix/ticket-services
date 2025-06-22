package com.pnc.demo.ticket_services.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/tickets")
public class TicketController {

    @GetMapping
    public String allTickets() {
        return "Here are all the tickets";
    }

}
