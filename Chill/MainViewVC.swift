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
//variables Global


class MainViewVC: UIViewController {
    var player: AVAudioPlayer?
    
    var isPlaying:Bool?
    
    
    var currentState: State?
    var arraySongs: [String] = ["sleep.mp3"]
    var resp:Bool = false
    
    
    var isRunning:Bool = false
    var total:Int = 0
    
    //ELEMENTOS
    let containerView: UIView = {
       let container = UIView()
        container.backgroundColor = UIColor.white.withAlphaComponent(0.40)
        container.isOpaque = true
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    lazy var songNameLabel: UILabel = {
        let name = UILabel()
        name.text = "Balance State"
        name.textColor = .black
        name.textAlignment = .center
        name.shadowColor = .white
        name.shadowOffset = CGSize(width: 0.5, height: 0.5)
        name.isOpaque = true
        name.font  = UIFont(name: "Dosis-Medium", size: 18)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    let playBtn: UIButton = {
        let myBtn = UIButton(type: UIButtonType.system)
        myBtn.layer.shadowColor = UIColor.black.cgColor
        myBtn.layer.shadowOffset = CGSize(width: 2.0, height: 1.0)
        myBtn.tintColor = .white
        myBtn.layer.masksToBounds = false
        myBtn.layer.shadowRadius = 1.0
        myBtn.addTarget(self, action: #selector(handleStateMusicBtn), for: .touchUpInside)
        myBtn.layer.shadowOpacity = 0.5
        myBtn.translatesAutoresizingMaskIntoConstraints = false
        
        return myBtn
    }()
    
    
    let infoBtn: UIButton = {
        let myBtn = UIButton(type: UIButtonType.system)
        myBtn.setImage(#imageLiteral(resourceName: "infoBtn").withRenderingMode(.alwaysOriginal), for: .normal)
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
        myBtn.setImage(#imageLiteral(resourceName: "p2").withRenderingMode(.alwaysOriginal), for: .normal)
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
//        checkIfUserIsLoggedIn()
        observeStateAndSaveInfo()
        loadLocalStates()
        player?.numberOfLoops = -1
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        view.backgroundColor = .black
//        checkIfUserIsLoggedIn()
        checkAndPresentForWalkthroug()
        
    }

    //Views
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
    
    lazy var timerLaunch: TimerLauncher = {
        let vc = TimerLauncher()
        return vc
    }()
    
    
    //load local music
    private func loadLocalStates(){
        //vamos a crear 3 states
            
            let path = Bundle.main.path(forResource: "creative", ofType:"mp3")!
            
            do{
                let statesVC = StatesLauncher()
                let mainVC = MainViewVC()
                
                let stateSleep = State(imgCell: "cell4.png", imgBg:"bg4.png", name: "Sleepy", audioUrl: "sleep", isPremium:false, description: "Many people choose this mood to help them relax, wash away the days troubles and fall asleep. Use this mood to bring you the rest you are looking for after a hard day.")
                
                let stateStudy = State(imgCell: "cell3", imgBg: "bg3", name: "Study", audioUrl: "study", isPremium: false, description: "Study mood can help  stimulate new neural connections, regain memories,and activate attention span. Use this mood to focus on a specific task.")
                
                let statePositive = State(imgCell: "cell5", imgBg: "bg5", name: "Positivity", audioUrl: "positive", isPremium: false, description: "We all have days when we feel out of sorts. During those days, we are more susceptible to negativite energy than other days. Use the Positivity mood to balance the energy of your body! Take a deep breath, and let the negativity out of your body.")
                
                let stateRelax = State(imgCell: "cell2", imgBg: "bg2", name: "Relax", audioUrl: "relax", isPremium: false, description: "Sometimes we concentrate so much on the future, that we stress ourselves out.  Anxiety about the future takes up a significant portion of our thoughts. Relax mood will help you cool down. Remember, live in the present. Now is the only moment that is important. Use this mood to bring calm to your day!")
                let stateMeditation = State(imgCell: "cell9", imgBg: "bg9", name: "Reflection", audioUrl: "creative", isPremium: false, description: "The Meditation mood can help you when you are feeling nostalgic. It can help you bring back positive memories, and make you remember all of your past successes. Remember yourself, and remember how truly remarkable you are.")
                
                let stateCreative = State(imgCell: "cell10", imgBg: "bg10", name:"Creativity", audioUrl: "creative", isPremium: true, description: "in the groove, and keep you cool and creative when you need it the most. Fire up your senses and get your creative juices flowing. Use this Mood to bring your creative side.")
               
                
                
                stateLaunch.states.append(stateSleep)
                stateLaunch.states.append(stateRelax)
                stateLaunch.states.append(stateStudy)
                stateLaunch.states.append(statePositive)
                stateLaunch.states.append(stateCreative)
                stateLaunch.states.append(stateMeditation)
              
                
                handleState(state: stateMeditation)
                handleAudio(state: stateMeditation)
                currentState = stateMeditation
              
                
            }catch{
                print("error")
            }
    }
    
    //received the state from stateLauncher
    func handleState(state:State){
       
        if let imagen = UIImage(named: state.imgBg!), let descrip = state.desc{
            setupBackgroundAndBlur(image: imagen)
            songNameLabel.text = state.name
            self.timerLaunch.handleDesc(state: state)
            currentState = state
        
        }
        
        
        
    }

    func handleShowSatesCollecton(){
        stateLaunch.showSettings()
    }
    
    func handleTimer(){
        timerLaunch.showSettings()

    }
    
    //showMoreToolsMennu
    func handleMore(){
        settingsLaunch.showSettings()
    }
    
    var access = false
    func handleAudio(state:State){
        guard let urlSong = state.audioUrl else {return}
         guard let path = Bundle.main.path(forResource: urlSong, ofType:"mp3") else{return}
        
        switch state.isPremium {
        case true?:
            print("is premium")
            //if user is premium to he can acces if not we are going to send him to subscribe
            if Auth.auth().currentUser?.uid != nil{
                playAudio(path: path)
                print("playing music premium")
            }else{
                checkIfUserIsLoggedIn()
            }
        case false?:
            playAudio(path: path)
            print("playing music not premium")
            
        default:
            return
        }
    }
    
    
    func playAudio(path: String){
        do{
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            
            player?.play()
            isPlaying = true
            handleStateMusicBtn()
            
        }catch{
            print("error")
        }
    }
    
    func handleStateMusicBtn(){
        
        if isPlaying == true{
            playBtn.setImage(#imageLiteral(resourceName: "pauseBtn").withRenderingMode(.alwaysOriginal), for: .normal)
            isPlaying = false
            player?.play()
        }else{
            
            isPlaying = true
            playBtn.setImage(#imageLiteral(resourceName: "playBtn").withRenderingMode(.alwaysOriginal), for: .normal)
            player?.pause()
        }
    }
    
    //button extra attributes
    func setButonAttributes(){
        playBtn.tintColor = .white
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
                    self.settingsLaunch.isLoggedIn = true
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
//            UserDefaults.standard.removeObject(forKey: "completeWalk")
            UserDefaults.standard.removeObject(forKey: userName)
            
            isPlaying = false
            handleStateMusicBtn()

            self.navigationItem.title = ""
        }catch let logoutError {
            print(logoutError)
        }
        //present the mainViewController        
        let loginController = LogVC()
        navigationController?.present(LogVC(), animated: true, completion:  nil)
    }
}


