//
//  ViewController.swift
//  StepTracker v3
//
//  Created by taih on 11/30/22.
//

import UIKit
import CoreMotion
import FirebaseFirestore


class StepTracker: UIViewController {

    //One outlet is a label for the steps
    //The other outlet is a UI image
    
    @IBOutlet weak var steptrackImage: UIImageView!
    @IBOutlet weak var actualSteps: UILabel!
    
    let manager = CMMotionActivityManager()
    let pedometer: CMPedometer = CMPedometer()
    var db = Firestore.firestore()
    var stepCount = 0
    var oldCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //CMMotion functionality source: https://www.youtube.com/watch?v=3tzje_FSdpY
        
        steptrackImage.image = UIImage(named: "stand.png")

        
        if CMMotionActivityManager.isActivityAvailable() {
            self.manager.startActivityUpdates(to: OperationQueue.main) { (data) in
                DispatchQueue.main.async { [self] in
                                if let activity = data {
                                    if activity.running == true {
                                        print("Running")
                                        steptrackImage.image = UIImage(named: "running.png")
                                    }else if activity.walking == true {
                                        print("Walking")
                                        steptrackImage.image = UIImage(named: "walk.png")
                                    }else if activity.automotive == true {
                                        print("Automative")
                                        steptrackImage.image = UIImage(named: "car.png")
                                    }else{
                                        print("Standing")
                                        steptrackImage.image = UIImage(named: "stand.png")
                                    }
                                }
                    
                            }
                        }
            
            updateSteps()
            
        }
        
        db.collection("users")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let nam = document.data()["name"] as? String ?? "FAIL"
                        let count = document.data()["steps"] as? Int ?? 0
                        if (nam == globalName){
                            self.oldCount = count
                            self.actualSteps.text = String(self.oldCount)
                        }
                    }
                }
        }
        
    
    }
    
    private func updateSteps(){
        print("called")
        if CMPedometer.isStepCountingAvailable(){
            print("called2")

            self.pedometer.startUpdates(from: Date()) { (data, error) in
                            if error == nil {
                                if let response = data {
                                    DispatchQueue.main.async { [self] in
//                                        stepCount +=
         
                                        actualSteps.text = String(self.stepCount)
//                                        self.db
                                        db.collection("users")
                                            .getDocuments() { [self] (querySnapshot, err) in
                                                if let err = err {
                                                    print("Error getting documents: \(err)")
                                                } else {
                                                    for document in querySnapshot!.documents {
                                                        let nam = document.data()["name"] as? String ?? "FAIL"
                                                        if (nam == globalName){
                                                            self.stepCount = Int(truncating: response.numberOfSteps) + oldCount
                                                            globalSteps = Int(truncating: response.numberOfSteps) + oldCount
                                                            db.collection("users").document(document.documentID).updateData(["steps": self.stepCount])
                                                        }
                                                    }
                                            }
                                        }
                                    }
                                }
                            }
                        }
            }
    }

}


