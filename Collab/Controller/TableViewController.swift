//
//  TableViewController.swift
//  Collab
//
//  Created by user on 07.05.2022.
//

import UIKit

class TableViewController: UITableViewController {
    
    @IBOutlet weak var profileIcon: UIImageView!
    @IBOutlet weak var searchIcon: UIImageView!
    @IBOutlet weak var searchTextField: UITextField!
    
    
    var users = [User]()
    let dbManager = DatabaseManager()
    let shared = Service.shared
    let profileVC = ProfileViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        let tapIcon = UITapGestureRecognizer(target: self, action: #selector(profileIconTaped))
        profileIcon.addGestureRecognizer(tapIcon)
        profileIcon.isUserInteractionEnabled = true
        
        let tapSearch = UITapGestureRecognizer(target: self, action: #selector(searchIconTaped))
        searchIcon.addGestureRecognizer(tapSearch)
        searchIcon.isUserInteractionEnabled = true
        
        searchTextField.delegate = self
        searchTextField.isHidden = true
        
        tableView.dataSource = self
        dbManager.delegate = self
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        users = []
        dbManager.loadUsers()

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    
    @objc func profileIconTaped() {
        Service.shared.showActionSheetBy(viewController: self)
    }
    
    @objc func searchIconTaped() {
        if searchTextField.isHidden {
            searchTextField.isHidden = false
        } else if !searchTextField.text!.isEmpty {
            if let text = searchTextField.text {
                users = []
                dbManager.fetchUsersWith(text: text)
            }
        }
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
        users.append(newUser)
        tableView.reloadData()
    }
}

extension TableViewController: TableViewCellDelegate {
    func callPressed(indexPath: IndexPath) {
        guard let numberStr = users[indexPath.row].phoneNumber else { return }
        shared.makeACallWith(number: numberStr, viewController: self)
    }
    
    func videoCallPressed(indexPath: IndexPath) {
        performSegue(withIdentifier: K.Segue.videoCallSegue, sender: self)
    }
}

extension TableViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { timer in
            self.searchIcon.tintColor = UIColor.white
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = ""
        users = []
        dbManager.loadUsers()
        searchTextField.isHidden = true
        searchIcon.tintColor = UIColor(red: 0.15, green: 0.26, blue: 0.28, alpha: 1.00)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return true }
        users = []
        dbManager.fetchUsersWith(text: text)
        
        return true
    }
    
}

