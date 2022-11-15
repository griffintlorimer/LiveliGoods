//
//  notificationCellTableViewCell.swift
//  NotificationSystem
//
//  Created by Lev Rose on 11/8/22.
//

import UIKit

class notificationCellTableViewCell: UITableViewCell {

    
        
    @IBOutlet var myLabel : UILabel!
    
    @IBOutlet weak var mySwitch: UISwitch!
    
    var upperView = UITableView()
    
    public let notifications = ["Eating Notifications", "Drinking Notifications", "Movement Notifications"]
    public let eating = ["Meals" , "Snacks"]
    public let drinking = ["Daily", "Hourly"]
    public let movement = ["Daily", "Hourly"]
    public var notificationNumber: Int = 0

        static let identifier = "notificationCell"
        
        static func nib() -> UINib{
            return UINib(nibName: "notificationCellTableViewCell", bundle: nil)
        }
        
    public func configure(with title: String/*, locked: Bool*/){
            myLabel.text = title
            mySwitch.isOn = false
//        if (locked){
//            self.backgroundColor = UIColor.lightGray
//            myLabel.textColor = UIColor.darkGray
////        }
            
            
        }
    
        
      
    
        override func awakeFromNib() {
            super.awakeFromNib()
        }
    

        
        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
        }
    
    @IBAction func changedSwitch(_ sender: Any) {
        
//        if (mySwitch.isOn){
//            print("on")
//            self.backgroundColor = UIColor(named: "Background")
//            myLabel.textColor = UIColor(named: "Text")
//            if (myLabel.text == notifications[0]){
//                eatingSwitch = true
//                print(eatingSwitch)
//            }else if (myLabel.text == notifications[1]){
//                drinkingSwitch = true
//            }else if (myLabel.text == notifications[2]){
//                movementSwitch = true
//            }
//
//
//
//        } else{
//            print("off")
//            self.backgroundColor = UIColor.lightGray
//            myLabel.textColor = UIColor.darkGray
//            if (myLabel.text == notifications[0]){
//                eatingSwitch = false
//            }else if (myLabel.text == notifications[1]){
//                drinkingSwitch = false
//            }else if (myLabel.text == notifications[2]){
//                movementSwitch = false
//            }
            
            
//        }
    }
    
    

    
    
    }
