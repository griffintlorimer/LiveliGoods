//
//  SettingsVC.swift
//  NotificationSystem
//
//  Created by Lev Rose on 11/8/22.
//

import Foundation
import UIKit


class SettingsVC : UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource{
 
    
    let Goals_Section = 0
    let Eating_Section = 1
    let Drinking_Section = 2
    let Movement_Section = 3
    
    let screenWidth = UIScreen.main.bounds.height - 10
    let screenHeight = UIScreen.main.bounds.height/2

    
    let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 10, height: UIScreen.main.bounds.height/2))
   
    var selectedRow: Int = 0
    
    var eatReminders = 0
    var drinkReminders = 0
    var moveReminders = 0
    
    @IBOutlet weak public var theTable: UITableView!
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == Goals_Section{
            return goalCellTableViewCell().goals.count
        }else if section == Eating_Section{
            return notificationCellTableViewCell().eating.count
        }else if section == Drinking_Section{
            return notificationCellTableViewCell().drinking.count
        }else if section == Movement_Section{
            return notificationCellTableViewCell().movement.count
        }
        
        return section
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == Goals_Section{
            return "Daily Goals"
        }else if section == Eating_Section{
            return notificationCellTableViewCell().notifications[0]
        }else if section == Drinking_Section{
            return notificationCellTableViewCell().notifications[1]
        }else if section == Movement_Section{
            return notificationCellTableViewCell().notifications[2]
        }
        
        return ""
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
     //   let locked = false
        
        if indexPath.section == Goals_Section{

            
            let cell = theTable.dequeueReusableCell(withIdentifier: "goalCell") as! goalCellTableViewCell
            cell.configure(with: cell.goals[indexPath.row])
            return cell
            
        } else if (indexPath.row == 0){
                let cell = theTable.dequeueReusableCell(withIdentifier: "notificationCell") as! notificationCellTableViewCell
                cell.configure(with: cell.notifications[indexPath.section-1])
                return cell
        }
        let currSec = indexPath.section
        var currReminders = 0
        
        if (currSec == Eating_Section){
            currReminders = eatReminders
        }
        if (currSec == Drinking_Section){
            currReminders = drinkReminders
        }
        if (currSec == Movement_Section){
            currReminders = moveReminders
        }
        
        let cell = theTable.dequeueReusableCell(withIdentifier: "notificationSubCell") as! notificationSubCell
        cell.configure(reminders: currReminders)
            return cell
        
        
     
    }
    

    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        // for picker view
        if (indexPath.section != Goals_Section){
            let vc = UIViewController()
            vc.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)



            pickerView.selectRow(selectedRow, inComponent: 0, animated: false)

            vc.view.addSubview(pickerView)
            pickerView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
            pickerView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
            let alert = UIAlertController(title: "Set Daily Goal", message: "", preferredStyle: .actionSheet)
            alert.setValue(vc, forKey: "contentViewController")
            alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: {(UIAlertAction) in

            }))
            alert.addAction(UIAlertAction(title: "Select", style: .default, handler: {(UIAlertAction) in
                self.selectedRow = self.pickerView.selectedRow(inComponent: 0)
//                let cell = self.theTable.dequeueReusableCell(withIdentifier: notificationSubCell.identifier) as! notificationSubCell
//
//                cell.reminderNumber.text = String(self.selectedRow)
                //change cel to new cell
                
                if (indexPath.section == self.Eating_Section){
                    self.eatReminders = self.selectedRow
                }else if (indexPath.section == self.Drinking_Section){
                    self.drinkReminders = self.selectedRow
                } else{
                    self.moveReminders = self.selectedRow
                }
            
                self.theTable.reloadData()
            }))

            self.present(alert, animated: true, completion: nil)

        }
//

        
        // TODO
        // not updating the table view when selected
        // not layed out well in picker view
        // picker view doesn't make sense for goals, should be for notifications
        
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 25
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 30))
        label.text = String(row)
        label.textColor = UIColor.black
        label.sizeToFit()
        return label
        
    }
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        theTable.delegate = self
        theTable.dataSource = self
        theTable.backgroundColor = UIColor(named: "Background")
        
        theTable.register(notificationCellTableViewCell.nib(), forCellReuseIdentifier: notificationCellTableViewCell.identifier)
        theTable.register(goalCellTableViewCell.nib(), forCellReuseIdentifier: goalCellTableViewCell.identifier)
        theTable.register(notificationSubCell.nib(), forCellReuseIdentifier: notificationSubCell.identifier)
        
        pickerView.dataSource = self
        pickerView.delegate = self
       
    }

   
    
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}



