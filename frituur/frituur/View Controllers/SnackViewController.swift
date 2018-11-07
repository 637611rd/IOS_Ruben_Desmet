import UIKit

class SnackViewController: UIViewController {
    var categorie:Categorie=Categorie(naam: "", beschrijving: "")
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       navigationItem.title=categorie.naam
    }
}
