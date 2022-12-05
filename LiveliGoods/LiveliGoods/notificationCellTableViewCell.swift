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
    
    var VC: SettingsVC?
    
    public let notifications = ["Eating Notifications", "Drinking Notifications", "Movement Notifications"]

        static let identifier = "notificationCell"
    
    
        
        static func nib() -> UINib{
            return UINib(nibName: "notificationCellTableViewCell", bundle: nil)
        }
        
    public func configure(with title: String, vc: SettingsVC){
            VC = vc
        
        myLabel.text = title
        
        if (myLabel.text == notifications[0]){
            mySwitch.isOn = UserDefaults.standard.bool(forKey: "eatSwitch")
            
        }else if (myLabel.text == notifications[1]){
            mySwitch.isOn = UserDefaults.standard.bool(forKey: "drinkSwitch")
           
        }else if (myLabel.text == notifications[2]){
            mySwitch.isOn = UserDefaults.standard.bool(forKey: "moveSwitch")
            
        }
            
            
    }
    
        
      
    
        override func awakeFromNib() {
            super.awakeFromNib()
        }
    

        
        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
        }
    
    @IBAction func changedSwitch(_ sender: Any) {
        VC!.loadUserDefaults()
        if (myLabel.text == notifications[0]){
            VC!.eatSwitch = mySwitch.isOn
            
        }else if (myLabel.text == notifications[1]){
            VC!.drinkSwitch = mySwitch.isOn
           
        }else if (myLabel.text == notifications[2]){
            VC!.moveSwitch = mySwitch.isOn
            
        }
        
        VC!.storeUserDefaults()
        VC!.notifier.loadNotifications()
        
        
    
    }
    
    

    
    
    }
