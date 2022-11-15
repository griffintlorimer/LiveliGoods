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

class SignInController: UIViewController  {
    @IBOutlet var signInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func clicked(_ sender: Any) {
        
        print("clicked")
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
//                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
//                    self.present(nextViewController, animated:true, completion:nil)
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let tabbarVC = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
                    self.present(tabbarVC, animated: false, completion: nil)
                }
            }
            
            
            
            
    }
    
}

}
