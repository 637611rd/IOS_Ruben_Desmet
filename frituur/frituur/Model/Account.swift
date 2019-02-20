//
//  Account.swift
//  frituur
//
//  Created by Ruben Desmet on 28/11/2018.
//  Copyright © 2018 Ruben Desmet. All rights reserved.
//

import Foundation
class Account:Codable{
    var voornaam:String
    var achternaam:String
    var straat:String
    var nummer:String
    var stad:String
    
    
    
    init(voornaam:String,achternaam:String,straat:String,nummer:String,stad:String) {
        self.voornaam = voornaam
        self.achternaam=achternaam
        self.straat=straat
        self.nummer=nummer
        self.stad=stad
        
    }
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("account").appendingPathExtension("plist")
    
    static func geefGegevens() -> Account?{
        var acc = Account(voornaam: "", achternaam: "", straat: "", nummer: "", stad: "")
        
        
        return acc
    }
    
    static func krijgGegevensVanDb(){
        
        ref.child("Account").observe(.value, with: {(snapshot) in
            
            if let result = snapshot.children.allObjects as? [DataSnapshot] {
                
                for child in result {
                    
                    let naamID = child.key as String //get autoID
                    
                    self.ref.child("snacks/\(naamID)/naam").observe(.value, with: { (snapshot) in
                        if let nameDB = snapshot.value as? String {
                            
                            self.naam=nameDB
                            self.snackItems.append(Item(naam: self.naam))
                            print("hierin")
                            
                            
                        }
                        print(self.snackItems)
                        Item.saveToSnacksFile(items: self.snackItems)
                    })
                }
                
            }
        })
    }
    
    static func saveToFile(account: Account) {
        let propertyListEncoder = PropertyListEncoder()
        let codedAccount = try? propertyListEncoder.encode(account)
        
        try? codedAccount?.write(to: ArchiveURL, options: .noFileProtection)
        
    }
    
    static func loadFromFile() -> Account? {
        guard let codedAccount = try? Data(contentsOf: ArchiveURL) else { return nil }
        
        let propertyListDecoder = PropertyListDecoder()
        
        return try? propertyListDecoder.decode(Account.self, from: codedAccount)
    }
}
