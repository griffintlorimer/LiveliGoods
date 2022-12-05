//
//  ViewController.swift
//  LiveliGoods
//
//  Created by Griffin Lorimer on 11/4/22.
//
import FirebaseCore
import GoogleSignIn
import UIKit
import GoogleUtilities
import FirebaseAuth
import FirebaseFirestore

var globalName = ""
var globalMeal = "meal"
var globalBreakFast: [String] = []
var globalLunch: [String] = []
var globalDinner: [String] = []
var globalWater: [String] = []


class SignInController: UIViewController  {
    @IBOutlet var signInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func clicked(_ sender: Any) {
        
        let today = Date.now
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .short
        let shortDate = formatter1.string(from: today)
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in

          if let error = error {
            // ...
            return
          }

          guard
            let authentication = user?.authentication,
            let idToken = authentication.idToken
          else {
            return
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                  let authError = error as NSError
                    print("err!")
                  return
                } else {
                    print("no err!")
                    if let user = authResult?.user {
                        print(user.displayName!)
                        globalName = user.displayName!
                        
                        var db = Firestore.firestore()
                        var alreadyInDB = false
                        
                        db.collection("users")
                            .getDocuments() { (querySnapshot, err) in
                                if let err = err {
                                    print("Error getting documents: \(err)")
                                } else {
                                    print(querySnapshot!.documents.count)
                                    print(querySnapshot!.documents)
                                    
                                    let username = user.displayName! as String
                                    
                                    for document in querySnapshot!.documents {
                                        let nam = document.data()["name"] as? String ?? "FAIL"
                                        let dat = document.data()["date"] as? String ?? "FAIL"
                                        
                                        let bflist = document.data()["breakfast"] as? [String] ?? []
                                        let llist = document.data()["lunch"] as? [String] ?? []
                                        let dlist = document.data()["dinner"] as? [String] ?? []
                                        let wlist = document.data()["water"] as? [String] ?? []

                                        globalBreakFast = bflist
                                        globalLunch = llist
                                        globalDinner = dlist
                                        globalWater = wlist

                                        if (nam == username && dat == shortDate){
                                            alreadyInDB = true
                                        } else if (nam == username && dat != shortDate){
                                            db.collection("users").document(document.documentID).delete()
                                        }
                                    }

                                }
                                if (!alreadyInDB){
                                    print("updated!")
                                    
                                    let collection = db.collection("users")
                                    collection.addDocument(data: ["name": user.displayName!, "date": shortDate, "currentCalCount": 0, "steps":0, "breakfast": [], "lunch": [], "dinner": [], "water": []])
                                    globalBreakFast = []
                                    globalLunch = []
                                    globalDinner = []
                                    globalWater = []
                                }
                        }
                    }
            
                    
                    
                    
                    
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let tabbarVC = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
                    self.present(tabbarVC, animated: false, completion: nil)
                }
            }
            
            
            
            
    }
    
}

}
