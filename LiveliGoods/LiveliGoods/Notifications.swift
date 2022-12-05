//
//  Notifications.swift
//  NotificationSystem
//
//  Created by Lev Rose on 11/29/22.
//

import Foundation
import UserNotifications



class Notifications{
    var foodIntv: String?
    var drinkIntv: String?
    var walkIntv: String?
    
    var foodDates:[DateComponents]?
    var drinkDates:[DateComponents]?
    var walkDates:[DateComponents]?
    
    
    var foodOn: Bool?
    var drinkOn: Bool?
    var walkOn: Bool?
    

    
    
    public func resetIntervals(food: String, drink: String, walk: String){
        foodIntv = food
        drinkIntv = drink
        walkIntv = walk
        
        
        loadNotifications()
    }
    
    
    
    
    public func resetAciveNotifications(food: Bool, drink: Bool, walk: Bool){
        
        foodOn = food
        drinkOn = drink
        walkOn = walk
        
        
        
    }
    
    func determineTimes(notf: String, id: String) -> [DateComponents]{
        
        var nullDate = DateComponents()
        nullDate.year = 1970
        
        var morn = DateComponents()
        morn.hour = 8
        morn.minute = 0
        
        var snack1 = DateComponents()
        snack1.hour = 10
        snack1.minute = 0
        
        var noon = DateComponents()
        noon.hour = 12
        noon.minute = 0
        
        var snack2 = DateComponents()
        snack2.hour = 14
        snack2.minute = 0
        
        var eve = DateComponents()
        eve.hour = 19
        eve.minute = 0
        
        var dates:[DateComponents] = Array(repeating: nullDate, count: 5)
        
        var key: String
        if (id == "food"){
            key = "eatSwitch"
        }else if (id == "drink"){
            key = "drinkSwitch"
        } else{
            key = "moveSwitch"
        }
        
        
//
        if (notf == "None" || UserDefaults.standard.bool(forKey: key) == false){
            for i in 0..<dates.count{
                dates[i] = nullDate
            }
            return dates
        }
        
        if (notf == "Daily"){
            dates[0] = noon
            for i in 1..<dates.count{
                dates[i] = nullDate
            }
            return dates
        }
        
        if (notf == "Semi-Regularly"){
            dates[0] = morn
            dates[1] = noon
            dates[2] = eve
            for i in 3..<dates.count{
                dates[i] = nullDate
            }
            return dates
        }
        
        if (notf == "Regularly"){
            dates[0] = morn
            dates[1] = noon
            dates[2] = eve
            dates[3] = snack1
            dates[4] = snack2
            return dates
        }
        
        
        return dates
        
    }
    
     public func loadNotifications(){
        let center = UNUserNotificationCenter.current()
        
        
        //asking permission
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error ) in
        }
        
        //set notification content
        let eatNotf = UNMutableNotificationContent()
        eatNotf.title = "Rember to Eat!"
         eatNotf.body = "If you're hungry, you should get a snack!"
         
         let drinkNotf = UNMutableNotificationContent()
         drinkNotf.title = "Rember to Drink!"
          drinkNotf.body = "Make sure to stay hydrated!"
         
         let walkNotf = UNMutableNotificationContent()
         walkNotf.title = "Rember to Move!"
          walkNotf.body = "Get a nice streach in!"

         
         let foodID = "food"
         let drinkID = "drink"
          let walkID = "walk"
          
         
         //food timing
         foodDates = determineTimes(notf: foodIntv!, id: foodID)
         for i in foodDates!{
             let rep = (i.year == nil)
             if (rep){
                 let trigger = UNCalendarNotificationTrigger(dateMatching: i, repeats: rep)
                 let request = UNNotificationRequest(identifier: foodID, content: eatNotf, trigger: trigger)
                 center.add(request) { (error ) in }
             }
         }
         
         
         //drink timing
         
         drinkDates = determineTimes(notf: drinkIntv!, id: drinkID)
         for i in drinkDates!{
             let rep = (i.year == nil)
             if (rep){
                 let trigger = UNCalendarNotificationTrigger(dateMatching: i, repeats: rep)
                 let request = UNNotificationRequest(identifier: drinkID, content: drinkNotf, trigger: trigger)
                 center.add(request) { (error ) in }
             }
         }
         
        //walk timing
         
         walkDates = determineTimes(notf: walkIntv!, id: walkID)
         for i in walkDates!{
             let rep = (i.year == nil)
             if (rep){
                 let trigger = UNCalendarNotificationTrigger(dateMatching: i, repeats: rep)
                 let request = UNNotificationRequest(identifier: walkID, content: walkNotf, trigger: trigger)
                 center.add(request) { (error ) in }
             }
         }
        
         
    }
}

