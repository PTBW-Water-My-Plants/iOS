//
//  PlantCellsTableViewCell.swift
//  Water My Plants
//
//  Created by Gladymir Philippe on 10/22/20.
//

import UIKit

class PlantCellsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var species: UILabel!
    @IBOutlet weak var h2oFrequency: UILabel!
    
    var plantController: WaterMyPlantController?
    var plant: Plant? {
        didSet {
        }
    }

    private func updateViews() {
        nickName.text = plant?.nickName
        species.text = plant?.species
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
