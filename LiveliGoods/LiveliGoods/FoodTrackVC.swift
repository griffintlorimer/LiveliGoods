//
//  ViewController.swift/Users/sproullstudent/Desktop/foodvc/foodvc/FoodVC.swift
//  FoodTrackVC
//
//  Created by Sproull Student on 12/2/22.
//

import UIKit
import FirebaseFirestore

class FoodTrackVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //STORING DATA VARIABLES
    var breakfastList: [String] = []
    var lunchList: [String] = []
    var dinnerList: [String] = []
    var waterList: [String] = []
    var db = Firestore.firestore()

    //BUTTONS CONTENT
    func setupMenu() -> UIMenu{
        let action1 = UIAction(title: "Scan", image: UIImage(systemName: "camera.fill")){
            (action) in print("")
            let scanScreen = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ScanVC") as? ScanVC
            self.navigationController!.pushViewController(scanScreen!, animated:true)
        }
        let action2 = UIAction(title: "Search"){
            // change the id name and the type of class
            (action) in
            let searchScreen = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FoodInput") as? FoodInput
            self.navigationController!.pushViewController(searchScreen!, animated:true)
        }
        let menu = UIMenu(title: "Actions", options: .displayInline ,children: [action1 , action2])
        return menu
    }
    @IBOutlet weak var breakfastButton: UIButton!
    
    @IBAction func breakFastButtonClicked(_ sender: Any) {
            globalMeal = "breakfast"
                breakfastButton.menu = setupMenu()
                breakfastButton.showsMenuAsPrimaryAction = true
    }
    
    @IBOutlet weak var lunchButton: UIButton!
    @IBAction func lunchButtonClicked(_ sender: Any) {
        globalMeal = "lunch"
        lunchButton.menu = setupMenu()
        lunchButton.showsMenuAsPrimaryAction = true
    }
    
    @IBOutlet weak var dinnerButton: UIButton!
    @IBAction func dinnerButtonClicked(_ sender: Any) {
        globalMeal = "dinner"
        dinnerButton.menu = setupMenu()
        dinnerButton.showsMenuAsPrimaryAction = true
    }
    
    @IBOutlet weak var waterButton: UIButton!
    @IBAction func waterButtonClicked(_ sender: Any) {
        let alertController = UIAlertController(title: "Stay hydrated", message: "Enter the amount and time below ", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Amount in oz"
        }
        alertController.addTextField { (textField) in
           textField.placeholder = "Time"
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .default) { [self]
            (action) in

            let input1 = alertController.textFields![0].text ?? ""
            print(input1)
            let input2 = alertController.textFields![1].text ?? ""
            print(input2)
            let waterString = "\(input1)oz at \(input2)"
            
            var db = Firestore.firestore()
            var alreadyInDB = false
            
            db.collection("users")
                .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            let nam = document.data()["name"] as? String ?? "FAIL"
                            var water = document.data()["water"] as? [String] ?? []
                            water.append(waterString)
                            
                            if (nam == globalName){
                                db.collection("users").document(document.documentID).updateData(["water": water])
                            }
                        }
                    }
                }
            
            globalWater.append(waterString)
            self.waterList.append(waterString)
            waterTV.reloadData()
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // TABLEVIEW CONTENT
    @IBOutlet weak var breakfastTV: UITableView!
    @IBOutlet weak var lunchTV: UITableView!
    @IBOutlet weak var dinnerTV: UITableView!
    @IBOutlet weak var waterTV: UITableView!
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == breakfastTV{
        return breakfastList.count
        } else if tableView == lunchTV {
            return lunchList.count
        } else if tableView == dinnerTV {
            return dinnerList.count
        } else {
            return waterList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == breakfastTV{
            let cell = breakfastTV.dequeueReusableCell(withIdentifier: "breakfast", for: indexPath)
            cell.textLabel!.text = breakfastList[indexPath.row]
            return cell
        } else if tableView == lunchTV {
            let cell = lunchTV.dequeueReusableCell(withIdentifier: "lunch", for: indexPath)
            cell.textLabel!.text = lunchList[indexPath.row]
            return cell
        } else if tableView == dinnerTV {
            let cell = dinnerTV.dequeueReusableCell(withIdentifier: "dinner", for: indexPath)
            cell.textLabel!.text = dinnerList[indexPath.row]
            return cell
        } else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "water'")
            cell.textLabel!.text = waterList[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if tableView == breakfastTV{
            if (editingStyle == . delete){
                breakfastList.remove(at: indexPath.row)
                breakfastTV.reloadData()
            }
        } else if tableView == lunchTV {
            if (editingStyle == . delete){
                lunchList.remove(at: indexPath.row)
                lunchTV.reloadData()
            }
        } else if tableView == dinnerTV {
            if (editingStyle == . delete){
                dinnerList.remove(at: indexPath.row)
                dinnerTV.reloadData()
            }
        } else {
            if (editingStyle == . delete){
                waterList.remove(at: indexPath.row)
                waterTV.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        loadData()
        print("global water 3")
        print(globalWater)
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //breakfast
        breakfastTV.register(UITableViewCell.self, forCellReuseIdentifier: "breakfast")
        breakfastTV.dataSource = self
        breakfastTV.delegate = self
        
        //dinner
        dinnerTV.register(UITableViewCell.self, forCellReuseIdentifier: "dinner")
        dinnerTV.dataSource = self
        dinnerTV.delegate = self
        
        
        //lunch
        lunchTV.dataSource = self
        lunchTV.delegate = self
        lunchTV.register(UITableViewCell.self, forCellReuseIdentifier: "lunch")
        
        //water
        waterTV.register(UITableViewCell.self, forCellReuseIdentifier: "water")
        waterTV.dataSource = self
        waterTV.delegate = self
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    func loadData() {
        breakfastTV.reloadData()
        lunchTV.reloadData()
        dinnerTV.reloadData()
        waterTV.reloadData()
        
        print("called")
        breakfastList = globalBreakFast
        lunchList = globalLunch
        dinnerList = globalDinner
        waterList = globalWater
        
        breakfastTV.reloadData()
        lunchTV.reloadData()
        dinnerTV.reloadData()
        waterTV.reloadData()
    }
    
}
