//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    var users = [UserInfo]() 
    
    @IBOutlet weak var userSearchBar: UISearchBar!
    @IBOutlet weak var userTableView: UITableView!
    
  override func viewDidLoad() {
    super.viewDidLoad()
    userTableView.dataSource = self
    loadData()
    //userSearchBar.delegate = self
  }
    func loadData() {
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json") {
            let myURL = URL.init(fileURLWithPath: path)
            if let data = try? Data.init(contentsOf: myURL) {
                do {
                    let newUsers = try JSONDecoder().decode(User.self, from: data)
                    users = newUsers.results.sorted(by: {$0.name.first < $1.name.first})
                } catch {
                    print(error)
                }
            }
        }
    }
    
}

extension UserViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userTableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        let user = users[indexPath.row]
        let userName = user.name
        cell.textLabel?.text = userName.fullName
        return cell
    }
}


extension UserViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
//        searchMovies(keyword: searchText)
    }
}
