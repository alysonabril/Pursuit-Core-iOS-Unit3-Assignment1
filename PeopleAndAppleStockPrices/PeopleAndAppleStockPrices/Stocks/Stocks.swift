//
//  Stocks.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alyson Abril on 12/10/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

struct Stocks: Codable {
    
    let date: String
    let open: Float
    let high: Float
    let low: Float
    let close: Float
    let volume: Int
    let unadjustedVolume: Int
    let change: Float
    let changePercent: Float
    let label: String
    let changeOverTime: Float
    

}
