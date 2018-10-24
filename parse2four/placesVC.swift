//
//  placesVC.swift
//  parse2four
//
//  Created by Suat Selen on 24.10.2018.
//  Copyright © 2018 mehmet selen. All rights reserved.
//

import UIKit
import Parse

class placesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "userLoggedIn")
        UserDefaults.standard.synchronize()
        
        
        let signInVC = self.storyboard?.instantiateViewController(withIdentifier: "signinVC") as! signInvc
        let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        delegate.window?.rootViewController = signInVC
        delegate.rememberLogIn()
    }
    
    @IBAction func addClicked(_ sender: Any) {
    }
    

}
