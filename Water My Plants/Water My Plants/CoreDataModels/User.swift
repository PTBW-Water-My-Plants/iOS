//
//  File.swift
//  Water My Plants
//
//  Created by Sammy Alvarado on 10/17/20.
//

import Foundation


struct User: Codable, Equatable {
    let username: String
    let password: String
    let email: String
}
