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

class AccountViewController : UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    var account:Account=Account(voornaam: "init", achternaam: "init", straat: "init", nummer: "init", stad: "init")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerForKeyboardNotifications()
        if let savedAccount = Account.loadFromFile() {
            account = savedAccount
        } else {
            account = Account.loadSampleItems()
        }
        vulIn(voornaam: account.voornaam)
    }
    
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
    
    @IBOutlet weak var textfieldVoornaam: UITextField!
    
    func vulIn(voornaam: String){
        textfieldVoornaam.text=voornaam
    }
    
}





