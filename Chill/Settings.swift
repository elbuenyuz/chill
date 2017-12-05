//
//  Settings.swift
//  Sanapp
//
//  Created by Daniel Ramirez on 9/8/17.
//  Copyright © 2017 Devius. All rights reserved.
//


import UIKit


//creamos una clase Settings el cual contendra propiedades para el menu desplegable
class Setting: NSObject {
    let name:String
    let imgName: String
    
    init(name:String, imgName: String) {
        self.name = name
        self.imgName = imgName
    }
}
