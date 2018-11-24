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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("in viewdidload")
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        
        if let savedItems = Item.loadFromFile() {
            items = savedItems
        } else {
            items = Item.loadSampleItems()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("in viewwillappear")
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemTableViewCell
        cell.showsReorderControl = true
        
        let item = items[indexPath.row]
        cell.update(with: item)
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            Item.saveToFile(items: items)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedItem = items.remove(at: fromIndexPath.row)
        items.insert(movedItem, at: to.row)
        tableView.reloadData()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditItem" {
            let indexPath = tableView.indexPathForSelectedRow!
            let item = items[indexPath.row]
            let navigationViewController = segue.destination as! UINavigationController
            let addEditItemTableViewController = navigationViewController.topViewController as! AddEditItemTableViewController
            
            addEditItemTableViewController.item = item
        }
    }
    
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
        
    }
    
}
