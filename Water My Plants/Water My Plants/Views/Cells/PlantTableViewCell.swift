//
//  PlanetTableViewCell.swift
//  Water My Plants
//
//  Created by Bohdan Tkachenko on 10/19/20.
//

import UIKit

class PlantTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "PlantCell"
    
    @IBOutlet var plantImageView: UIImageView!
    @IBOutlet var plantName: UILabel!
    @IBOutlet var h2oFrequency: UILabel!
    
    let imageName = "plantExample"

    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        let image = UIImage(named: imageName)
//        plantImageView.image = image?.circleMask
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


