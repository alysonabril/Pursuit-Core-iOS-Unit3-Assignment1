//
//  StocksViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alyson Abril on 12/10/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StocksViewController: UIViewController {
    
    var stocks = [Stock]() 
        
    
    @IBOutlet weak var stockTableView: UITableView! 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        stockTableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let stockDetailController = segue.destination as? StockDetailViewController,
            let indexPath = stockTableView.indexPathForSelectedRow
            else { fatalError ("no bueno") }
        let stockSelected = stocks[indexPath.row]
        stockDetailController.stock = stockSelected
    }
    
    private func loadData() {
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
            let myURL = URL.init(fileURLWithPath: path)
            if let data = try? Data.init(contentsOf: myURL) {
                do {
                    self.stocks = try JSONDecoder().decode([Stock].self, from: data)
                } catch {
                    print(error)
                }
            }
        }
    }
    
}


extension StocksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stockTableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
        let stock = stocks[indexPath.row]
        cell.textLabel?.text = stock.date
        cell.detailTextLabel?.text = String(stock.open)
        return cell
    }
    
}
