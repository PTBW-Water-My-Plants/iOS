//
//  Constants.swift
//  Water My Plants
//
//  Created by Bohdan Tkachenko on 10/26/20.
//

import Foundation

var dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    return dateFormatter
}()
