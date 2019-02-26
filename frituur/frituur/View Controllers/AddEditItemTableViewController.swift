//
//  AddEditItemTableViewController.swift
//  frituur
//
//  Created by Ruben Desmet on 24/11/2018.
//  Copyright © 2018 Ruben Desmet. All rights reserved.
//

import UIKit
import Firestore

class AddEditItemTableViewController:UITableViewController{
    @IBOutlet weak var itemNaamTextField: UITextField!
    
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var item:Item?
    var db:Firestore!
    var oudeItemId = String()

    
    override func viewDidLoad() {
        if let item = item {
            itemNaamTextField.text = item.naam
            
        }
        
        
        updateSaveButtonState()
    }
    
    //Methode die controleert als de save button toonbaar mag zijn of niet.
    func updateSaveButtonState() {
        let itemNaamText = itemNaamTextField.text ?? ""
        
        saveButton.isEnabled = !itemNaamText.isEmpty
        
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField) { updateSaveButtonState()
    }
    
    //Om terug te keren naar het vorige scherm. Zelfde "saveUnwind" als in ItemTableViewController
    override func prepare(for segue: UIStoryboardSegue, sender:
        Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else { return }
        
        let naam = itemNaamTextField.text ?? ""
        let OudeNaam = item?.naam
        
        item = Item(naam: naam)
        
        //Toevoegen aan databank
        var ref:DocumentReference? = nil
        
        ref = self.db.collection("snacks").addDocument(data: item!.dictionary) {
            error in
            
            if let error = error {
                print("Error adding document: \(error.localizedDescription)")
            }else{
                print("Document added with ID: \(ref!.documentID)")
                
            }
            
        }
        db.collection("snacks").whereField("naam", isEqualTo: OudeNaam)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        self.oudeItemId=document.documentID
                        
                    }
                    
                    self.db.collection("snacks").document(self.oudeItemId).delete() { err in
                        if let err = err {
                            print("Error removing document: \(err)")
                        } else {
                            print("Document successfully removed!")
                        }
                    }
                }
        }
        
       
        
        
        
        
        
    }
    
    
}

