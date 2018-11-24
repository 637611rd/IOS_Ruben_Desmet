import UIKit

class SnackViewController: UIViewController {
    var categorie:Categorie=Categorie(naam: "", beschrijving: "")
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
         navigationItem.title=categorie.naam
    }
    
   
   
}
