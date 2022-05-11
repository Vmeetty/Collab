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
    
    let shared = Service.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
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
        cell.indexPath = indexPath
        cell.delegate = self
        cell.callButton.isHidden = users[indexPath.row].phoneNumber != nil ? false : true
        
        if let imageUrl = users[indexPath.row].url {
            cell.imageImageView.loadImageUsingCashWithUrlString(urlString: imageUrl)
        } else {
            cell.imageImageView.image = UIImage(systemName: K.Images.personImage)
        }
        
        shared.configProfileImageView(cell.imageImageView)
        shared.configCellButtons(cell.videoCallButton)
        
        return cell
    }
    
}


extension TableViewController: DatabaseManagerDelegate {
    func getUser(_ newUser: User) {
        self.users.append(newUser)
        self.tableView.reloadData()
    }
}

extension TableViewController: TableViewCellDelegate {
    func callPressed(indexPath: IndexPath) {
        guard let numberStr = users[indexPath.row].phoneNumber else { return }
        shared.makeACallWith(number: numberStr, viewController: self)
    }
    
    func videoCallPressed(indexPath: IndexPath) {
        performSegue(withIdentifier: "VIdeoVCSegue", sender: self)
    }
}
