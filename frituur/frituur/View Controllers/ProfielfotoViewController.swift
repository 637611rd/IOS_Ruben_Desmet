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
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker =  UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            
            present(imagePicker, animated: true, completion: nil)
        }
        else{
            let alertController = UIAlertController(title: "Oeps!", message: "Het is niet mogelijk om met jouw toestel de camera te gebruiken!", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                
                print("Ok button tapped");
                
            }
            
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true, completion:nil)
        }
        
    }
    
    @IBAction func kiesUitLibraryPressed(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
        }
        else{
            let alertController = UIAlertController(title: "Oeps!", message: "Het is niet mogelijk om met jouw toestel de fotobibliotheek te gebruiken!", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                
                print("Ok button tapped");
                
            }
            
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true, completion:nil)
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        imageView.image = info[.originalImage] as? UIImage
       saveImage(imageName: "profielfoto.png")
        
        
    }
    
    func saveImage(imageName: String){
        //Filemanager instance aanmaken
        let fileManager = FileManager.default
        //imagePath opvragen
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        //De image zelf opvragen
        let image = imageView.image!
        //PNG data opvragen
        let data = image.pngData()
        //opslaan in de document directory
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
        let account = Account.loadFromFile()
        
        //Als deze uitroepteken een vraagteken zou zijn, dan zegt hij "optional" ervoor luidop.
        //Kan nooit leeg zijn, want als je niets invult bij voor- of achternaam dan is het een lege string: "".
        //Met het uitroepteken neem je zelf het risico dat er geen null waarde mogelijk is.
        let voornaam=account!.voornaam
        let achternaam = account!.achternaam
        
        let string = "Hallo \(voornaam). \(achternaam). Hier kan je je profielfoto selecteren. Neem de linkerknop om vanuit je camera een foto te nemen. Neem de rechterknop om uit je bibliotheek een foto te selecteren."
        let utterance = AVSpeechUtterance(string: string)
        utterance.voice = AVSpeechSynthesisVoice(language: "nl-BE")
        utterance.rate=0.4
        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)
    }
    
    
    
    
}
