//
//  Profielfoto.swift
//  frituur
//
//  Created by Ruben Desmet on 20/02/2019.
//  Copyright © 2019 Ruben Desmet. All rights reserved.
//

import Foundation
import UIKit
class Profielfoto: Codable{
    
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("profielfoto").appendingPathExtension("plist")
    
    
    static func saveToFile(foto: String) {
        let propertyListEncoder = PropertyListEncoder()
        let codedProfielfoto = try? propertyListEncoder.encode(foto)
        
        try? codedProfielfoto?.write(to: ArchiveURL, options: .noFileProtection)
        
    }
    
    static func loadFromFile() -> Profielfoto? {
        guard let codedProfielfoto = try? Data(contentsOf: ArchiveURL) else { return nil }
        
        let propertyListDecoder = PropertyListDecoder()
        
        return try? propertyListDecoder.decode(Profielfoto.self, from: codedProfielfoto)
    }
}
