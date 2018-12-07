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
    
    static func loadSampleItem() -> Account {
        return Account(voornaam: " ", achternaam: " ", straat: " ", nummer: " ", stad: " ")
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
