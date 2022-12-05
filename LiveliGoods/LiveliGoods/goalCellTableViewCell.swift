class goalCellTableViewCell: UITableViewCell {
    
    
        
    @IBOutlet weak var myGoalNum: UITextField!
    @IBOutlet var myLabel : UILabel!
    
    var VC: SettingsVC = SettingsVC()
    
    public let goals = ["Daily Calorie Intake Goal", "Daily Water Intake Goal", "Daily Steps Goal"]

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
        
        if (myLabel.text == goals[0]){
            VC.calGoal = Int(myGoalNum.text!) ?? 0
        }
        if (myLabel.text == goals[1]){
            VC.drinkGoal = Int(myGoalNum.text!) ?? 0
        }
        if (myLabel.text == goals[2]){
            VC.stepGoal = Int(myGoalNum.text!) ?? 0
        }
        
        VC.storeUserDefaults()
        VC.notifier.loadNotifications()
        
    }
    
    
    
        
        override func awakeFromNib() {
            super.awakeFromNib()
            
        }
        
        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
        }
    
    
    }
