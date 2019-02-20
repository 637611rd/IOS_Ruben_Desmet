//
//  AccountViewController.swift
//  frituur
//
//  Created by Ruben Desmet on 24/11/2018.
//  Copyright © 2018 Ruben Desmet. All rights reserved.
//

//import Foundation
import UIKit
import MessageUI
import LocalAuthentication

class AccountViewController : UIViewController, MFMailComposeViewControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var btnSlaGegevensOp: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var txtVoornaam: UITextField!
    @IBOutlet weak var txtAchternaam: UITextField!
    @IBOutlet weak var txtStraat: UITextField!
    @IBOutlet weak var txtNummer: UITextField!
    @IBOutlet weak var txtStad: UITextField!
    let localAuthenticationContext = LAContext()
    
    var account:Account=Account(voornaam: "", achternaam: "", straat: "", nummer: "", stad: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerForKeyboardNotifications()
        if let savedAccount = Account.loadFromFile() {
            account = savedAccount
        }
        vulAccountGegevensIn(voornaam: account.voornaam,achternaam: account.achternaam,straat: account.straat,nummer: account.nummer,stad: account.stad)
        
        //MARK: dit is voor het toetsenbord te laten verdwijnen als je op return duwt.
        self.txtVoornaam.delegate=self
        self.txtAchternaam.delegate=self
        self.txtStad.delegate=self
        self.txtStraat.delegate=self
        self.txtNummer.delegate=self
    }
    
    //Functie om het keyboard te laten verschijnen en weer laten te verdwijnen
    func registerForKeyboardNotifications() {
        

       NotificationCenter.default.addObserver(self, selector:
        #selector(keyboardWasShown(_:)),
                                              name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:
        #selector(keyboardWillBeHidden(_:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWasShown(_ notificiation: NSNotification) {
        guard let info = notificiation.userInfo,
            let keyboardFrameValue =
            info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue
            else { return }
        
        let keyboardFrame = keyboardFrameValue.cgRectValue
        let keyboardSize = keyboardFrame.size
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0,
                                         bottom: keyboardSize.height, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
       
    }
    
    @objc func keyboardWillBeHidden(_ notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
       
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func mailClicked(_ sender: UIButton) {
        if MFMailComposeViewController.canSendMail() {
            print("In mailclicked")
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self as? MFMailComposeViewControllerDelegate
            mail.setToRecipients(["rubendesmet@live.be"])
            mail.setSubject("Vraag over de app")
            mail.setMessageBody("<p>Beste, </p><br><p>Verander deze tekst door je vraag </p>", isHTML: true)
            
            present(mail, animated: true,completion: nil)
            
            
        }
        
     
        
    }
    func mailComposeController(_ controller: MFMailComposeViewController,
                                    didFinishWith result: MFMailComposeResult,
                                    error: Error?) {
        
        controller.dismiss(animated: true,completion: nil)
    }
    

    
    func vulAccountGegevensIn(voornaam: String,achternaam: String,straat: String,nummer: String,stad: String){
        txtVoornaam.text=voornaam
        txtAchternaam.text=achternaam
        txtStraat.text=straat
        txtNummer.text=nummer
        txtStad.text=stad
    }
    @IBAction func slaGegevensOpButtonTapped(_ sender: Any) {
        
        if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil){
            localAuthenticationContext.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "We controleren als jij dit bent.", reply: {(wasCorrect,error) in
                if wasCorrect{
                    print("Correct")
                    self.account=Account(voornaam: self.txtVoornaam.text ?? " ", achternaam: self.txtAchternaam.text ?? " ", straat: self.txtStraat.text ?? " ", nummer: self.txtNummer.text ?? " ", stad: self.txtStad.text ?? " ")
                    Account.saveToFile(account: self.account)
                    
                    let alertController = UIAlertController(title: "Opgeslagen!", message: "Je gegevens werden succesvol opgeslagen!", preferredStyle: .alert)
                    
                    let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                        
                        print("Ok button tapped");
                        
                    }
                    
                    alertController.addAction(OKAction)
                    
                    self.present(alertController, animated: true, completion:nil)
                }else{
                    print("Incorrect")
                    
                }
            })
        }
        
    }
   
    
}





