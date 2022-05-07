//
//  TableViewCell.swift
//  Collab
//
//  Created by user on 07.05.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rolLabel: UILabel!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var videoCallButton: UIButton!
    


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func callPressed(_ sender: UIButton) {
        print("Make a call")
    }
    @IBAction func videoCallPressed(_ sender: UIButton) {
        print("make a video call")
    }
    
}
