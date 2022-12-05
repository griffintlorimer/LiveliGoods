//
//  JournalViewController.swift
//  LiveliGoods
//
//  Created by Sproull Student on 11/29/22.
//

import UIKit

class JournalViewController: UIViewController {
    
    public var noteTitle: String = ""
    public var note: String = ""
   
    @IBOutlet weak var journalTitle: UILabel!
    @IBOutlet weak var journalText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        journalTitle.text = noteTitle
        journalText.text = note;

        // Do any additional setup after loading the view.
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
