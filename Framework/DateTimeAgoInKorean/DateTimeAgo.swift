//
//  DateTimeAgo.swift
//  DateTimeAgoInKorean
//
//  Created by simon on 2018. 9. 13..
//  Copyright © 2018년 simon. All rights reserved.
//

import Foundation

public extension Date {
    
    private enum Units: String {
        case year = "년전"
        case month = "달전"
        case week = "주전"
        case day = "일전"
        case yesterday = "어제"
        case hour = "시간전"
        case minute = "분전"
        case now = "방금전"
    }
    
    public func timeAgo(since date:Date) -> String {
        let calendar = NSCalendar.current
        let flags = Set<Calendar.Component>([.second,.minute,.hour,.day,.weekOfYear,.month,.year])
        let earliest = (self.timeIntervalSince1970 <= date.timeIntervalSince1970) ? self : date
        let latest = (earliest == self) ? date : self
        let components = calendar.dateComponents(flags, from: earliest, to: latest)
        
        return self.localizedString(component: components)
    }
    
    private func localizedString(component: DateComponents) -> String {
        
        if let y = component.year, y > 0 {
            return String(component.year!) + Units.year.rawValue
        }
        else if let m = component.month, m > 0 {
            return String(component.month!) + Units.month.rawValue
        }
        else if let w = component.weekOfYear, w > 0 {
            return String(component.month!) + Units.week.rawValue
        }
        else if let d = component.day, d > 0 {
            return d == 1 ? Units.yesterday.rawValue : String(component.day!) + Units.day.rawValue
        }
        else if let h = component.hour, h > 0 {
            return String(component.hour!) + Units.hour.rawValue
        }
        else if let min = component.minute, min > 2 {
            return String(component.minute!) + Units.minute.rawValue
        }
        return Units.now.rawValue
    }
}

