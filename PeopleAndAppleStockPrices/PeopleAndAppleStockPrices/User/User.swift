//
//  User.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alyson Abril on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation


struct User: Codable {
    let results: [UserInfo]
}


struct UserInfo: Codable {
    let email: String
    let dob: String
    let phone: String
    let name: Name
    let location: Location
    let picture: Picture
}
    struct Name: Codable {
        let first: String
        let last: String
        
        public var fullName: String {
            return first.capitalized + " " + last.capitalized
        }
    }
    
    
    struct Location: Codable {
        let city: String
        let state: String
        public var fullLocation: String {
            return "\(city.capitalized), \(state.capitalized)"
        }
    }
    
   
    struct Picture: Codable {
        let large: URL
        let medium: URL
        let thumbnail: URL
    }

