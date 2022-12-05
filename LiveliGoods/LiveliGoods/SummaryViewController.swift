//
//  SummaryViewController.swift
//  LiveliGoods
//
//  Created by Sproull Student on 11/15/22.
//

import UIKit

class SummaryViewController: UIViewController {

    @IBOutlet weak var reminderMessage: UILabel! // motivational quotes from API
    
    
    @IBOutlet weak var mealsNotificaion: UILabel!
    @IBOutlet weak var mealsProgress: UIProgressView!
    @IBOutlet weak var waterNotification: UILabel!
    @IBOutlet weak var waterProgress: UIProgressView!
    @IBOutlet weak var nutritionMessage: UILabel!
    
    @IBOutlet weak var stepsNotification: UILabel!
    @IBOutlet weak var stepsProgress: UIProgressView!
    @IBOutlet weak var stepsMessage: UILabel!
    
    @IBOutlet weak var journalMessage: UILabel!
    @IBOutlet weak var journalNotification: UILabel!
    @IBOutlet weak var journalProgress: UIProgressView!
    
    //Journal Summary
    var journalGoal = 0
    var timesJournaled = 0
    
    var stepsGoal = 0
    var stepsDone = 0
    
    var mealGoal = 0 // snacks and meals combined
    var mealsAte = 0

    var waterGoal = 0
    var waterDrank = 0
    
    var apiKey = "oXFJ0OJVa45z0BZiCb1BYA==0xRS1WXuFVfZRRg0"
    // request url = https://api.api-ninjas.com/apiKey/quotes?category=inspirational
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        loadData()
        nutritionInfoUpdate()
        stepInfoUpdate()
        journalInfoUpdate()
        print("hello")
       
        // Do any additional setup after loading the view.
    }
    // only to be done at beginning of each day
//    DispatchQueue.global().async {
//        self.fetchData()
//
//        DispatchQueue.main.async {

//        }
//    }
    // fetch data
    
//    func loadData() {
//        do {
//                let category = "inspirational".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//                let url = URL(string: "https://api.api-ninjas.com/v1/quotes?category="+category!)!
//
//
//                var request = URLRequest(url: url)
//                request.httpMethod = "GET"
//                request.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")
//
//                var quoteData: [QuoteAPIResults] = []
//                let session = URLSession.shared
//                let task = session.dataTask(with: request) { (data, response, error) in
//
//                    if let error = error {
//                        // Handle HTTP request error
//                        print(error)
//                    } else if let data = data, let responseString = String(data: data, encoding: .utf8) {
//                        // Handle HTTP request response
//                        print(responseString)
//                        quoteData = [try! JSONDecoder().decode([QuoteAPIResults].self, from:data)]
//                        let res = quoteData[0].results[0]
//                        self.reminderMessage.text = res.quote
////                        if let res = quoteData?.results[0] {
////                            print(res)
////                            self.reminderMessage.text = res
////                        }
//            //                    list = theData?.results
//                    } else {
//                        // Handle unexpected error
//                        print("unexpected error")
//                    }
//            }
//            task.resume()
//        }
//        }
//    let category = "inspirational".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//    let url = URL(string: "https://api.api-ninjas.com/v1/quotes?category="+category!)!
//
//
//    var request = URLRequest(url: url)
//    request.httpMethod = "GET"
//    request.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")
//
//    var quoteData: QuoteAPIResults?
//    let session = URLSession.shared
//    let task = session.dataTask(with: request) { (data, response, error) in
//
//        if let error = error {
//            // Handle HTTP request error
//            print(error)
//        } else if let data = data, let responseString = String(data: data, encoding: .utf8) {
//            // Handle HTTP request response
//            print(responseString)
//            quoteData = try! JSONDecoder().decode(QuoteAPIResults.self, from:data)
//            if let res = quoteData?.results[0].quote {
//                print(res)
//                self.reminderMessage.text = res
//            }
////                    list = theData?.results
//        } else {
//            // Handle unexpected error
//            print("unexpected error")
//        }
 
    
    
    /*
     // MARK: - Reminder message
      Reminder message to be set, would be set in the morning, afternoon and at night?
     */
    var timeOfDay = ""
   
    
    func updateReminder() { // update reminders button, nutritional tracker message, steps tracker message and set journal message
            stepsMessage.text = "message tailored to their goals that day"
            journalMessage.text = "question for the day and motivation"
     
            nutritionMessage.text = " message tailored to their goals that day"
            stepsMessage.text = "message tailored to their goals that day"
//            nutritionMessage.text = " message tailored to their goals that day"
//            stepsMessage.text = "message tailored to their goals that day"
            journalMessage.text = "motivational message for tomorrow"
        
    }
    
    
    /*
     // MARK: - Nutritional tracker
    -nutritional tracker button pressed -> move to that screen
    -meals and snacks message: updated everytime log they ate
     -- update progress view too
    -water left to drink message: updated everytime log amount of water they drank
     -- update progress view too
     */
    

    
    func nutritionInfoUpdate() {
        // check if have logged water or food intake and updates both labels and progress views
        mealGoal = UserDefaults.standard.integer(forKey: "eatReminders")
        waterGoal = UserDefaults.standard.integer(forKey: "drinkGoal")
        if (mealGoal < 1){
            mealGoal = 1
        }
        if (waterGoal < 1){
            waterGoal = 1
        }
        let mealsPercent =  mealsAte / mealGoal
        let waterPercent =  waterDrank / waterGoal
        mealsNotificaion.text = "\(mealsAte) /day"
        mealsProgress.setProgress(Float(mealsPercent), animated: true)
        waterNotification.text = "\(waterDrank) /day"
        waterProgress.setProgress(Float(waterPercent), animated: true)
        if mealsAte == mealGoal && waterGoal == waterDrank {
            nutritionMessage.text = "Full for today!"
        }
        else if waterGoal == waterDrank {
            nutritionMessage.text = "Water goal met. \(mealGoal-mealsAte) meals left."
        }
        else if mealsAte == mealGoal  {
            nutritionMessage.text = "Meal goal met. \(waterGoal-waterDrank) oz. water left to drink."
        }
        else {
            nutritionMessage.text = "\(mealGoal-mealsAte) meals left. \(waterGoal-waterDrank) oz. water left to drink."
        }
    }
    
    
    /*
     // MARK: - Steps tracker
     -steps tracker button pressed -> move to that screen
     -steps/day message: updated everytime
      -- update progress view too
     -motivational message : updated three times a day
     */
   
    
    func stepInfoUpdate() {
        stepsGoal = UserDefaults.standard.integer(forKey: "stepGoal")
        if (stepsGoal < 1){
            stepsGoal = 1
        }
        let stepsPercent =  stepsDone / stepsGoal
        stepsNotification.text = "\(stepsDone) /day"
        stepsProgress.setProgress(Float(stepsPercent), animated: true)
        if stepsDone == stepsGoal {
            stepsMessage.text = "Steps goal met!"
        }
        else {
            stepsMessage.text = "\(stepsGoal-stepsDone) steps left."
        }
        
        // if reach
    }
    
    /*
     // MARK: - Liviligoods journal
     -livligoods journal button pressed -> move to that screen
     -journal/day: updated everytime write into it (minimum need to write for it to update?)
      -- update progress view too everytime write into journal
     -motivational message : updated three times a day
     */

    
    func journalInfoUpdate() {
        // get journal goal for the day and times that have journaled
        if (journalGoal < 1){
            journalGoal = 1
        }
        let journalPercent =  timesJournaled / journalGoal
        journalNotification.text = "\(timesJournaled) /week"
        journalProgress.setProgress(Float(journalPercent), animated: true)
     
    }
    

    

}
