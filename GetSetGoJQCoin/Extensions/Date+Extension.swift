//
//  Date+Extension.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 5/16/19.
//  Copyright © 2019 ekbana. All rights reserved.
//

import Foundation

extension Date {
    
    func interval(ofComponent comp: Calendar.Component, fromDate date: Date) -> Int {
        
        let currentCalendar = Calendar.current
        guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else { return 0 }
        guard let end = currentCalendar.ordinality(of: comp, in: .era, for: self) else { return 0 }
        return end - start
    }
    
}

extension String {
    
    func getDay() -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from:self)!
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        return day
    }
    
    func getElapsedInterval() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from:self)!
        let interval = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date, to: Date())
        
        if let year = interval.year, year > 0 {
            return year == 1 ? "\(year)" + " " + "\(GlobalConstants.Localization.year) \(GlobalConstants.Localization.ago)" :
                "\(year)" + " " + "\(GlobalConstants.Localization.years) \(GlobalConstants.Localization.ago)"
        } else if let month = interval.month, month > 0 {
            return month == 1 ? "\(month)" + " " + "\(GlobalConstants.Localization.month) \(GlobalConstants.Localization.ago)" :
                "\(month)" + " " + "\(GlobalConstants.Localization.months) \(GlobalConstants.Localization.ago)"
        } else if let day = interval.day, day > 0 {
            return day == 1 ? "\(day)" + " " + "\(GlobalConstants.Localization.day) \(GlobalConstants.Localization.ago)" :
                "\(day)" + " " + "\(GlobalConstants.Localization.days) \(GlobalConstants.Localization.ago)"
        } else if let hour = interval.hour, hour > 0 {
            return hour == 1 ? "\(hour)" + " " + "\(GlobalConstants.Localization.hour) \(GlobalConstants.Localization.ago)" :
                "\(hour)" + " " + "\(GlobalConstants.Localization.hours) \(GlobalConstants.Localization.ago)"
        } else if let minute = interval.minute, minute > 0 {
            return minute == 1 ? "\(minute)" + " " + "\(GlobalConstants.Localization.minute) \(GlobalConstants.Localization.ago)" :
                "\(minute)" + " " + "\(GlobalConstants.Localization.minutes) \(GlobalConstants.Localization.ago)"
        } else if let second = interval.second, second > 0 {
            return second == 1 ? "\(second)" + " " + "\(GlobalConstants.Localization.second) \(GlobalConstants.Localization.ago)" :
                "\(second)" + " " + "\(GlobalConstants.Localization.seconds) \(GlobalConstants.Localization.ago)"
        } else {
            return "\(GlobalConstants.Localization.moment) \(GlobalConstants.Localization.ago)"
        }
        
    }
    
}
