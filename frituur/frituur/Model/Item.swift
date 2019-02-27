
import Foundation
import Firestore

protocol DocumentSerializable  {
    init?(dictionary:[String:Any])
}


struct Item {
    var naam:String
    
    
    var dictionary:[String:Any] {
        return [
            "naam":naam
        ]
    }
    
}

extension Item : DocumentSerializable {
    init?(dictionary: [String : Any]) {
        guard let naam = dictionary["naam"] as? String
            else {return nil}
        
        self.init(naam: naam)
    }
}

//Hieronder Item klasse toen er nog geen database gebruikt werd.
//
//  Item.swift
//  frituur
//
//  Created by Ruben Desmet on 24/11/2018.
//  Copyright © 2018 Ruben Desmet. All rights reserved.
//

/*import Foundation
 class Item: Codable{
 
 
 var naam: String
 
 init(naam:String) {
 self.naam = naam
 
 }
 
 static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
 
 static let ArchiveURLSnacks = DocumentsDirectory.appendingPathComponent("snacks").appendingPathExtension("plist")
 
 static let ArchiveURLDrank = DocumentsDirectory.appendingPathComponent("drank").appendingPathExtension("plist")
 
 static let ArchiveURLFrieten = DocumentsDirectory.appendingPathComponent("frieten").appendingPathExtension("plist")
 
 
 
 static func saveToSnacksFile(items: [Item]) {
 let propertyListEncoder = PropertyListEncoder()
 let codedItems = try? propertyListEncoder.encode(items)
 
 try? codedItems?.write(to: ArchiveURLSnacks, options: .noFileProtection)
 }
 
 static func saveToDrankFile(items: [Item]) {
 let propertyListEncoder = PropertyListEncoder()
 let codedItems = try? propertyListEncoder.encode(items)
 
 try? codedItems?.write(to: ArchiveURLDrank, options: .noFileProtection)
 }
 
 static func saveToFrietenFile(items: [Item]) {
 let propertyListEncoder = PropertyListEncoder()
 let codedItems = try? propertyListEncoder.encode(items)
 
 try? codedItems?.write(to: ArchiveURLFrieten, options: .noFileProtection)
 }
 
 static func loadFromSnacksFile() -> [Item]? {
 guard let codedItems = try? Data(contentsOf: ArchiveURLSnacks) else { return nil }
 
 let propertyListDecoder = PropertyListDecoder()
 
 return try? propertyListDecoder.decode(Array<Item>.self, from: codedItems)
 }
 
 static func loadFromDrankFile() -> [Item]? {
 guard let codedItems = try? Data(contentsOf: ArchiveURLDrank) else { return nil }
 
 let propertyListDecoder = PropertyListDecoder()
 
 return try? propertyListDecoder.decode(Array<Item>.self, from: codedItems)
 }
 
 static func loadFromFrietenFile() -> [Item]? {
 guard let codedItems = try? Data(contentsOf: ArchiveURLFrieten) else { return nil }
 
 let propertyListDecoder = PropertyListDecoder()
 
 return try? propertyListDecoder.decode(Array<Item>.self, from: codedItems)
 }
 
 
 }*/


