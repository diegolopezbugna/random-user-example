//
//  UsersCollectionViewController.swift
//  Random User Example
//
//  Created by Diego López Bugna on 18/04/2018.
//  Copyright © 2018 Diego López Bugna. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class UsersCollectionViewController: UICollectionViewController {

    var users: [User]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fillUsers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

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

//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        NSLog("didSelectItemAt: %i", indexPath.row)
//    }

    func fillUsers() {
        let userConnector = UserConnector()
        userConnector.getUsers { (users) in
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
                let data = try? Data(contentsOf: url!)
                self.users[index].thumbnail = data
                DispatchQueue.main.async {
                    self.collectionView?.reloadItems(at: [IndexPath(row: index, section: 0)])
                }
            }
        }
    }

}
