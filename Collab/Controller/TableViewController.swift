//
//  TableViewController.swift
//  Collab
//
//  Created by user on 07.05.2022.
//

import UIKit

class TableViewController: UITableViewController {
    
    var users = [User]()
    let dbManager = DatabaseManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        dbManager.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        users = []
        dbManager.loadUsers()
    }
    
    
    @IBAction func settingsPressed(_ sender: UIBarButtonItem) {
        Service.shared.showActionSheetBy(viewController: self)
    }
    
    

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.Id.cellId, for: indexPath) as! TableViewCell
        cell.nameLabel.text = users[indexPath.row].name
        cell.rolLabel.text = users[indexPath.row].role
        if let imageUrl = users[indexPath.row].url {
            cell.imageImageView.loadImageUsingCashWithUrlString(urlString: imageUrl)
        } else {
            cell.imageImageView.image = UIImage(systemName: K.Images.personImage)
        }
        Service.shared.configProfileImageView(cell.imageImageView)
        Service.shared.configCellButtons(cell.callButton)
        Service.shared.configCellButtons(cell.videoCallButton)
        
        
        return cell
    }
}


extension TableViewController: DatabaseManagerDelegate {
    func getUser(_ newUser: User) {
        self.users.append(newUser)
        self.tableView.reloadData()
    }
}
