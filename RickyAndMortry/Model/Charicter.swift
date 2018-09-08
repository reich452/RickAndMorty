//
//  Charicter.swift
//  RickyAndMortry
//
//  Created by Nick Reichard on 9/6/18.
//  Copyright © 2018 Nick Reichard. All rights reserved.
//

import Foundation

struct JsonDictionary: Decodable {
    
    let rmcharacters: [RMCharacter]
    
    private enum CodingKeys: String, CodingKey {
        case rmcharacters = "results"
    }
    
}
struct RMCharacter: Decodable {
    let name: String
    let species: String
    let image: URL
    let id: Int
    let gender: String
    let status: String
    let origin: OriginDictionary
    let location: LocationDictionary
    
    struct OriginDictionary: Decodable {
        let originName: String
        
        private enum CodingKeys: String, CodingKey {
            case originName = "name"
        }
    }

    
    struct LocationDictionary: Decodable {
        let locationName: String
        
        private enum CodingKeys: String, CodingKey {
            case locationName = "name"
        }
    }
    
}



