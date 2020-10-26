//
//  EncodeDecodeImage.swift
//  Water My Plants
//
//  Created by Bohdan Tkachenko on 10/26/20.
//

import Foundation
import UIKit


public struct EncodeDecodeImage {
    
   static func convertImageToBase64String (img: UIImage) -> String {
        return img.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
    
   static func convertBase64StringToImage (imageBase64String:String) -> UIImage? {
        let imageData = Data.init(base64Encoded: imageBase64String, options: .init(rawValue: 0))
        let image = UIImage(data: imageData!)
        return image
    }

}
