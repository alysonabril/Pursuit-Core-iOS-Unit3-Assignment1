//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    var users = [UserInfo]() {
        didSet {
        DispatchQueue.main.async {
            self.userTableView.reloadData()
        }
    }
}
    
    @IBOutlet weak var userSearchBar: UISearchBar!
    @IBOutlet weak var userTableView: UITableView!
    
  override func viewDidLoad() {
    super.viewDidLoad()
    users = loadData()
    userTableView.dataSource = self
    userSearchBar.delegate = self
  }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let userDetailController = segue.destination as? UserDetailViewController,
            let indexPath = userTableView.indexPathForSelectedRow
            else { fatalError("no bueno") }
         let userSelected = users[indexPath.row]
        userDetailController.user = userSelected
    }
    
    private func loadData() -> [UserInfo] {
        var newUser = [UserInfo]()
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json") {
            let myURL = URL.init(fileURLWithPath: path)
            if let data = try? Data.init(contentsOf: myURL) {
                do {
                    let newUsers = try JSONDecoder().decode(User.self, from: data)
                    newUser = newUsers.results.sorted(by: {$0.name.first < $1.name.first})
                } catch {
                    print(error)
                }
            }
        }
        return newUser
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
        let userLocation = user.location
        cell.textLabel?.text = userName.fullName
        cell.detailTextLabel?.text = userLocation.fullLocation
        return cell
    }
}


extension UserViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let userText = searchBar.text else { return }
        if userText != "" {
            users = loadData()
            users = users.filter() {$0.name.fullName.contains(userText)}
        } else {
            users = loadData()
        }
    }
}
