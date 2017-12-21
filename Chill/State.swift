//
//  State.swift
//  Sanapp
//
//  Created by Daniel Ramirez on 8/31/17.
//  Copyright © 2017 Devius. All rights reserved.
//

import UIKit
import AVFoundation

//class State: NSObject {
//    let name:String
//    let imgName: String
//
//    
//    init(name:String, imgName: String) {
//        self.name = name
//        self.imgName = imgName
//        
//    }
//}

class State: NSObject {
    var imgCell: UIImage?
    var imgBg: UIImage?
    var name: String?
    var audioUrl:String?
    var isPremium: Bool?
    var desc:String?
    
    init(imgCell: UIImage, imgBg:UIImage, name: String, audioUrl:String, isPremium:Bool,description:String) {
        self.imgCell = imgCell
        self.imgBg = imgBg
        self.name = name
        self.audioUrl = audioUrl
        self.isPremium = isPremium
        self.desc = description
    }
    
    override init() {
        
    }
    
}
