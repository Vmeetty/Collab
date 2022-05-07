//
//  TableViewController.swift
//  Collab
//
//  Created by user on 07.05.2022.
//

import UIKit

class TableViewController: UITableViewController {
    
    var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()

        users.append(User(name: "Vlad", role: "Tranie"))
        users.append(User(name: "Slava", role: "Senior"))
        users.append(User(name: "Kolja", role: "Senior"))
        users.append(User(name: "Anton", role: "Brat"))
        users.append(User(name: "Olja", role: "Love"))

    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count - 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.Id.cellId, for: indexPath) as! TableViewCell
        cell.nameLabel.text = users[indexPath.row].name
        cell.rolLabel.text = users[indexPath.row].role
        let defaultImage = UIImage(systemName: K.Images.personImage)!
        cell.imageImageView.image = users[indexPath.row].image ?? defaultImage
        
        
        
        return cell
    }
    

}
