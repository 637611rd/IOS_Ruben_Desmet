//
//  ProfielfotoViewController.swift
//  frituur
//
//  Created by Ruben Desmet on 20/02/2019.
//  Copyright © 2019 Ruben Desmet. All rights reserved.
//

import UIKit
import AVFoundation


class ProfielfotoViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var btnNeemFoto: UIButton!
    @IBOutlet weak var btnLibrary: UIButton!
    var imagePicker: UIImagePickerController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    
    @IBAction func neemFotoPressed(_ sender: Any) {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func kiesUitLibraryPressed(_ sender: Any) {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        imageView.image = info[.originalImage] as? UIImage
        
    }
    @IBAction func luisterPressed(_ sender: Any) {
        
        let string = "Hier kan je je profielfoto selecteren. Neem de linkerknop om vanuit je camera een foto te nemen. Neem de rechterknop om uit je bibliotheek een foto te selecteren."
        let utterance = AVSpeechUtterance(string: string)
        utterance.voice = AVSpeechSynthesisVoice(language: "nl-BE")
        utterance.rate=0.4
        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)
    }
}
