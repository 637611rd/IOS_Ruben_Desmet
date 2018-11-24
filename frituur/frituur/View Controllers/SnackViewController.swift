import UIKit

class SnackViewController: UIViewController {
    var categorie:Categorie=Categorie(naam: "", beschrijving: "")
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
         navigationItem.title=categorie.naam
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
    
   
}
