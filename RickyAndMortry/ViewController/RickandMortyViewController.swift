//
//  ViewController.swift
//  RickyAndMortry
//
//  Created by Nick Reichard on 9/6/18.
//  Copyright © 2018 Nick Reichard. All rights reserved.
//

import UIKit

class RickandMortyViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var rickAndMortyTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        // We have to do this because we are using a ViewController
        // Now the VC know it has a TVC living within it
        rickAndMortyTableView.delegate = self
        rickAndMortyTableView.dataSource = self
        rickAndMortyTableView.prefetchDataSource = self
        rickAndMortyTableView.estimatedRowHeight = 550
        loadCharacters()
    }
    
    func loadCharacters() {
        RMCharicterController.shared.fetchCharacter(idString: nil) { (rmCharacters, rmCharacter)  in
            
            DispatchQueue.main.async {
                self.rickAndMortyTableView.reloadData()
                print("🦊 reload data")

            }
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text,
            searchText != "" && searchText != " " else { return }
        RMCharicterController.shared.fetchCharacter(idString: searchText) { (rmCharacters, rmCharacter) in
            DispatchQueue.main.async {
                self.rickAndMortyTableView.reloadData()
            }
        }
    }


}

extension RickandMortyViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("🤖 Number of rowsInSection is called")
        return RMCharicterController.shared.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as? RicandMortyTableViewCell else { return UITableViewCell() }
        
        let rmCharacter = RMCharicterController.shared.characters[indexPath.row]
        print("👻 Cell for row at is called")

        cell.rmCharacter = rmCharacter
    
        return cell 
    }
}

extension RickandMortyViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        for indxPath in indexPaths {
            
            let rmCharacter = RMCharicterController.shared.characters[indxPath.row]
            let url = rmCharacter.image
            print("WE are prefetching \(rmCharacter.name) now 🐧")
            URLSession.shared.dataTask(with: url).resume()
        }
        
    }
    
}









