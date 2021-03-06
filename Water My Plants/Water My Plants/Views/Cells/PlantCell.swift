//
//  PlantCell.swift
//  Water My Plants
//
//  Created by Bohdan Tkachenko on 10/20/20.
//

import UIKit

protocol PlantCellDelegate: class {
    func didUpdatePlant(plant: Plant)
}

class PlantCell : UITableViewCell {
    
    
    weak var delegate: PlantCellDelegate?
    
    var plant: Plant? {
        didSet {
            updateViews()
        }
    }
    
    private let plantNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 28)
        lbl.textAlignment = .left
        return lbl
    }()
    
    
    private let h20Label : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    
    private let plantImage : UIImageView = {
        //        let imgView = UIImageView(image: #imageLiteral(resourceName: "0259a365e0a17ef2ebee2176cb3126e5").circleMask)
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(plantImage)
        addSubview(h20Label)
        addSubview(plantNameLabel)
        
        plantImage.anchor(top: topAnchor,
                          left: leftAnchor,
                          bottom: nil,
                          right: nil,
                          paddingTop: 5,
                          paddingLeft: 5,
                          paddingBottom: 5,
                          paddingRight: 0,
                          width: 90,
                          height: 90,
                          enableInsets: false)
        
        plantNameLabel.anchor(top: topAnchor,
                              left: plantImage.rightAnchor,
                              bottom: nil,
                              right: nil,
                              paddingTop: 20,
                              paddingLeft: 10,
                              paddingBottom: 0,
                              paddingRight: 0,
                              width: frame.size.width / 2,
                              height: 0, enableInsets: false)
        
        h20Label.anchor(top: plantNameLabel.bottomAnchor,
                        left: plantImage.rightAnchor,
                        bottom: nil,
                        right: nil,
                        paddingTop: 0,
                        paddingLeft: 10,
                        paddingBottom: 0,
                        paddingRight: 0,
                        width: frame.size.width / 2,
                        height: 0,
                        enableInsets: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
    private func updateViews() {
        guard let stringURL = plant?.imageUrl else { return }
        
        if let url = URL(string: stringURL),
           let data = try? Data(contentsOf: url) {
            plantImage.image = UIImage(data: data)?.circleMask
        }
        guard let h20 = plant?.h2oFrequency else { return }
        
        
        plantNameLabel.text = plant?.nickName
        h20Label.text = "Water me on: \(dateFormatter.string(from: h20))"
    }
    
}

extension UIImage {
    var circleMask: UIImage {
        let square = size.width < size.height ? CGSize(width: size.width, height: size.width) : CGSize(width: size.height, height: size.height)
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: square))
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.image = self
        imageView.layer.cornerRadius = square.width / 2
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 5
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        UIGraphicsBeginImageContext(imageView.bounds.size)
        imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let result = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return result
    }
}

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?,
                left: NSLayoutXAxisAnchor?,
                bottom: NSLayoutYAxisAnchor?,
                right: NSLayoutXAxisAnchor?,
                paddingTop: CGFloat,
                paddingLeft: CGFloat,
                paddingBottom: CGFloat,
                paddingRight: CGFloat,
                width: CGFloat,
                height: CGFloat,
                enableInsets: Bool) {
        var topInset = CGFloat(0)
        var bottomInset = CGFloat(0)
        
        if #available(iOS 11, *), enableInsets {
            let insets = self.safeAreaInsets
            topInset = insets.top
            bottomInset = insets.bottom
            
            print("Top: \(topInset)")
            print("bottom: \(bottomInset)")
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop+topInset).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom-bottomInset).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
    }
    
}







