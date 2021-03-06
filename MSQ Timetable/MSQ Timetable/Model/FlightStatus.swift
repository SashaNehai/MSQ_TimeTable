//
//  File.swift
//  MSQ Timetable
//
//  Created by Александр Нехай on 1/16/20.
//  Copyright © 2020 AlexanderNehai. All rights reserved.
//

import Foundation

enum FlightStatus: String {
    case aiborne = "Airborne"
    case arrived = "Arrived"
    case leaving = "Leaving"
    case landed = "Landed"
    case departed = "Departed"
    case boarding = "Boarding"
    case enroute = "En route"
    case checkin = "Check-in"
    case delayed = "Delayed"
    case cancelled = "Cancelled"
}

import UIKit
extension FlightStatus {
    var color: UIColor {
        switch self {
        case .aiborne:
            return UIColor(red: 46/255.0, green: 169/255.0, blue: 35/255.0, alpha: 1.0)
        case .arrived:
            return UIColor(red: 46/255.0, green: 169/255.0, blue: 35/255.0, alpha: 1.0)
        case .leaving:
            return UIColor(red: 46/255.0, green: 169/255.0, blue: 35/255.0, alpha: 1.0)
        case .landed:
            return UIColor(red: 46/255.0, green: 169/255.0, blue: 35/255.0, alpha: 1.0)
        case .departed:
            return UIColor(red: 46/255.0, green: 169/255.0, blue: 35/255.0, alpha: 1.0)
        case .boarding:
            return UIColor(red: 17/255.0, green: 10/255.0, blue: 139/255.0, alpha: 1.0)
        case .enroute:
            return UIColor(red: 17/255.0, green: 10/255.0, blue: 139/255.0, alpha: 1.0)
        case .checkin:
            return UIColor(red: 255/255.0, green: 239/255.0, blue: 0/255.0, alpha: 1.0)
        case .delayed:
            return UIColor(red: 185/255.0, green: 28/255.0, blue: 20/255.0, alpha: 1.0)
        case .cancelled:
            return UIColor(red: 185/255.0, green: 28/255.0, blue: 20/255.0, alpha: 1.0)
        }
    }
}

