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
    func fetchCharicter(completion: @escaping ([RMCharacter]?) -> Void) {
       
        guard let url = baseURL else {
            fatalError("Bad base url")
        }
    
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let error = error {
                print("Error with dataTask: \(#function) \(error) \(error.localizedDescription)")
                completion([]); return
            }
            
            guard let data = data else { completion([]); return }
            
            do {
                let charaters = try JSONDecoder().decode(JsonDictionary.self, from: data).rmcharacters
                self.characters = charaters
                
                completion(charaters)
                
                
            } catch let error {
                print("Error with our JSONDecoder:  \(error) \(error.localizedDescription)")
                completion([]); return
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












