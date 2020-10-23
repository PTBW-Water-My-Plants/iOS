//
//  MockData.swift
//  Water My Plants
//
//  Created by Bohdan Tkachenko on 10/19/20.
//

import Foundation

class MockData {
    static let plantMock = PlantRepresentation(id: UUID().uuidString,
                                               h2oFrequency: 1,
//                                              h2oFrequency: 10,
                                              imageUrl: "https://www.todayifoundout.com/wp-content/uploads/2014/02/apple-tree.jpg",
                                              nickName: "Apple Tree",
                                              species: "Trees")
    
    static let plants: [PlantRepresentation] = [plantMock]
    
    
}
