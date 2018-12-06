//
//  AddEditItemTableViewController.swift
//  frituur
//
//  Created by Ruben Desmet on 24/11/2018.
//  Copyright © 2018 Ruben Desmet. All rights reserved.
//

import UIKit

class AddEditItemTableViewController:UITableViewController{
    @IBOutlet weak var itemNaamTextField: UITextField!
    
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var item:Item?
    
    override func viewDidLoad() {
        if let item = item {
            itemNaamTextField.text = item.naam
            
        }
        
        updateSaveButtonState()
    }
    
    func updateSaveButtonState() {
        let itemNaamText = itemNaamTextField.text ?? ""
        
        saveButton.isEnabled = !itemNaamText.isEmpty
        
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField) { updateSaveButtonState()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender:
        Any?) {
        super.prepare(for: segue, sender: sender)

        guard segue.identifier == "saveUnwind" else { return }

        let naam = itemNaamTextField.text ?? ""
        
        item = Item(naam: naam)
        
        
    }
    
    
}

