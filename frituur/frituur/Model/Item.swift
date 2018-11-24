//
//  Item.swift
//  frituur
//
//  Created by Ruben Desmet on 24/11/2018.
//  Copyright © 2018 Ruben Desmet. All rights reserved.
//

import Foundation
class Item: Codable{
    var naam: String
    
    init(naam:String) {
        self.naam = naam
       
    }
    
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("items").appendingPathExtension("plist")
    
    static func loadSampleItems() -> [Item] {
        return [Item(naam: "Test")]
    }
    
    static func saveToFile(items: [Item]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedItems = try? propertyListEncoder.encode(items)
        
        try? codedItems?.write(to: ArchiveURL, options: .noFileProtection)
    }
    
    static func loadFromFile() -> [Item]? {
        guard let codedItems = try? Data(contentsOf: ArchiveURL) else { return nil }
        
        let propertyListDecoder = PropertyListDecoder()
        
        return try? propertyListDecoder.decode(Array<Item>.self, from: codedItems)
    }
}

