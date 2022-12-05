//
//  JournalEntryViewController.swift
//  LiveliGoods
//
//  Created by Sproull Student on 11/29/22.
//

import UIKit
import FirebaseFirestore

class JournalEntryViewController: UIViewController {
    
    @IBOutlet var titleField: UITextField!
    @IBOutlet var noteField: UITextView!

    var currDate = ""
    
    
//    public var completion: ((String, String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        // to get keyboard for it
        titleField.becomeFirstResponder()
        //adding save button manually
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(tappedSave))

        // Do any additional setup after loading the view.
    }
    
    @objc func tappedSave() {
        if let text = titleField.text, !text.isEmpty, !noteField.text.isEmpty {
            var db = Firestore.firestore()

            db.collection("users")
                .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            let nam = document.data()["name"] as? String ?? "FAIL"
                            var jlist = document.data()["journal"] as? [String] ?? []
                            jlist.append("\(text): \(self.noteField.text)")

                            if (nam == globalName){
                                jlist.append("\(text): \(self.noteField.text)")
                                db.collection("users").document(document.documentID).updateData(["journal": jlist])
                            }
                        }

                    }
                }
            
            getCurrDate()
        }
        else {
            let alert = UIAlertController(title: "Alert", message: "Can Not Add Empty Journal", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func getCurrDate() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let currDayString = dateFormatter.string(from: date)
        currDate = currDayString
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
