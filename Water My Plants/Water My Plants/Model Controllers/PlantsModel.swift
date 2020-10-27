//
//  PlantsModel.swift
//  Water My Plants
//
//  Created by Gladymir Philippe on 10/26/20.
//

import Foundation

struct PlantsModel {
    private var plants = [Plant]()

    var count: Int {
        return plants.count
    }

    init(testing: Bool = false) {

    }
    
    mutating func add(_ plant: Plant) {
        plants.append(plant)
    }
}
