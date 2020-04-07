//
//  DateInteractor.swift
//  MSQ Timetable
//
//  Created by Александр Нехай on 4/7/20.
//  Copyright © 2020 AlexanderNehai. All rights reserved.
//

import Foundation

class DateInteractor {

    static func isToday(date: String) -> Bool {
        return today() == dateString(date)
    }
    
    static func time(timestamp: String) -> String {
        guard let dat = date(timestamp) else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: dat)
    }
    
    private static func today() -> String {
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: today)
    }
    
    private static func date(_ timestamp: String) -> Date? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = .withInternetDateTime
        return formatter.date(from: timestamp)
    }
    
    private static func dateString(_ timestamp: String) -> String {
           let formatter = ISO8601DateFormatter()
           formatter.formatOptions = .withFullDate
           guard let date = formatter.date(from: timestamp) else { return "" }
           let dateString = formatter.string(from: date)
           return dateString
    }

}
