

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
        // Do any additional setup after loading the view, typically from a nib.
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
            "CategorieCell", for: indexPath)
        
        let categorie = categories[indexPath.row]
        
        cell.textLabel?.text = "\(categorie.naam)"
        cell.detailTextLabel?.text = categorie.beschrijving
        
        cell.showsReorderControl=true
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt
        indexPath: IndexPath) {
        self.categorieSelected = categories[indexPath.row]
        
        print("\(categorieSelected.naam) \(indexPath)")
    }
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let des = segue.destination as! SnackViewController
        des.categorie=self.categorieSelected
        print(self.categorieSelected.naam)
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, moveRowAt
        fromIndexPath: IndexPath, to: IndexPath) {
        let movedCategorie = categories.remove(at: fromIndexPath.row)
        categories.insert(movedCategorie, at: to.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView,
                            editingStyleForRowAt indexPath: IndexPath) ->
        UITableViewCell.EditingStyle {
            return .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
}

