//
//  UserDetailViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alyson Abril on 12/10/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {

    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userDobLabel: UILabel!
    @IBOutlet weak var userPhoneLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userLocationLabel: UILabel!
    
    public var user: UserInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUserInfo()
    }
    
    
    func updateUserInfo () {
        userNameLabel.text = user.name.fullName
        userDobLabel.text = user.dob
        userPhoneLabel.text = user.phone
        userEmailLabel.text = user.email
        userLocationLabel.text = user.location.fullLocation
        do {
            let imageData = try Data(contentsOf: user.picture.large)
            userImageView.image = UIImage.init(data: imageData)
        } catch {
            print("Error: \(error)")
        }
    }

}
