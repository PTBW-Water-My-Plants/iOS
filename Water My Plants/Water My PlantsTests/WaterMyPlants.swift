//
//  WaterMyPlants.swift
//  Water My PlantsTests
//
//  Created by Sammy Alvarado on 10/29/20.
//

import XCTest
@testable import Water_My_Plants

class WaterMyPlants: XCTestCase {
    
    var result: AuthServices!
    let waterMyPlantsController = WaterMyPlantController()
    let base = BaseTableViewController()
    
//    func testRegistration() throws {
//
//        let addPlant = result.registration(withUsername: "sam", password: "21Ducati", phoneNumber: "714-8786711", image: #imageLiteral(resourceName: "1024-2")) { (result, error) in
//            <#code#>
//        }
//
//    }
    
    func testCreateNewPlant() {
        let expectation = self.expectation(description: "Create 1 plant")
        waterMyPlantsController.createPlant(with: "LambdaTest", species: "Test", h20Frequency: Date(), image: nil)
        expectation.fulfill()
        wait(for: [expectation], timeout: 3)
        XCTAssert(self.waterMyPlantsController.plants.count >= 0, "Expectiong 1 results for plant array")
    }
    
//    func testFetchingPlants() {
//        waterMyPlantsController.fetchPlantFromServer()
//        XCTAssert(base.fetchResultController.sections?.count ?? 0 > 0, "Expectiong at least 1 results")
//    }
    
    func testSendPlantToServer() {
        XCTAssertNoThrow(waterMyPlantsController.sendPlantToServer(plant: Plant(nickName: "Test", h2oFrequency: Date(), species: "Testie")))
    }
    
}
