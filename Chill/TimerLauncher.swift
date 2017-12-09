//
//  TimerLauncher.swift
//  Chill
//
//  Created by Daniel Ramirez on 12/5/17.
//  Copyright © 2017 Devius. All rights reserved.
//

import Foundation
import UIKit



class TimerLauncher: NSObject{
    
    var homeController: MainViewVC = {
        let main = MainViewVC()
        return main
    }()
    
    
    let blackView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        //UIColor(white: 0, alpha: 0.5)
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        view.isUserInteractionEnabled = true

        return view
    }()
    
    let container: UIView = {
       let view = UIView()
        view.layer.cornerRadius = 5
        view.backgroundColor = UIColor.white.withAlphaComponent(0.80)
        view.isOpaque = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    var titleLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 10
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.shadowColor = UIColor(red:0.86, green:0.86, blue:0.86, alpha:1.0)
        label.shadowOffset = CGSize(width: 0.5, height: 0.5)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .gray
        label.textAlignment = .center
        label.numberOfLines = 8
        label.shadowColor = UIColor(red:0.86, green:0.86, blue:0.86, alpha:1.0)
        label.shadowOffset = CGSize(width: 0.5, height: 0.5)
        label.translatesAutoresizingMaskIntoConstraints =  false
        return label
    }()
    
    let btnSetTime: UIButton = {
        let btn = UIButton(type: UIButtonType.system)
        btn.setTitle("Got it", for: .normal)
        btn.backgroundColor = UIColor(red:0.03, green:0.61, blue:0.54, alpha:1.0)
        btn.layer.cornerRadius = 5
        btn.tintColor = .white
        btn.layer.shadowColor = UIColor.red.cgColor
        btn.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    //variables
    let timesArray = ["None","5 minutes","10 minutes", "20 minutes", "40 minutes", "1 hour", "2 hours"]
    let secondsHr = 60
    var total = 0
    
    
    func handleDesc(state: State){
        descriptionLabel.text = state.desc
        descriptionLabel.setNeedsDisplay()
        titleLabel.text = state.name
        
        
    }
    
    func showSettings(){
        
        //if window exist
        if let window = UIApplication.shared.keyWindow{
            print("si entra")
            //add Views
            window.addSubview(blackView)
            window.addSubview(container)
            
            btnSetTime.addTarget(self, action: #selector(handleDescription), for: UIControlEvents.touchUpInside)

            let width = window.frame.width-10
            let heigth = window.frame.height
            setContainer(width: width, heigth: heigth)
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handledismissBlackView)))
            blackView.frame = window.frame
            
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.blackView.alpha = 1
                self.container.isHidden = false
                
                
            }, completion: nil)

        }else{
            print("doesnt shared key window")
        }
        
    }
    
    func handleDescription(){
        print("handle description")
        self.handledismissBlackView()        
        
    }
    
    func setContainer(width: CGFloat, heigth: CGFloat){
        
        container.centerXAnchor.constraint(equalTo: self.blackView.centerXAnchor).isActive = true
        container.centerYAnchor.constraint(equalTo: self.blackView.centerYAnchor, constant: -10).isActive = true
        container.heightAnchor.constraint(equalToConstant: 300).isActive = true
        container.widthAnchor.constraint(equalToConstant: width).isActive = true
        
        container.addSubview(titleLabel)
        container.addSubview(btnSetTime)
        container.addSubview(descriptionLabel)
        
        
        titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        descriptionLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        descriptionLabel.widthAnchor.constraint(equalTo: btnSetTime.widthAnchor).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 170).isActive = true
        
        btnSetTime.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        btnSetTime.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10).isActive = true
        btnSetTime.widthAnchor.constraint(equalToConstant: width-10).isActive = true
        btnSetTime.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        
        
       
    }
    
    func handledismissBlackView(){
        print("touchin")
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options:.curveEaseOut, animations: {
            self.blackView.alpha = 0
            self.container.isHidden = true
            
        }) { (completed: Bool) in
            print("error")
        }
    }
}





