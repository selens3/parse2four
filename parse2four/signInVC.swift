//
//  ViewController.swift
//  parse2four
//
//  Created by Suat Selen on 24.10.2018.
//  Copyright © 2018 mehmet selen. All rights reserved.
//

import UIKit
import Parse

class signInvc: UIViewController {

    @IBOutlet weak var usernameText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         
        
        
    }

    @IBAction func signInClicked(_ sender: Any) {
        
        if usernameText.text != "" && passwordText.text != "" {
            
            PFUser.logInWithUsername(inBackground: usernameText.text!, password: passwordText.text!, block: { (user, error) in
                if  error != nil {
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription , preferredStyle: UIAlertController.Style.alert)
                    let okButton  = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true , completion: nil)
                } else {
                    print("logged tamam")
                }
            })
            
        } else {
            let alert = UIAlertController(title: "Error", message: "username needed" , preferredStyle: UIAlertController.Style.alert)
            let okButton  = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true , completion: nil)
        }
        
        
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        if usernameText.text != "" && passwordText.text != "" {
            
            let user = PFUser()
            user.username = usernameText.text!
            user.password = passwordText.text!
            
            user.signUpInBackground(block: { (success, error) in
                if error != nil {
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription , preferredStyle: UIAlertController.Style.alert)
                    let okButton  = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true , completion: nil)
                } else {
                    
                    print("user tamam")
                }
                
            })
            
            
            
        }  else {
            let alert = UIAlertController(title: "Error", message: "username needed" , preferredStyle: UIAlertController.Style.alert)
            let okButton  = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true , completion: nil)
            
            
        }
        
    }
}

