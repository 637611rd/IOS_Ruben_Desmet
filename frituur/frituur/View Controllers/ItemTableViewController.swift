//
//  ItemViewController.swift
//  frituur
//
//  Created by Ruben Desmet on 24/11/2018.
//  Copyright © 2018 Ruben Desmet. All rights reserved.
//

import UIKit

class ItemTableViewController: UITableViewController {
    
    var items: [Item] = []
    var snackItems:[Item] = []
    var categorie:Categorie=Categorie(naam: "", beschrijving: "")
    var naam:String=""
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //self.navigationItem.leftBarButtonItem = self.editButtonItem
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        
       
        
        
        
        switch categorie.naam {
        case "Snacks":
            if let savedItems = Item.loadFromSnacksFile() {
                items = savedItems
            }
        case "Drank":
            if let savedItems = Item.loadFromDrankFile() {
                items = savedItems
                }
        case "Frieten":
            
            if let savedItems = Item.loadFromFrietenFile() {
                items = savedItems
            }
           
            
        default:
            print("Default")
        }
        
        navigationItem.title=categorie.naam
    }
    
 
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return items.count
        } else {
            return 0
        }
    }
    
    //Voor iedere cell zijn waarde updaten.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemTableViewCell
        cell.showsReorderControl = true
        //zetSnackItems()
        let item = items[indexPath.row]
        cell.update(with: item)
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    //Delete een item en sla de items opnieuw op
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            switch categorie.naam {
            case "Snacks":
                Item.saveToSnacksFile(items: items)
            case "Drank":
                Item.saveToDrankFile(items: items)
            case "Frieten":
               Item.saveToFrietenFile(items: items)
           
                
            default:
                print("Default")
            }
        }
    }
    
       //Oorspronkelijk stond er edit vanboven in plaats van back. Deze methode zorgde ervoor dat je de elementen van plaats kon verwisselen.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedItem = items.remove(at: fromIndexPath.row)
        items.insert(movedItem, at: to.row)
        tableView.reloadData()
        switch categorie.naam {
        case "Snacks":
            Item.saveToSnacksFile(items: items)
        case "Drank":
            Item.saveToDrankFile(items: items)
        case "Frieten":
            Item.saveToFrietenFile(items: items)
            
            
        default:
            print("Default")
        }
    }
    
    // MARK: - Navigation
    
    //Als je op een item geklikt hebt wordt de 'EditItem' uitgevoerd. Dan geeft hij de item mee aan het volgende scherm.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditItem" {
            print("inEditItem")
            let indexPath = tableView.indexPathForSelectedRow!
            let item = items[indexPath.row]
            let navigationViewController = segue.destination as! UINavigationController
            let addEditItemTableViewController = navigationViewController.topViewController as! AddEditItemTableViewController
            
            addEditItemTableViewController.item = item
        }
        
        
    }
    
    //Als hij van de Edit pagina terug komt wordt deze methode uitgevoerd. Dan worden de Items opnieuw geladen.
    @IBAction func unwindToItemTableView(segue: UIStoryboardSegue) {
        print("unwindmethode")
        
        guard segue.identifier == "saveUnwind" else { return }
        let sourceViewController = segue.source as!
        AddEditItemTableViewController
        print(sourceViewController)
        
        if let item = sourceViewController.item {
            
            if let selectedIndexPath =
                tableView.indexPathForSelectedRow {
                items[selectedIndexPath.row] = item
                tableView.reloadRows(at: [selectedIndexPath],with: .none)
            } else {
                let newIndexPath = IndexPath(row: items.count,section: 0)
                items.append(item)
                tableView.insertRows(at: [newIndexPath],with: .automatic)
            }
        }
        switch categorie.naam {
        case "Snacks":
            Item.saveToSnacksFile(items: items)
        case "Drank":
            Item.saveToDrankFile(items: items)
        case "Frieten":
            Item.saveToFrietenFile(items: items)
        
        default:
            print("Default")
        }
        
    }
    
}

