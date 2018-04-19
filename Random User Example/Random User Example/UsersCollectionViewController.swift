//
//  UsersCollectionViewController.swift
//  Random User Example
//
//  Created by Diego López Bugna on 18/04/2018.
//  Copyright © 2018 Diego López Bugna. All rights reserved.
//

import UIKit

private let reuseIdentifier = "UserCollectionViewCell"

class UsersCollectionViewController: UICollectionViewController {

    var users: [User]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = NSLocalizedString("usersTitle", comment: "")
        fillUsers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let userDetailVC = segue.destination as? UserDetailViewController {
            let cell = sender as! UserCollectionViewCell
            let indexPath = self.collectionView?.indexPath(for: cell)
            let selectedUser = self.users[indexPath!.row]
            userDetailVC.user = selectedUser
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! UserCollectionViewCell
    
        // Configure the cell
        if let data = self.users![indexPath.row].thumbnail {
            cell.imageView.image = UIImage(data: data)
        }
    
        return cell
    }

    func fillUsers() {
        let userConnector = UserConnector()
        userConnector.getUsers { (users) in
            guard let users = users else {
                self.showGlobalError(buttonPressed: {
                    self.fillUsers()
                })
                return
            }
            self.users = users
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
                self.fillUsersThumbnails()
            }
        }
    }
    
    func fillUsersThumbnails() {
        guard self.users.count > 0 else {
            return
        }
        
        for index in 0...(self.users.count - 1) {
            DispatchQueue.global().async {
                let url = URL(string: self.users[index].thumbnailUrl!)
                if let data = try? Data(contentsOf: url!) {
                    self.users[index].thumbnail = data
                    DispatchQueue.main.async {
                        self.collectionView?.reloadItems(at: [IndexPath(row: index, section: 0)])
                    }
                }
            }
        }
    }
    
    func showGlobalError(buttonPressed: @escaping () -> ()) {
        let alert = UIAlertController(title: NSLocalizedString("errorTitle", comment: ""),
                                      message: NSLocalizedString("errorMessage", comment: ""),
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("tryAgain", comment: ""),
                                      style: .default,
                                      handler: { action in
            buttonPressed()
        }))
        self.present(alert, animated: true)
    }

}
