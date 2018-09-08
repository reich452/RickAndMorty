//
//  RicandMortyTableViewCell.swift
//  RickyAndMortry
//
//  Created by Nick Reichard on 9/6/18.
//  Copyright © 2018 Nick Reichard. All rights reserved.
//

import UIKit

class RicandMortyTableViewCell: UITableViewCell {

    @IBOutlet weak var heroView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var backdropVisualEffectView: UIVisualEffectView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var statusContainerView: UIView!
    
    // MARK: - Properties
    
    // this is the object that is getting DQueued in each cell
    var rmCharacter: RMCharacter? {
        didSet {
            updateViews()
        }
    }
    
    func setupUI() {
        profileImageView.layer.cornerRadius = 5
    }
    
    func updateViews() {
        guard let rmCharacter = rmCharacter else { return }
        nameLabel.text = rmCharacter.name
        idLabel.text = "id: \(rmCharacter.id) "
        statusLabel.text = rmCharacter.status
        speciesLabel.text = rmCharacter.species
        genderLabel.text = rmCharacter.gender
        genderLabel.text = rmCharacter.origin.originName
        locationLabel.text = rmCharacter.location.locationName
        RMCharicterController.shared.fetchImage(rmCharacter: rmCharacter) { (image) in
            DispatchQueue.main.async {
                self.profileImageView.image = image
            }
        }
    }
    
}
