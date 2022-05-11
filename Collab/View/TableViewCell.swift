//
//  TableViewCell.swift
//  Collab
//
//  Created by user on 07.05.2022.
//

import UIKit

protocol TableViewCellDelegate: AnyObject {
   func cellPressed(indexPath: IndexPath)
}

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rolLabel: UILabel!
    @IBOutlet weak var callButton: UIImageView!
    @IBOutlet weak var videoCallButton: UIImageView!
    
    var indexPath: IndexPath!
    weak var delegate: TableViewCellDelegate?

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        let tapGR = UITapGestureRecognizer(target: self, action: #selector(makeACall))
        callButton.addGestureRecognizer(tapGR)
        callButton.isUserInteractionEnabled = true
    }
    
    @objc func makeACall() {
        delegate?.cellPressed(indexPath: indexPath)
    }
 
    
}
