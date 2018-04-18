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

    var users: [User]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getUsers()
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
        return users?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! UserCollectionViewCell
    
        // Configure the cell
        cell.imageView.backgroundColor = .black
    
        return cell
    }

//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        NSLog("didSelectItemAt: %i", indexPath.row)
//    }

    func getUsers() {
        let userConnector = DummyUserConnector()
        userConnector.getUsers { (users) in
            self.users = users
            self.collectionView?.reloadData()   // mainQueue?
        }
    }
}
