//
//  DetailedFoodView.swift
//  LiveliGoods
//
//  Created by Griffin Lorimer on 11/30/22.
//

import Foundation
import UIKit
import FirebaseFirestore

class DetailedFoodView: UIViewController {
    
    var foodName:String!
    var calories:Int!
    var fat:Int!
    var protein:Int!
    var carbs:Int!
    var quantity = 1
    
    // labels
    var stepLabel: UILabel!
    var foodLabel: UILabel!
    var calorieLabel: UILabel!
    var proteinLabel: UILabel!
    var fatLabel: UILabel!
    var carbLabel: UILabel!
    
    var currentCals = 0

    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white

        
        // food name
        let foodNameRect = CGRect(x: 120, y: 120, width: 150, height: 50)
        foodLabel = UILabel(frame: foodNameRect)
        foodLabel.text = foodName
        foodLabel.textAlignment = .center
        view.addSubview(foodLabel)
        
        // cals
        let calorieRect = CGRect(x: 120, y: 180, width: 150, height: 50)
        calorieLabel = UILabel(frame: calorieRect)
        calorieLabel.text = "calories: \(String(calories))g"
        calorieLabel.textAlignment = .center
        view.addSubview(calorieLabel)
        currentCals = calories
        
        // protein
        let proteinRect = CGRect(x: 120, y: 220, width: 150, height: 50)
        proteinLabel = UILabel(frame: proteinRect)
        proteinLabel.text = "protein: \(String(protein))g"
        proteinLabel.textAlignment = .center
        view.addSubview(proteinLabel)
        
        // fat
        let fatRect = CGRect(x: 120, y: 260, width: 150, height: 50)
        fatLabel = UILabel(frame: fatRect)
        fatLabel.text = "fat: \(String(fat))g"
        fatLabel.textAlignment = .center
        view.addSubview(fatLabel)
        
        // carb
        let carbRect = CGRect(x: 120, y: 300, width: 150, height: 50)
        carbLabel = UILabel(frame: carbRect)
        carbLabel.text = "carbs: \(String(carbs))g"
        carbLabel.textAlignment = .center
        view.addSubview(carbLabel)
        
        // setup stepper label
        let stepperRect = CGRect(x: 120, y: 400, width: 150, height: 50)
        stepLabel = UILabel(frame: stepperRect)
        stepLabel.text = "quantity: \(quantity)"
        stepLabel.textAlignment = .center
        view.addSubview(stepLabel)

        
        
        // setup stepper (https://www.appsdeveloperblog.com/uistepper-in-swift-programmatically/)
        let stepRect = CGRect(x: 150, y: 500, width: 150, height: 50)
        let stepper = UIStepper(frame: stepRect)
        stepper.maximumValue = 20
        stepper.minimumValue = 1
        stepper.wraps = false
        stepper.addTarget(self,  action: #selector(stepperValueChanged(_:)), for: .valueChanged)
        view.addSubview(stepper)
        
        // setup button (https://programmingwithswift.com/add-uibutton-programmatically-using-swidt/)
        let button = UIButton(frame: CGRect(x: 120,y: 600,width: 150,height: 60))
        button.setTitle("EAT", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self,  action: #selector(buttonPressed), for: .touchUpInside)
        view.addSubview(button)
        
    }
    

    @objc func stepperValueChanged(_ sender:UIStepper!)
      {
          quantity = Int(sender.value)
          stepLabel.text = "quantity: \(quantity)"
          calorieLabel.text = "calories: \(String(calories * quantity))"
          proteinLabel.text = "protein: \(String(protein * quantity))g"
          fatLabel.text = "fat: \(String(fat * quantity))g"
          carbLabel.text = "carbs: \(String(carbs * quantity))g"
          currentCals = calories * quantity
          print(currentCals)

          
      }
    
    
    @objc func buttonPressed(){
        print("button pressed")
        print(globalName)
        
        var db = Firestore.firestore()
        var alreadyInDB = false
        
        db.collection("users")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let nam = document.data()["name"] as? String ?? "FAIL"
                        let dat = document.data()["date"] as? String ?? "FAIL"
                        var count = document.data()["currentCalCount"] as? Int ?? 0
                        count += self.currentCals
                        if (nam == globalName){
                            db.collection("users").document(document.documentID).updateData(["currentCalCount": count])
                            
                        }
                    }

                }
        }
        
        
        
        navigationController?.popViewController(animated: true)
//        navigationController.back
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
