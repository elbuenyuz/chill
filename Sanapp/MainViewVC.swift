//
//  MainViewVC.swift
//  Sanapp
//
//  Created by Daniel Ramirez on 8/28/17.
//  Copyright © 2017 Devius. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation

var imageCache = NSMutableDictionary()


extension UIImageView {
    func loadImageUsingCacheWithUrlString(urlString: String) {
        print("urlString\(urlString)")
        self.image = nil
        
        if let img = imageCache.value(forKey: urlString) as? UIImage{
            self.image = img
        }
        else{
            let session = URLSession.shared
            let task = session.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
                
                if(error == nil){
                    
                    if let img = UIImage(data: data!) {
                        imageCache.setValue(img, forKey: urlString)    // Image saved for cache
                        DispatchQueue.main.async(execute: { () -> Void in
                            self.image = img
                        })
                    }
                    
                }
            })
            task.resume()
        }
    }
}


var player: AVAudioPlayer?
var currentState = 0
var arraySongs: [String] = ["sleep.mp3"]
var resp:Bool = false

class MainViewVC: UIViewController {
    
    //ELEMENTOS
    let containerView: UIView = {
       let container = UIView()
        container.backgroundColor = UIColor.white.withAlphaComponent(0.40)
        container.isOpaque = true
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    let songNameLabel: UILabel = {
        let name = UILabel()
        name.text = "Sleep State"
        name.textColor = .white
        name.textAlignment = .center
        name.shadowColor = UIColor.lightGray
        name.shadowOffset = CGSize(width: 0.5, height: 0.5)
        name.isOpaque = true
        name.font  = UIFont(name: "Dosis-Regular", size: 18)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    let playBtn: UIButton = {
        let myBtn = UIButton(type: UIButtonType.system)
        myBtn.setImage(#imageLiteral(resourceName: "play").withRenderingMode(.alwaysOriginal), for: .normal)
        myBtn.layer.shadowColor = UIColor.black.cgColor
        myBtn.layer.shadowOffset = CGSize(width: 2.0, height: 1.0)
        myBtn.layer.masksToBounds = false
        myBtn.layer.shadowRadius = 1.0
        myBtn.addTarget(self, action: #selector(handleAudio), for: .touchUpInside)
        myBtn.layer.shadowOpacity = 0.5
        myBtn.translatesAutoresizingMaskIntoConstraints = false
        
        return myBtn
    }()
    
    let timerBtn: UIButton = {
        let myBtn = UIButton(type: UIButtonType.system)
        myBtn.setImage(#imageLiteral(resourceName: "Timer").withRenderingMode(.alwaysOriginal), for: .normal)
        myBtn.layer.shadowColor = UIColor.black.cgColor
        myBtn.addTarget(self, action: #selector(handleTimer), for: .touchUpInside)
        myBtn.layer.shadowOffset = CGSize(width: 2.0, height: 1.0)
        myBtn.layer.masksToBounds = false
        myBtn.layer.shadowRadius = 1.0
        myBtn.layer.shadowOpacity = 0.5

        myBtn.translatesAutoresizingMaskIntoConstraints = false
        
        return myBtn
    }()
    
    let songBtn: UIButton = {
        let myBtn = UIButton(type: UIButtonType.system)
        myBtn.setImage(#imageLiteral(resourceName: "song").withRenderingMode(.alwaysOriginal), for: .normal)
        myBtn.layer.shadowColor = UIColor.black.cgColor
        myBtn.layer.shadowOffset = CGSize(width: 2.0, height: 1.0)
        myBtn.layer.masksToBounds = false
        myBtn.layer.shadowRadius = 1.0
        myBtn.layer.shadowOpacity = 0.5
        myBtn.addTarget(self, action: #selector(handleShowSatesCollecton), for: .touchUpInside)
        myBtn.translatesAutoresizingMaskIntoConstraints = false
        
        return myBtn
    }()

    let backgroundImage : UIImageView = {
        let img = UIImageView(frame: UIScreen.main.bounds)
        img.image = #imageLiteral(resourceName: "bg")
        img.contentMode = .scaleAspectFill
        return img
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(containerView)
        setupNavigationBarAndDesignItems()
        checkIfUserIsLoggedIn()
        observeStateAndSaveInfo()
  
    }
    
    lazy var settingsLaunch: SettingsLauncher = {
        let vc  = SettingsLauncher()
        vc.homeController = self
        return vc
    }()
    
    lazy var stateLaunch: StatesLauncher = {
        let vc  = StatesLauncher()
        vc.homeController = self
        return vc
    }()
    
    func handleShowSatesCollecton(){
        stateLaunch.showSettings()
    }
    
    //handle playBTn action
    func handleAudio(){
        do{
           
            
        }catch{
            
        }
    }
    
    func handleTimer(){
        
    }
    
    func setButonAttributes(){
    
        playBtn.tintColor = .white
    }
    
    func handleMore(){
        settingsLaunch.showSettings()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
    
        view.backgroundColor = .black
        checkIfUserIsLoggedIn()
  
        
        if let name = UserDefaults.standard.object(forKey: userName){
            self.navigationItem.title = name as? String
        }
        
    }
    
    
    
    
    func setNavBarWithUser(user: User){
        
        UIView.animate(withDuration: 0.5, delay: 0.2, options: [], animations: {
            
            self.navigationItem.title = user.name
            
        }, completion: nil)
        
    }
    
    func checkAndPresentForWalkthroug(){
        resp = UserDefaults.standard.bool(forKey: "completeWalk")
      
        switch resp {
        case true:
            print("usuario SI ha visto el walk \(resp)")
            
        case false:
            print("usuario NO ha visto el walk \(resp)")
            UserDefaults.standard.set(true, forKey: "completeWalk")
            present(PageVC(), animated: true, completion: nil)
        default:
            return
        }
    }

    
    func setupBackgroundAndBlur(image: UIImage){

        backgroundImage.image = image
        backgroundImage.alpha = 1
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    
    }
    
    let userName = "userName"
    //func check if user is logged in , and modify the navbar
    func checkIfUserIsLoggedIn(){

        //checamos si existe
        if Auth.auth().currentUser?.uid == nil{
            
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }else{
            
            //guardeamos uid
            guard let uid = Auth.auth().currentUser?.uid else { return }
            
            //creamos la referencia a la base de datos
            
            Database.database().reference().child("user").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                //convertimos el snap a dic
                //creamos el usuario
                let user = User()

                if let dic = snapshot.value as? [String: AnyObject]{
                    //guardeamos la informacion para crear el usuario
                    guard let email = dic["email"] as? String, let name = dic["name"] as? String, let proPic = dic["profileImageUrl"] as? String, let premium = dic["hasPremium"] as? Bool else{ return }
                    
                    user.name = name
                    user.email = email
                    user.hasPremium = premium
                    user.imgUrl = proPic
                    
                    print("\(String(describing: user.name))")
                    self.checkAndPresentForWalkthroug()
                    
                    //uder name default
                    UserDefaults.standard.setValue(user.name, forKeyPath: "userName")
                    
                }

                    self.setNavBarWithUser(user: user)
                
            }, withCancel: nil)
            
        }
    }
    
    var states = [State]()
    
    //observe the states
    func observeStateAndSaveInfo(){
        let refDat = Database.database().reference().child("state")
        states = []
        
                refDat.observe(.value, with: { (snapshot) in
                    let state = State()
                    if let dic = snapshot.value as? [String: AnyObject]{
                        
                        
                        for state in dic{
                            var nameState:String = state.key
                            
                        }
                    }
//                    self.stateLaunch.fetchDataToCollection(Array: self.states)
                }, withCancel: nil)
        
            }
    
    //we handle the logOut of the user
    func handleLogout(){
        print("Handle logOut")
        //force logged in
        do{
            try Auth.auth().signOut()
            print("valores renovados al salir , el usuario\(resp)")
            UserDefaults.standard.removeObject(forKey: "completeWalk")
            UserDefaults.standard.removeObject(forKey: userName)

            self.navigationItem.title = ""
        }catch let logoutError {
            print(logoutError)
        }
        //present the mainViewController        
        let loginController = LogVC()
        navigationController?.present(LogVC(), animated: true, completion:  nil)
    }

    
}

