//
//  User.swift
//  Sanapp
//
//  Created by Daniel Ramirez on 8/31/17.
//  Copyright © 2017 Devius. All rights reserved.
//

import UIKit

//class User {
//    
//    let name:String
//    let email:String
//    let imgUrl:String
//    let hasPremium:Bool
//
//    init(name:String, email:String, imgUrl:String, hasPremium: Bool) {
//        
//        self.name = name
//        self.email = email
//        self.imgUrl = imgUrl
//        self.hasPremium = hasPremium
//        
//    }
//}

class User: NSObject {
    var email: String?
    var name: String?
    var imgUrl:String?
    var hasPremium: Bool?
}
