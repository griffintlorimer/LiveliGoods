//
//  JournalHomeViewController.swift
//  LiveliGoods
//
//  Created by Sproull Student on 11/29/22.
//

import UIKit
import FirebaseFirestore

class JournalHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var theData:[Journal] = []
    var toViewTable = false
    var currDayString = ""
    
    func setupTableView() {
        print("setting up table")
        journalListTable.delegate = self
        journalListTable.dataSource = self
        journalListTable.register(UITableViewCell.self, forCellReuseIdentifier: "journalcell")
        journalListTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        theData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("creating table cell")
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "journalcell")
        //journalListTable.dequeueReusableCell(withIdentifier: "journalcell", for: indexPath)
        cell.textLabel?.text = theData[indexPath.row].title
        cell.detailTextLabel?.text = theData[indexPath.row].note
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        journalListTable.deselectRow(at: indexPath, animated: true)
        //navigate to journal view controller
        let journalVC = self.storyboard?.instantiateViewController(withIdentifier: "JournalsVC") as! JournalViewController
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        currDayString = dateFormatter.string(from: date)
        journalVC.title = currDayString  + "'s Journal"// maybe append the day??
        let model = theData[indexPath.row]
        journalVC.noteTitle = model.title
        journalVC.note = model.note
        navigationController?.pushViewController(journalVC, animated: true)
    }

    
    @IBAction func newJournalEntry(_ sender: Any) {
        print("new journal request")
        let journalEntryVC = self.storyboard?.instantiateViewController(withIdentifier: "newJournalEntryVC") as! JournalEntryViewController
        journalEntryVC.navigationItem.title = "New Journal"
//        journalEntryVC.completion = {noteTitle, note in
//           // self.navigationController?.popToRootViewController(animated: true)
//            self.models.append((title: noteTitle, note: note))
//
//        }
      //  if journalEntryVC.showTable == true {
//        self.noJournalsLabel.isHidden = true
//        self.journalListTable.isHidden = false
         //   self.journalListTable.reloadData()
       // }
        print("adding saved journal to table")
        navigationController?.pushViewController(journalEntryVC, animated: true)
    }
    
    func fetchFromDB() {
        var db = Firestore.firestore()
        db.collection("users")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let nam = document.data()["name"] as? String ?? "FAIL"
                        var jlist = document.data()["journal"] as? [String] ?? []
                        if (nam == globalName){
                            var arr: [Journal] = []
                            for items in jlist {
                                let spl = items.split(separator: ":")
                                
                                var j = Journal(title: String(spl[0]), note: String(spl[1]))
                                arr.append(j)
                            }
                            self.theData = arr
                        }
                    }
                }
            }
        
        
        
        
        
        
//        let thePath = Bundle.main.path(forResource: "journalEntries", ofType: "db")
//        let contactDB = FMDatabase(path: thePath)
//        if !(contactDB.open()) {
//            print("unable to open database")
//            return
//        }
//        else {
//            //execute query
//            //while more data coming back, retrieve data
//            theData = []
//            do {
//                let results = try contactDB.executeQuery("SELECT * FROM journal", values: nil)
//                while(results.next()) {
//                    toViewTable = true
////                    self.noJournalsLabel.isHidden = true
////                    self.journalListTable.isHidden = false
//                    let journal = Journal(title: results.string(forColumn: "TITLE")!, note: results.string(forColumn: "NOTE")!)
//                    theData.append(journal)
//                    print("loaded from DB")
//                }
//
//            }
//            catch let error as NSError {
//                print("failed \(error)")
//            }
//        }
//        contactDB.close()
    }
    
    @IBOutlet weak var journalListTable: UITableView!
    
    @IBOutlet weak var noJournalsLabel: UILabel!
    

    
    override func viewDidLoad() {
        print("hello")
        super.viewDidLoad()
        setupTableView()
        self.title = "Journal"
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            self.fetchFromDB()
            
            DispatchQueue.main.async {
                
                if self.toViewTable == true {
                    self.noJournalsLabel.isHidden = true
                    self.journalListTable.isHidden = false
                }
                self.journalListTable.reloadData()
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        journalListTable.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFromDB()
//        journalListTable.reloadData()
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
////        let summaryVC = self.storyboard?.instantiateViewController(withIdentifier: "SummaryScreen") as! SummaryViewController
//       // summaryVC.lastJournalDate = currDayString
//        super.viewWillDisappear(animated)
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
