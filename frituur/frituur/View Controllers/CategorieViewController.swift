

import UIKit

class CategorieViewController: UITableViewController {
    
    var categorieSelected:Categorie=Categorie(naam: "", beschrijving: "")
   
    
    var categories: [Categorie] = [
        Categorie(naam: "Snacks", beschrijving: "Frikandel, Boulet, ..."),
        Categorie(naam: "Drank", beschrijving: "Coca-Cola, Fanta, ..."),
        Categorie(naam: "Frieten", beschrijving: "Groot, Middel, Klein")
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return categories.count
        } else {
            return 0
        }}
    
    //Voor iedere cell de categorie invullen met beschrijving
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
            "CategorieCell", for: indexPath)
        
        let categorie = categories[indexPath.row]
        
        cell.textLabel?.text = "\(categorie.naam)"
        cell.detailTextLabel?.text = categorie.beschrijving
        
        cell.showsReorderControl=true
        
        return cell
    }
    
    //Als je klikt op een categorie wordt de categorie meegegeven naar het volgende scherm.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        let indexPath = tableView.indexPathForSelectedRow!
         categorieSelected = categories[indexPath.row]
        let tableViewController = segue.destination as! UITableViewController
        let itemTableViewController = tableViewController as! ItemTableViewController
        itemTableViewController.categorie=self.categorieSelected
      
        print(self.categorieSelected.naam)
        
    }
    
    
   //Oorspronkelijk stond er edit vanboven. Deze methode zorgde ervoor dat je de elementen van plaats kon verwisselen.
    override func tableView(_ tableView: UITableView, moveRowAt
        fromIndexPath: IndexPath, to: IndexPath) {
        let movedCategorie = categories.remove(at: fromIndexPath.row)
        categories.insert(movedCategorie, at: to.row)
        tableView.reloadData()
        
    }
    
    //Dit was ook een methode die bij "edit" aangeropen werd.
    override func tableView(_ tableView: UITableView,
                            editingStyleForRowAt indexPath: IndexPath) ->
        UITableViewCell.EditingStyle {
            return .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
}

