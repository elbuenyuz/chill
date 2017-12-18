//
//  LoginVC.swift
//  mexicoConsciente
//
//  Created by Daniel Ramirez on 7/1/17.
//  Copyright © 2017 simpleCoding. All rights reserved.
//

import UIKit
import Firebase

class LogVC: UIViewController {
    
    var homeController: MainViewVC?
    
    //funcion para manejar el registro y el login
    @objc func handleLoginRegister(){
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0{
            handleLogin()
        }else{
            handleRegister()
        }
    }
    
    //funcion para manejar el login
    func handleLogin(){
        
        guard let email = emailTextfield.text,let name = nameTextfield.text, let password = passwordTextfield.text else{
            print("form is not valid")
            return
        }
        
        //Autentificamos al usuario con email
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil{
                print("error \(error)")
                return
            }
            
            //login exitosa del usuario
            print("bienvenido de vuelta \(name)")
            self.dismiss(animated: true, completion: nil)
        })
        return
    }
    
    // Elementos
    //blurView
    let blurView: UIView = {
        let blur = UIView()
        blur.backgroundColor = UIColor(r: 100, g: 212, b: 199)
        blur.alpha = 0.8
        blur.translatesAutoresizingMaskIntoConstraints = false
        return blur
    }()
    
    //creation of loginButton
    let loginRegisterButton: UIButton = {
        let blue = UIColor(r: 25, g: 133, b: 231)
        
        let button = UIButton(type: .system)
        button.backgroundColor = blue
        button.setTitle("Subscribe for extra weekly content", for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        //font bold and size
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        //we add the target
        button.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        return button
        
    }()
    
    let skipButton: UIButton = {
        let blue = UIColor(r: 25, g: 133, b: 231)
        
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red:0.03, green:0.61, blue:0.54, alpha:1.0)
        button.setTitle("Skip, I'll come back later", for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        //font bold and size
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        //we add the target
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
        
    }()
    
    //inputsContainer creation
    let inputsContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    //name
    let nameTextfield: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    //separator
    let nameSeparatorView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b:220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //password
    let passwordTextfield:UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        return tf
    }()
    
    //passwordSeparator
    let passwordSeparatorView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b:220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //email Separator
    let emailSeparatorView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b:220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //email
    let emailTextfield:UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
    }()
    
    //profile image/logo cause it change LAZY
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "pBanner")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        
        return imageView
    }()
    
    //bgImageView
    let bgImageView: UIImageView = {
        let imageView = UIImageView()
        ///improve the design of the image
        imageView.backgroundColor = UIColor(r: 100, g: 212, b: 199)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    //segmentedControl is changing  LAZY
    lazy var loginRegisterSegmentedControl: UISegmentedControl = {
        //change color
        let orange = UIColor(r: 255, g: 183, b: 24)
        let blue = UIColor(r: 25, g: 133, b: 231)
        
        let sc = UISegmentedControl(items: ["Sign In", "Register"])
        sc.tintColor = .white
        sc.selectedSegmentIndex = 1
        sc.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    //label policy
    let policyUILabel:UILabel = {
        
        let orange = UIColor(r: 241, g: 240, b: 145)
        
        let lbl = UILabel()
        lbl.text = "By using Chill Mood you agree to the Terms, Cookies Policy and Privacy Policy."
        lbl.font = UIFont(name: "MarcellusSC-Regular", size: 12)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.numberOfLines = 2
        lbl.textColor = .white
        return lbl
    }()
    
    //func accion del controlador de segmentos
    @objc func handleLoginRegisterChange(){
        print(loginRegisterSegmentedControl.selectedSegmentIndex)
        
        //sacamos el nombre a tra vez de la posicion
        let title = loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
        loginRegisterButton.setTitle(title, for: .normal)
        
        
        //this fixed the nameTextfield bug.
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            nameTextfield.placeholder = ""
        }else{
            nameTextfield.placeholder = "Name"
        }
        
        
        //change height of input containerView, but How??
        inputsContainerHeightAnchor?.constant = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 100 : 150
        
        //change height of input nameTextfield
        nameTextfieldHeightAnchor?.isActive = false
        nameTextfieldHeightAnchor = nameTextfield.heightAnchor.constraint(equalTo: inputsContainer.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 0 : 1/3)
        
        nameTextfieldHeightAnchor?.isActive = true
        
        //change height of input emailTextfield
        emailTextfieldHeightAnchor?.isActive = false
        emailTextfieldHeightAnchor = emailTextfield.heightAnchor.constraint(equalTo: inputsContainer.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        
        emailTextfieldHeightAnchor?.isActive = true
        
        //change height of input passwordTextfield
        passwordTextfieldHeightAnchor?.isActive = false
        passwordTextfieldHeightAnchor = passwordTextfield.heightAnchor.constraint(equalTo: inputsContainer.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        
        passwordTextfieldHeightAnchor?.isActive = true
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //color of the loginVC background
        navigationController?.isNavigationBarHidden = true
        
        //agregamos vistas
        view.addSubview(bgImageView)
        view.addSubview(blurView)
        view.addSubview(inputsContainer)
        view.addSubview(loginRegisterButton)
        view.addSubview(skipButton)
        view.addSubview(profileImageView)
        view.addSubview(policyUILabel)
        view.addSubview(loginRegisterSegmentedControl)
        
        setupInputConstainer()
        setupRegisterButton()
        setupSkipButton()
        setupImageLogo()
        setupPolicyLabel()
        setupBgImageView()
        setupLoginRegisterSegmentedControl()
    }
    
    func setupBgImageView(){
        
        bgImageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        bgImageView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        bgImageView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        bgImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        blurView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        blurView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        blurView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        blurView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    
    //func para implementar UISegmentedControl constrains
    func setupLoginRegisterSegmentedControl(){
        //need x,y,width,heigth
        loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterSegmentedControl.bottomAnchor.constraint(equalTo: inputsContainer.topAnchor, constant: -12).isActive = true
        loginRegisterSegmentedControl.widthAnchor.constraint(equalTo: inputsContainer.widthAnchor, multiplier: 1).isActive = true
        loginRegisterSegmentedControl.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }
    
    //funcion para aimplementar el label constrains
    func setupPolicyLabel(){
        policyUILabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        policyUILabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -4).isActive = true
        policyUILabel.widthAnchor.constraint(equalTo: inputsContainer.widthAnchor, constant: 12).isActive = true
        policyUILabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    //funcion para implementar el logo y la imagen que escojera el usuario
    func setupImageLogo(){
        
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: 4).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    var inputsContainerHeightAnchor:NSLayoutConstraint?
    var nameTextfieldHeightAnchor:NSLayoutConstraint?
    var emailTextfieldHeightAnchor:NSLayoutConstraint?
    var passwordTextfieldHeightAnchor:NSLayoutConstraint?
    
    //funcion para implementar los contstrains inputsContainer
    func setupInputConstainer(){
        //agregamos x,y,height constrains // centramos en X
        inputsContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //centramos en Y
        inputsContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        //width side margin contstant = -24
        inputsContainer.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        //heigth // guardamos el anchor en una variable para modificar el tamano
        inputsContainerHeightAnchor = inputsContainer.heightAnchor.constraint(equalToConstant: 150)
        //modificamos el tamano
        inputsContainerHeightAnchor?.isActive = true
        
        
        //addsubviews to inputContainer
        inputsContainer.addSubview(nameTextfield)
        inputsContainer.addSubview(nameSeparatorView)
        inputsContainer.addSubview(emailTextfield)
        inputsContainer.addSubview(emailSeparatorView)
        inputsContainer.addSubview(passwordTextfield)
        
        //textfield se alinea a la izquierda del contender con un margen de 12 de lado izq
        nameTextfield.leftAnchor.constraint(equalTo: inputsContainer.leftAnchor, constant: 12).isActive = true
        //centramos en Y = top anchor
        nameTextfield.topAnchor.constraint(equalTo: inputsContainer.topAnchor).isActive = true
        //width
        nameTextfield.widthAnchor.constraint(equalTo: inputsContainer.widthAnchor).isActive = true
        //heigth // guardamos la referencia para modificarlo
        nameTextfieldHeightAnchor = nameTextfield.heightAnchor.constraint(equalTo: inputsContainer.heightAnchor, multiplier: 1/3)
        
        //lo activamos
        nameTextfieldHeightAnchor?.isActive = true
        
        //nameSeparator
        nameSeparatorView.leftAnchor.constraint(equalTo: inputsContainer.leftAnchor).isActive = true
        //centramos en Y = top anchor
        nameSeparatorView.topAnchor.constraint(equalTo: nameTextfield.bottomAnchor).isActive = true
        //width
        nameSeparatorView.widthAnchor.constraint(equalTo: inputsContainer.widthAnchor).isActive = true
        //heigth
        nameSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        
        //email
        emailTextfield.leftAnchor.constraint(equalTo: inputsContainer.leftAnchor, constant: 12).isActive = true
        //centramos en Y = top anchor
        emailTextfield.topAnchor.constraint(equalTo: nameTextfield.bottomAnchor).isActive = true
        //width
        emailTextfield.widthAnchor.constraint(equalTo: inputsContainer.widthAnchor).isActive = true
        //heigth
        emailTextfieldHeightAnchor = emailTextfield.heightAnchor.constraint(equalTo: inputsContainer.heightAnchor, multiplier: 1/3)
        
        emailTextfieldHeightAnchor?.isActive = true
        
        
        //emailSeparator
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsContainer.leftAnchor).isActive = true
        //centramos en Y = top anchor
        emailSeparatorView.topAnchor.constraint(equalTo: emailTextfield.bottomAnchor).isActive = true
        //width
        emailSeparatorView.widthAnchor.constraint(equalTo: inputsContainer.widthAnchor).isActive = true
        //heigth
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        
        
        //password
        passwordTextfield.leftAnchor.constraint(equalTo: inputsContainer.leftAnchor, constant: 12).isActive = true
        //centramos en Y = top anchor
        passwordTextfield.topAnchor.constraint(equalTo: emailTextfield.bottomAnchor).isActive = true
        //width
        passwordTextfield.widthAnchor.constraint(equalTo: inputsContainer.widthAnchor).isActive = true
        //heigth
        passwordTextfieldHeightAnchor = passwordTextfield.heightAnchor.constraint(equalTo: inputsContainer.heightAnchor, multiplier: 1/3)
        
        
        passwordTextfieldHeightAnchor?.isActive = true
        
    }
    
    //funcion para implementar los contstrains registerButton
    func setupRegisterButton(){
        //agregamos x,y,height constrains // centramos en X
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //centramos en Y abajo del inputsContainer
        loginRegisterButton.topAnchor.constraint(equalTo: inputsContainer.bottomAnchor, constant: 12).isActive = true
        //width is equal to inputsContainer
        loginRegisterButton.widthAnchor.constraint(equalTo: inputsContainer.widthAnchor).isActive = true
        //heigth
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func setupSkipButton(){
        
        skipButton.topAnchor.constraint(equalTo: loginRegisterButton.bottomAnchor).isActive = true
        skipButton.centerXAnchor.constraint(equalTo: loginRegisterButton.centerXAnchor).isActive = true
        skipButton.widthAnchor.constraint(equalTo: loginRegisterButton.widthAnchor).isActive = true
        skipButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    //change the statusBar to white
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}

//extension para no poner los 255 todo el tiempo.
extension UIColor{
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat){
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}

