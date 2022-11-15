//
//  notificationSubCell.swift
//  NotificationSystem
//
//  Created by Lev Rose on 11/14/22.
//


//TODO
// make start and inactive gray
// make click not turn highlighted


import UIKit

class notificationSubCell: UITableViewCell {

    @IBOutlet weak var reminderNumber: UILabel!
    
    @IBOutlet weak var myLabel: UILabel!
    
    static let identifier = "notificationSubCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "notificationSubCell", bundle: nil)
    }
    
    func configure(reminders: Int){
//        if (!active){
//            self.backgroundColor = UIColor.lightGray
//            myLabel.textColor = UIColor.darkGray
//            reminderNumber.textColor = UIColor.darkGray
//
//        } else{
        self.backgroundColor = UIColor(named: "Background")
        myLabel.textColor = UIColor(named: "Text")
        reminderNumber.textColor = UIColor.black
        reminderNumber.text = String(reminders)
//        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
