//
//  ItemTableViewCell.swift
//  frituur
//
//  Created by Ruben Desmet on 24/11/2018.
//  Copyright © 2018 Ruben Desmet. All rights reserved.
//

import UIKit
class ItemTableViewCell: UITableViewCell {
    
   
    @IBOutlet weak var itemNaam: UILabel!
    
    func update(with item: Item) {
        itemNaam.text=item.naam
    }
}
