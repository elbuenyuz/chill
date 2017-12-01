//
//  stateCell.swift
//  Sanapp
//
//  Created by Daniel Ramirez on 9/12/17.
//  Copyright © 2017 Devius. All rights reserved.
//


//
//  SettingsCell.swift
//  Sanapp
//
//  Created by Daniel Ramirez on 9/7/17.
//  Copyright © 2017 Devius. All rights reserved.
//

import UIKit

class StateCell: BaseCell {
    
    //hightlight
    override var isHighlighted: Bool{
        didSet{
            
            settingName.textColor = isHighlighted ? .clear : .white
            
            
            print("high")
        }
    }
    
    //Creamos un objeto
    var state: State? {
        didSet{
            self.settingName.text = state?.name
            guard let imgcell = state?.imgCell, let premium = state?.isPremium else { return }
            self.imgBack.image = UIImage(named: imgcell)
            self.imgPremium.image = premium ? #imageLiteral(resourceName: "p2") : #imageLiteral(resourceName: "premium")
            
        }
    }
    
    lazy var settingName: UILabel = {
        let name = UILabel()
        name.font = UIFont(name: "Dosis-Medium", size: 17)
        name.text = "namePrueba"
        name.textAlignment = .center
        name.textColor = .white
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    let imgPremium: UIImageView = {
        let p = UIImageView()
        p.image = nil
        p.translatesAutoresizingMaskIntoConstraints = false
        return p
    }()
    
    let imgBack : UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "sleepCell")
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    override func setupViews() {
        addSubview(imgBack)
        addSubview(settingName)
        addSubview(imgPremium)
        
        
        imgBack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imgBack.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        imgBack.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        imgBack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        settingName.centerXAnchor.constraint(equalTo: imgBack.centerXAnchor).isActive = true
        settingName.centerYAnchor.constraint(equalTo: imgBack.centerYAnchor).isActive = true
        settingName.widthAnchor.constraint(equalToConstant: 120).isActive = true
        settingName.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        imgPremium.rightAnchor.constraint(equalTo: imgBack.rightAnchor, constant:  -8).isActive = true
        imgPremium.centerYAnchor.constraint(equalTo: imgBack.centerYAnchor).isActive = true
        imgPremium.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imgPremium.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
}














