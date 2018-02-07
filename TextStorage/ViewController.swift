//
//  ViewController.swift
//  TextStorage
//
//  Created by Jesse Wu on 2/6/18.
//  Copyright © 2018 Jesse Wu. All rights reserved.
//

import UIKit

// import for firebase google login
import Firebase
import FirebaseDatabase
import GoogleSignIn

class ViewController: UIViewController, GIDSignInUIDelegate {
    
    let textRef = Database.database().reference().child("temp")
    
    @IBAction func signin(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBAction func register(_ sender: Any) {
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, error) in
            
            if(error != nil){return}
            
            let alert = UIAlertController(title: "alert", message: "success to sign in", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var display: UILabel!
    @IBAction func uploadButton(_ sender: Any) {
        textRef.setValue(inputField.text!)
        textRef.observe(.value) {(snap: DataSnapshot) in
            self.display.text = snap.value as? String
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        GIDSignIn.sharedInstance().uiDelegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBOutlet weak var uploadText: UIButton!
    @IBOutlet weak var showText: UIButton!
}

