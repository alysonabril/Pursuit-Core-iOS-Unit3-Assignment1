//
//  StockDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alyson Abril on 12/14/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StockDetailViewController: UIViewController {

    public var stock: [Stock]!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var closeLabel: UILabel!   
    @IBOutlet weak var thumbsUpDownPic: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateStockInfo()
    }
    
    func updateStockInfo () {
        let stocks = stock[0]
        dateLabel.text = stocks.date
        openLabel.text = String(format:"Open: %.2f", stocks.open)
        closeLabel.text = String(format:"Close: %.2f", stocks.close)
        if stocks.open < stocks.close {
            view.backgroundColor = UIColor.init(red: 96/255, green: 209/255, blue: 101/255, alpha: 1)
            thumbsUpDownPic.image = UIImage(named: "thumbsUp")
        } else {
            view.backgroundColor = UIColor.init(red: 242/255, green: 46/255, blue: 46/255, alpha: 1)
            thumbsUpDownPic.image = UIImage(named: "thumbsDown")
        }
    }
    
}
