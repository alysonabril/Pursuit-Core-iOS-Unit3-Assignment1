//
//  Stock.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alyson Abril on 12/12/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation


struct Stock: Codable {
    let date: String
    let open: Double
    let high: Double
    let low: Double
    let close: Double
    let volume: Int
    let unadjustedVolume: Int
    let change: Double
    let changePercent: Double
    let label: String
    let changeOverTime: Double
}

