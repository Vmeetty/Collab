//
//  User.swift
//  Collab
//
//  Created by user on 07.05.2022.
//

import Foundation
import UIKit

class User {
    
    var name: String
    var role: String
    var image: UIImage?
    
    init(name: String, role: String) {
        self.name = name
        self.role = role
    }
    
}
