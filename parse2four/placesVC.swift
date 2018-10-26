//
//  placesVC.swift
//  parse2four
//
//  Created by Suat Selen on 24.10.2018.
//  Copyright © 2018 mehmet selen. All rights reserved.
//

import UIKit
import Parse

class placesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    

    @IBOutlet weak var tableView: UITableView!
    
    var placeNameArray = [String]()
    var chosenPlace = ""
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
    
        tableView.dataSource = self
        
        getData()
    
    }
    
    func getData() {
        
        let query = PFQuery(className: "Places")
        query.findObjectsInBackground { (objects, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription , preferredStyle: UIAlertController.Style.alert)
                let okButton  = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true , completion: nil)
            } else {
                self.placeNameArray.removeAll(keepingCapacity: false)
                for object in objects! {
                    self.placeNameArray.append(object.object(forKey: "name") as! String)
                }
                self.tableView.reloadData()
            }
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromplacesVCtodetailsVC" {
            let destinationVC = segue.destination as! detailsVC
            destinationVC.selectedPlace = self.chosenPlace
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.chosenPlace = placeNameArray[indexPath.row]
        self.performSegue(withIdentifier: "fromplacesVCtodetailsVC", sender: nil)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = placeNameArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeNameArray.count
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
        self.performSegue(withIdentifier: "fromplacesVCtoimageVC", sender: nil)
        
    }
    

}
