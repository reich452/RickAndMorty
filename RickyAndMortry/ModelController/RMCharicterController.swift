//
//  RMCharicterController.swift
//  RickyAndMortry
//
//  Created by Nick Reichard on 9/6/18.
//  Copyright © 2018 Nick Reichard. All rights reserved.
//

import UIKit
// 1) Shared
// 2) SOURCE OF TRUTH
// 3) What are you completing with
// 4) URLSESSION - Reverse Enineer
// 5) Build our URL


class RMCharicterController {
    
    static let shared = RMCharicterController()
    
    // Makes it so we can't create instances outside of this clas
    private init() {}
    
    var characters: [RMCharacter] = []
    
    let baseURL = URL(string: "https://rickandmortyapi.com/api/character")
    
     // TODO get the individual
    func fetchCharacter(idString: String?, completion: @escaping ([RMCharacter]?, RMCharacter?) -> Void) {
       
        guard var url = baseURL else {
            fatalError("Bad base url")
        }
    
        if let idString = idString {
            url = url.appendingPathComponent(idString)
        }
    
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let error = error {
                print("Error with dataTask: \(#function) \(error) \(error.localizedDescription)")
                completion([], nil); return
            }
            
            guard let data = data else { completion([], nil); return }
            
            do {
              
                if idString != nil {
                    // We only want one Character. The Json results does not include the results array in this one
                    let rmCharater = try JSONDecoder().decode(RMCharacter.self, from: data)
                    // we need to remove all values in the existing source of truth
                    self.characters.removeAll()
                    // append the new result (should just be one character)
                    self.characters.append(rmCharater)
                    // we have to say we are completing with an empty array but we are completing with one rmCharater
                    completion([], rmCharater)
            
                } else {
                    let charaters = try JSONDecoder().decode(JsonDictionary.self, from: data).rmcharacters
                    self.characters = charaters
                    
                    completion(charaters, nil)
                    
                }
                
            } catch let error {
                print("Error with our JSONDecoder:  \(error) \(error.localizedDescription)")
                completion([], nil); return
            }
            
        }.resume()
    }
    
    // TODO - come back and add this in the objectFetch 
    func fetchImage(rmCharacter: RMCharacter, completion: @escaping (UIImage?) -> Void) {

        URLSession.shared.dataTask(with: rmCharacter.image) { (data, _, error) in

            do {

                if let error = error { throw error }

                guard let data = data else { throw NSError() }

                let image = UIImage(data: data)
                completion(image)

            } catch let error {
                print("Error fetcing image \(error) \(error.localizedDescription)")
                completion(nil); return
            }

        }.resume()
    }
    
}












