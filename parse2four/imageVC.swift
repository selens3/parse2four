//
//  imageVC.swift
//  parse2four
//
//  Created by Suat Selen on 24.10.2018.
//  Copyright © 2018 mehmet selen. All rights reserved.
//

import UIKit
import Parse


            var globalName = ""
            var globalType = ""
            var globalAtmosphere = ""
            var globalImage = UIImage()



class imageVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var placenameText: UITextField!
    @IBOutlet weak var placeTypeText: UITextField!
    @IBOutlet weak var placeAtmosphereText: UITextField!
    @IBOutlet weak var placeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        placeImage.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageVC.selectImage))
        placeImage.addGestureRecognizer(gestureRecognizer)
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        globalName = ""
        globalType = ""
        globalAtmosphere = ""
        globalImage = UIImage()
    }
    
    
    
    @objc func selectImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
        
    
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        placeImage.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
    }
    

    @IBAction func nextClicked(_ sender: Any) {
        if placenameText.text != "" && placeTypeText.text != "" && placeAtmosphereText.text != "" {
            
            if let chosenImage = placeImage.image {
                
                 globalName = placenameText.text!
                globalType = placeTypeText.text!
                globalAtmosphere = placeAtmosphereText.text!
                globalImage = chosenImage
                
            }
        }
        
        self.performSegue(withIdentifier: "fromimageVCtomapVC", sender: nil)
        
        placenameText.text = ""
        placeTypeText.text = ""
        placeAtmosphereText.text = ""
        placeImage.image = UIImage(named: "select.png")
        
    }
}
