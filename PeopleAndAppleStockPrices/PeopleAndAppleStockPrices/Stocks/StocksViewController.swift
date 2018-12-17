//
//  StocksViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alyson Abril on 12/10/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class StocksViewController: UIViewController {
    
    var stockInfo = [[Stock]]()
    var stocks = [Stock]() 
        
    
    @IBOutlet weak var stockTableView: UITableView! 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Stocks"
        stockInfo = makeSections()
        stockTableView.dataSource = self
        stockTableView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let stockDetailController = segue.destination as? StockDetailViewController,
            let indexPath = stockTableView.indexPathForSelectedRow
            else { fatalError ("no bueno") }
        let stockSelected = stockInfo[indexPath.row]
        stockDetailController.stock = stockSelected
    }
    
    func getMonthYear(dateString: String) -> (month: String, year: String) {
        let components = dateString.components(separatedBy: "-")
        return (components[1], components[0])
    }
    
    private func makeSections() -> [[Stock]] {
        var stockPriceSections = [[Stock]]()
        if let stockResults = loadData() {
            stockPriceSections.append([Stock]())
            
            var startIndex = 0
            var date = (month: "12", year:"2016")
            
            
            for stockPrice in stockResults {
                if date != getMonthYear(dateString: stockPrice.date){
                    date = getMonthYear(dateString: stockPrice.date)
                    stockPriceSections.append([Stock]())
                    startIndex += 1
                }
                stockPriceSections[startIndex].append(stockPrice)
            }
        }
        return stockPriceSections
    }
    
     func loadData() -> [Stock]? {
        var stocks: [Stock]?
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
            let myURL = URL.init(fileURLWithPath: path)
            if let data = try? Data.init(contentsOf: myURL) {
                do {
                    stocks = try JSONDecoder().decode([Stock].self, from: data)
                } catch {
                    print(error)
                }
            }
        }
        return stocks
    }
}


extension StocksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockInfo[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stockTableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
        let stock = stockInfo[indexPath.section][indexPath.row]
        cell.textLabel?.text = stock.date
        cell.detailTextLabel?.text = String(stock.open)
        return cell
    }
    
}


extension StocksViewController: UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return stockInfo.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let monthDictionary = [01: "Jan", 02:"Feb", 03:"Mar", 04: "Apr", 05:"May", 06:"Jun", 07: "Jul", 08:"Aug", 09:"Sep", 10: "Oct", 11:"Nov", 12: "Dec" ]
        
        var stringToReturn = ""
        let accessToDateForSection = getMonthYear(dateString: stockInfo[section][0].date)
        let sumOfMonthOpenPrice = stockInfo[section].reduce(0){$0 + $1.open}
        let averageOfOpenPrice = sumOfMonthOpenPrice / Double(stockInfo[section].count)
        
        for (key, value) in monthDictionary{
            if Int(accessToDateForSection.month) == key {
                stringToReturn = "\(accessToDateForSection.year) - \(value).            Average: $\(String(format: "%.2f", averageOfOpenPrice))"
            }
        }
        return stringToReturn
        
    }
    
}


