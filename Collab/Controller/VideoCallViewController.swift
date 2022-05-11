//
//  VideoCallViewController.swift
//  Collab
//
//  Created by user on 11.05.2022.
//

import UIKit
import AgoraUIKit

class VideoCallViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let agView = AgoraVideoViewer(connectionData: AgoraConnectionData(appId: "2c19653a833e4ed0bbb925fab31f54ec"))

        agView.fills(view: self.view)
        agView.join(channel: "my channel", as: .broadcaster)

    }
    
}



