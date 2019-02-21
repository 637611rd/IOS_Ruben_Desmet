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
        getImage(imageName: "profielfoto.png")
       
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
       saveImage(imageName: "profielfoto.png")
        
        
    }
    
    func saveImage(imageName: String){
        //create an instance of the FileManager
        let fileManager = FileManager.default
        //get the image path
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        //get the image we took with camera
        let image = imageView.image!
        //get the PNG data for this image
        let data = image.pngData()
        //store it in the document directory
        fileManager.createFile(atPath: imagePath as String, contents: data, attributes: nil)
    }
    
    func getImage(imageName: String){
        let fileManager = FileManager.default
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        if fileManager.fileExists(atPath: imagePath){
            imageView.image = UIImage(contentsOfFile: imagePath)
        }else{
            print("Er is geen afbeelding")
        }
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
