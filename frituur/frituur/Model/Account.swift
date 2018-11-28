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
}
