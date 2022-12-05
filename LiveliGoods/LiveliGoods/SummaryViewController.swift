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
//    UserDefaults.standard.set(calGoal, forKey: "calGoal")
//    UserDefaults.standard.set(drinkGoal, forKey: "drinkGoal")
//    UserDefaults.standard.set(stepGoal, forKey: "stepGoal")

    var journalGoal = 0
    var timesJournaled = 0
    
    var stepsGoal = UserDefaults.standard.object(forKey: "stepGoal") as? Int ?? 0
    var stepsDone = globalSteps
    
    var mealGoal = UserDefaults.standard.object(forKey: "calGoal") as? Int ?? 0
    var mealsAte = 0

    var waterGoal = UserDefaults.standard.object(forKey: "drinkGoal") as? Int ?? 0
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
        
        update()
       
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
        mealGoal = UserDefaults.standard.integer(forKey: "calGoal")
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
        waterNotification.text = "\(waterDrank)oz /day"
        waterProgress.setProgress(Float(waterPercent), animated: true)
        var mealGoalFlag = mealGoal-mealsAte
        if (mealGoalFlag <= 0){
            mealGoalFlag = 0
        }

        var waterGoalFlag = waterGoal-waterDrank
        if (waterGoalFlag <= 0){
            waterGoalFlag = 0
        }
        if mealsAte == mealGoal && waterGoal == waterDrank {
            nutritionMessage.text = "Full for today!"
        }
        else if waterGoal == waterDrank {
            nutritionMessage.text = "Water goal met. \(mealGoalFlag) meals left."
        }
        else if mealsAte == mealGoal  {
            nutritionMessage.text = "Meal goal met. \(waterGoalFlag) oz. water left to drink."
        }
        else {
            nutritionMessage.text = "\(mealGoalFlag) calories left. \(waterGoalFlag) oz. water left to drink."
        }
        UserDefaults.standard.object(forKey: "calGoal") as? Int ?? 0
    }
    
    
    /*
     // MARK: - Steps tracker
     -steps tracker button pressed -> move to that screen
     -steps/day message: updated everytime
      -- update progress view too
     -motivational message : updated three times a day
     */
   
    
    func stepInfoUpdate() {
        stepsDone = globalSteps
        stepsGoal = UserDefaults.standard.integer(forKey: "stepGoal")
        if (stepsGoal < 1){
            stepsGoal = 1
        }
        var stepsGoalFlag = stepsGoal-stepsDone
        if (stepsGoalFlag <= 0){
            stepsGoalFlag = 0
        }
        let stepsPercent =  stepsDone / stepsGoal
        stepsNotification.text = "\(stepsDone) steps/day"
        stepsProgress.setProgress(Float(stepsPercent), animated: true)
        if stepsDone == stepsGoal {
            stepsMessage.text = "Steps goal met!"
        }
        else {
            stepsMessage.text = "\(stepsGoalFlag) steps left."
        }
        stepsGoal = UserDefaults.standard.object(forKey: "stepGoal") as? Int ?? 0
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        update()
    }
    
    func update(){
        
        print(globalWater)
        var wat = 0
        for water in globalWater {
            var split = water.components(separatedBy: " at ")
            print(split[0].replacingOccurrences(of: "oz", with: ""))
            wat += Int(split[0].replacingOccurrences(of: "oz", with: "")) ?? 0
        }
        waterDrank = wat
        
        
        var cals = 0
        
        for breakfast in globalBreakFast {
            var split = breakfast.components(separatedBy: ": ")
            var cal = split[1].replacingOccurrences(of: " calories", with: "")
            cals += Int(cal) ?? 0
        }
        
        for lunch in globalLunch {
            var split = lunch.components(separatedBy: ": ")
            var cal = split[1].replacingOccurrences(of: " calories", with: "")
            cals += Int(cal) ?? 0
        }
        
        for dinner in globalDinner {
            var split = dinner.components(separatedBy: ": ")
            var cal = split[1].replacingOccurrences(of: " calories", with: "")
            cals += Int(cal) ?? 0
        }
        
        mealsAte = cals
        
        UserDefaults.standard.object(forKey: "drinkGoal") as? Int ?? 0
        nutritionInfoUpdate()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        stepInfoUpdate()
        update()
    }
    

}
