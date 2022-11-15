//
//  goalCellTableViewCell.swift
//  NotificationSystem
//
//  Created by Lev Rose on 11/8/22.
//

import UIKit

class goalCellTableViewCell: UITableViewCell {
    
    
        
    @IBOutlet weak var myGoalNum: UITextField!
    @IBOutlet var myLabel : UILabel!
    
    public let goals = ["Daily Water Intake Goal", "Daily Calorie Intake Goal", "Daily Steps Goal"]

        static let identifier = "goalCell"
        
        static func nib() -> UINib{
            return UINib(nibName: "goalCellTableViewCell", bundle: nil)
        }
        
        public func configure(with title: String){
            myLabel.text = title
            myGoalNum.text = "0"
            
        }
    

    @IBAction func editingBegan(_ sender: Any) {
        myGoalNum.text = ""
    }
    
    @IBAction func editingEnded(_ sender: Any) {
        if (Int(myGoalNum.text!) == nil){
            myGoalNum.text = "0"
        }
        
        
     
    }
    
    
    
        
        override func awakeFromNib() {
            super.awakeFromNib()
            
        }
        
        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
        }
    
    
    }
