//
//  imageVC.swift
//  parse2four
//
//  Created by Suat Selen on 24.10.2018.
//  Copyright © 2018 mehmet selen. All rights reserved.
//

import UIKit
import Parse

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
    }
    

}
