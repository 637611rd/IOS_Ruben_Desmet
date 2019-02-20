//
//  AddEditItemTableViewController.swift
//  frituur
//
//  Created by Ruben Desmet on 24/11/2018.
//  Copyright © 2018 Ruben Desmet. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AddEditItemTableViewController:UITableViewController{
    @IBOutlet weak var itemNaamTextField: UITextField!
    var ref: DatabaseReference!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var item:Item?
    
    override func viewDidLoad() {
        if let item = item {
            itemNaamTextField.text = item.naam
            
        }
        ref = Database.database().reference()
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
        
        item = Item(naam: naam)
        //ref.child("snacks").childByAutoId().setValue(["naam": naam])
        
        
    }
    
    
}

