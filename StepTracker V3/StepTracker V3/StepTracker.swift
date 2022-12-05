//
//  ViewController.swift
//  StepTracker v3
//
//  Created by taih on 11/30/22.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    //One outlet is a label for the steps
    //The other outlet is a UI image
    @IBOutlet weak var actualSteps: UILabel!
    @IBOutlet weak var steptrackImage: UIImageView!
    
    let manager = CMMotionActivityManager()
    let pedometer: CMPedometer = CMPedometer()

   
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
        
    
    }
    
    private func updateSteps(){
        if CMPedometer.isStepCountingAvailable(){
            self.pedometer.startUpdates(from: Date()) { (data, error) in
                            if error == nil {
                                if let response = data {
                                    DispatchQueue.main.async { [self] in
                                        print("Number Of Steps == \(response.numberOfSteps)")
                                        actualSteps.text = "Step Counter : \(response.numberOfSteps)"
                                    }
                                }
                            }
                        }
            }
    }

}


