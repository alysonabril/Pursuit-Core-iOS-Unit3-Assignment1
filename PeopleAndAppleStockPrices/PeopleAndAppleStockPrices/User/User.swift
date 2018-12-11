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
//   let cell: String
//   let nat: String
//   let registered: String
//   let gender: String
    
    let name: Name
    let location: Location
//   let id: Id
    let picture: Picture
}
    struct Name: Codable {
        let title: String
        let first: String
        let last: String
        
        public var fullName: String {
            return first.capitalized + " " + last.capitalized
        }
    }
    
    struct Location: Codable {
        let street: String
        let city: String
        let state: String
        let postcode: String
    }
    
//    struct Id: Codable {
//        let name: String
//        let value: String
//    }
//    
    struct Picture: Codable {
        let large: URL
        let medium: URL
        let thumbnail: URL
    }

