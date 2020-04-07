//
//  Flight.swift
//  MSQ Timetable
//
//  Created by Александр Нехай on 4/4/20.
//  Copyright © 2020 AlexanderNehai. All rights reserved.
//

import Foundation

struct FlightDetail: Decodable {
    var flightId: String
    var flight: String
    var airport: Airport
    var plan: String?
    var status: Status
    var fact: String?
    var airline: Airline
    var aircraft: Aircraft
    var gate: String
    var eat: String?
}

struct Airport: Decodable {
    var title: String?
}

struct Status: Decodable {
    var id: String?
    var title: String?
}

struct Airline: Decodable {
    var title: String?
    var logo: Logo
}

struct Logo: Decodable {
    var path: String?
}

struct Aircraft: Decodable {
    var title: String?
}

