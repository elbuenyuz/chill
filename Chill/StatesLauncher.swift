//
//  SettingsLauncher.swift
//  Sanapp
//
//  Created by Daniel Ramirez on 9/7/17.
//  Copyright © 2017 Devius. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase

//creamos la vista y mandamos llamar el contenedor de settings
class StatesLauncher: NSObject ,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var states = [State]()
    var homeController: MainViewVC?
    let blackView = UIView()
    
    let collectionV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.layer.borderColor = UIColor.lightGray.cgColor
        cv.isScrollEnabled = true
        cv.isOpaque = true
        cv.layer.cornerRadius = 5
        cv.backgroundColor = UIColor(red:0.81, green:0.81, blue:0.81, alpha:0.5)
        return cv
    }()
    
    lazy var mainVC: MainViewVC = {
        let main = MainViewVC()
        return main
    }()
    
    override init() {
        super.init()
        
        // all work here
        collectionV.register(StateCell.self, forCellWithReuseIdentifier: cellId)
        collectionV.dataSource = self
        collectionV.delegate = self
    }

    
    func fetchDataToCollection(Array:[State]){
       //recived dictionary
        print("array: \(Array.count)")
        states = Array
        collectionV.reloadData()
        
    }
    
    //arraySettingsMenu
    func observeState(){
        let refDat = Database.database().reference().child("state")
        let state = State()

        refDat.observe(.value, with: { (snapshot) in

            if let dic = snapshot.value as? [String: AnyObject]{
                print(snapshot)
                //guardeamos la informacion para crear el usuario
                guard let name = dic["name"] as? String, let imgBg = dic["imgBack"] as? String, let imgCell = dic["imgCell"] as? String, let premium = dic["isPremium"] as? Bool, let audioUrl = dic["audioUrl"] as? String else{ return }

                state.name = name
                state.isPremium = premium
                state.imgCell = imgCell
                state.imgBg = imgBg
                state.audioUrl = audioUrl

                    print("\(state.name)")
                self.states.append(state)

            }
            self.collectionV.reloadData()
            print("array states \(self.states.count)")

        }, withCancel: nil)
    }
    
    //se ejecutab al presionar el boton derecho
    let cellId = "stateId"
    let cellHeight: CGFloat = 80
    
    func showSettings(){
        
        if let window = UIApplication.shared.keyWindow{
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handledismissBlackView)))
            
            window.addSubview(blackView)
            window.addSubview(collectionV)
            
            //collectionV
            let heigth: CGFloat =  window.frame.height - 100
            
            //modificar posicion inicial de la colleccion
            collectionV.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: heigth)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            let cHeigth = self.collectionV.frame.height + 10
            
            //animation
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.blackView.alpha = 1
                
                self.collectionV.frame = CGRect(x: window.frame.width/2 - self.collectionV.frame.width/2, y: window.frame.height - cHeigth, width: self.collectionV.frame.width, height: self.collectionV.frame.height)
                
            }, completion: nil)
        }
    }
    
    
    func handledismissBlackView(setting: State){
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options:.curveEaseOut, animations: {
            self.blackView.alpha = 0
            let heigth: CGFloat = CGFloat(self.states.count) * self.cellHeight
            if let window = UIApplication.shared.keyWindow{
                
                self.collectionV.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: heigth)

            }
            
        }) { (completed: Bool) in
           
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("collection states: \(states.count)")
        return states.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionV.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! StateCell
        cell.backgroundColor = .white
        cell.backgroundColor = .clear
        let state = states[indexPath.item]
        cell.state = state
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let state = states[indexPath.item]
        guard let urlSong = state.audioUrl else {return}
        
        
        self.homeController?.handleAudio(nameAudio: urlSong)
        
        
        

        handledismissBlackView(setting: state)
        DispatchQueue.main.async(execute: {
            self.homeController?.handleState(state:state)
        })
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionV.frame.width, height: cellHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 1
    }
    
    
    
}











