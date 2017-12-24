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
    var resp:Bool = false
    var isRunning:Bool = false
    var total:Int = 0
    
    
    // 1
    
    
    //ELEMENTOS
    var arrayDownloads: [State]?
    
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
        loadLocalStates()
        player?.numberOfLoops = -1
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        view.backgroundColor = .black
        checkAndPresentForWalkthroug()
        downloadStatesDB()
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
    
    var imgArray: [UIImage] = []
        
    
    var arrayContent = [String]()
    func downloadStatesDB(){
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let refDat = Database.database().reference().child("moods")
        //observamos los moods que tenemos disponibles
        refDat.observe(.value, with: { (snapshot) in
            //observamos los moods creados en firebase
            if let dic = snapshot.value as? [String: AnyObject]{
                //sacamos los moods del array
                for state in dic{
                    
                    //trabajamos con el state specifico una vez y se repite en los demas
                    guard let bgUrl = state.value["urlBgImg"] as? String, let cellUrl = state.value["urlCellImg"] as? String, let urlAudio = state.value["urlAudio"] as? String, let name = state.value["name"] as? String, let premium = state.value["isPremium"] as? Bool, let desc = state.value["description"] as? String  else { return print("error guard states") }
                    
                    let refAudio = storageRef.child("moodAudioUrl/\(urlAudio).mp3")
                    
                    self.arrayContent.append(cellUrl)
                    self.arrayContent.append(bgUrl)
                    
                    //return the array imgs
//                    if let arrayImg = self.downloadImgFromStorage(nameCell: self.arrayContent) {
//
//                        refAudio.getData(maxSize: 1 * 1024 * 1024, completion: { (data, error) in
//                            if error != nil{
//                                print("error")
//                            }else{
//                                print("success")
//                                //create the Mood State
//
//                                if let cell = arrayImg.first, let bg = arrayImg.last{
//                                    print("imagenes al tiro chapo\(cell)")
//                                    let state = State(imgCell: cell, imgBg: bg, name: name, audioUrl: urlAudio, isPremium: premium, description: desc)
//                                    DispatchQueue.main.async {
//                                        self.stateLaunch.states.append(state)
//                                        self.stateLaunch.collectionV.reloadData()
//                                    }
//                                }
//                            }
//                        })
//                    }
                    self.downloadImgFromStorage(nameCell: self.arrayContent)
                    
                    print("array Img count2 :\(self.arrayContent.count)")
                        
                        refAudio.getData(maxSize: 1 * 1024 * 1024, completion: { (data, error) in
                            if error != nil{
                                print("error")
                            }else{
                                print("success")
                                //create the Mood State
                                var arrayImg = self.imgArray
                                print("arrayImg: \(arrayImg.count)")
                                if let bg = arrayImg.first, let cell = arrayImg.last{
                                    print("imagenes al tiro chapo\(cell)")
                                    let state = State(imgCell: cell, imgBg: bg, name: name, audioUrl: urlAudio, isPremium: premium, description: desc)
                                    DispatchQueue.main.async {
                                        self.stateLaunch.states.append(state)
                                        self.stateLaunch.collectionV.reloadData()
                                    }
                                }
                            }
                        })
                }
            }
        }, withCancel: nil)
    }
    
    
   
    //creamos la funcion que se encargara de descargar y almacenar en un array
    ///GeneralImgDownlaod
    func  downloadImgFromStorage(nameCell: [String]){
        imgArray = []
        let storage = Storage.storage()
        var storageRef = storage.reference()
        
        
        for label in nameCell{
           let storageRef = storageRef.child("imagesMoods/\(label)")
            storageRef.getData(maxSize: 2 * 1024 * 1024) { (data, error) in
                if error != nil{
                    print("error!\(error)")
                    
                }else{
                    print("img download Cell")
                    //we stock the images and save them locally
                    if let dataImg = UIImage(data: data!){
                        self.imgArray.append(dataImg)
                        print("count : \(self.imgArray.count) img\(dataImg)")
                        
                    }
                }
            }
        }
        //create a reference to the file we want to download
    }
    //load local music
    private func loadLocalStates(){
        //vamos a crear 3 states
            
            let path = Bundle.main.path(forResource: "positive", ofType:"mp3")!
            
            do{                
                let stateSleep = State(imgCell: #imageLiteral(resourceName: "cell4"), imgBg: #imageLiteral(resourceName: "bg4"), name: "Sleepy", audioUrl: "sleep", isPremium:false, description: "Many people choose this mood to help them relax, wash away the days troubles and fall asleep. Use this mood to bring you the rest you are looking for after a hard day.")
                
                let stateStudy = State(imgCell: #imageLiteral(resourceName: "cell3"), imgBg: #imageLiteral(resourceName: "bg3"), name: "Study", audioUrl: "study", isPremium: false, description: "Study mood can help  stimulate new neural connections, regain memories,and activate attention span. Use this mood to focus on a specific task.")
                
                
                let stateRelax = State(imgCell: #imageLiteral(resourceName: "cell2"), imgBg: #imageLiteral(resourceName: "bg2"), name: "Relax", audioUrl: "relax", isPremium: false, description: "Sometimes we concentrate so much on the future, that we stress ourselves out.  Anxiety about the future takes up a significant portion of our thoughts. Relax mood will help you cool down. Remember, live in the present. Now is the only moment that is important. Use this mood to bring calm to your day!")
                
                stateLaunch.states.append(stateSleep)
                stateLaunch.states.append(stateRelax)
                stateLaunch.states.append(stateStudy)

                handleState(state: stateRelax)
                handleAudio(state: stateRelax)
                currentState = stateRelax
                
            }catch{
 
            }
    }
    
    //we are going to download the information from firebase and create our song
    
    
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

    //received the state from stateLauncher
    func handleState(state:State){
       
        if let imagen = state.imgBg, let descrip = state.desc{
            setupBackgroundAndBlur(image: imagen)
            songNameLabel.text = state.name
            self.timerLaunch.handleDesc(state: state)
            currentState = state
            print("receiving state:\(currentState?.name)")
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
            print("current state: \(currentState?.name)")
            if Auth.auth().currentUser?.uid == nil, currentState?.isPremium == true{
                print("no soy vip, y el audio si es vip")
                playBtn.setImage(#imageLiteral(resourceName: "playBtn").withRenderingMode(.alwaysOriginal), for: .normal)
                player?.pause()
                print("1 aqui")
            }else{
                player?.play()
                playBtn.setImage(#imageLiteral(resourceName: "pauseBtn").withRenderingMode(.alwaysOriginal), for: .normal)
                print("dos aqui")
                isPlaying = false
            }
            
            
        }else{
            
            isPlaying = true
            playBtn.setImage(#imageLiteral(resourceName: "playBtn").withRenderingMode(.alwaysOriginal), for: .normal)
            player?.pause()
            print("tres aqui")
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


