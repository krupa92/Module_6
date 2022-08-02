//
//  SearchBusiness.swift
//  City Sights App
//
//  Created by Krupa Patel on 2/8/2022.
//

import Foundation

struct SearchBusiness:Decodable {
    
    var businesses = [Business]()
    var total = 0
    var region = Region()
}

struct Region:Decodable {
    
    var center = Coordinates()
}
