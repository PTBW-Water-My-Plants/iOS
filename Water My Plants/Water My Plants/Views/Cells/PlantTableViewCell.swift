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
        let image = UIImage(named: imageName)
        plantImageView.image = image?.circleMask
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension UIImage {
var circleMask: UIImage {
    let square = size.width < size.height ? CGSize(width: size.width, height: size.width) : CGSize(width: size.height, height: size.height)
    let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: square))
    imageView.contentMode = UIView.ContentMode.scaleAspectFill
    imageView.image = self
    imageView.layer.cornerRadius = square.width/2
    imageView.layer.borderColor = UIColor.white.cgColor
    imageView.layer.borderWidth = 5
    imageView.layer.masksToBounds = true
    UIGraphicsBeginImageContext(imageView.bounds.size)
    imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
    let result = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return result
    }
}

