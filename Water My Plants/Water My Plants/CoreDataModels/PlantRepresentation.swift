//
//  PlantRepresentation.swift
//  Water My Plants
//
//  Created by Sammy Alvarado on 10/17/20.
//

import Foundation

struct PlantRepresentation: Codable, Equatable {
    var id: String
    var h2oFrequency: Int16
    var imageUrl: String?
    var nickName: String
    var species: String
}
