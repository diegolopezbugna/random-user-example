//
//  UserDetailViewController.swift
//  Random User Example
//
//  Created by Diego López Bugna on 19/04/2018.
//  Copyright © 2018 Diego López Bugna. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {

    @IBOutlet weak var largeImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var firstnameLabel: UILabel!
    @IBOutlet weak var lastnameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = NSLocalizedString("userDetailTitle", comment: "")
        fillUser()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fillUser() {
        usernameLabel.text = user.username
        firstnameLabel.text = user.firstName
        lastnameLabel.text = user.lastName
        emailLabel.text = user.email
        
        DispatchQueue.global().async {
            let url = URL(string: self.user.largeImageUrl!)
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async { [weak self] in
                guard let data = data else { return }
                self?.largeImageView.image = UIImage(data: data)
            }
        }
        

    }
}
