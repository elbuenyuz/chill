import UIKit

extension MainViewVC {
    
    func setupNavigationBarAndDesignItems(){
        
        setupLeftNavItem()
        setupRightNavItem()
        setupTransparentAndTitleNavBars()
        setupContainer()
        

        
    }
    
    private func setupLeftNavItem(){
        //leftItem
        let followButton = UIButton(type: .system)
        followButton.setImage(#imageLiteral(resourceName: "logo-1").withRenderingMode(.alwaysOriginal), for: .normal)
        followButton.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
        followButton.addTarget(self, action: #selector(handlePremium), for: .touchUpInside)
        followButton.clipsToBounds = true
        navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: followButton)
    }
    
    func handlePremium(){
        checkIfUserIsLoggedIn()
    }
    
    private func setupRightNavItem(){
        //rigthItem compose
        let composeButton = UIButton(type: .system)
        composeButton.setImage(#imageLiteral(resourceName: "tools").withRenderingMode(.alwaysOriginal), for: .normal)
        composeButton.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
        composeButton.contentMode = .scaleAspectFit
        
        composeButton.addTarget(self, action: #selector(self.handleMore), for: .touchUpInside)
        
        
        //mas de dos objetos en el mismo lado
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: composeButton)]
    }
    
     private func setupTransparentAndTitleNavBars(){
        
        navigationController?.navigationBar.barTintColor = .clear
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = UIColor.clear
        
        navigationController?.navigationBar.layer.shadowColor = UIColor(r: 230, g: 230, b: 230).cgColor
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        navigationController?.navigationBar.layer.shadowRadius = 1.5
        navigationController?.navigationBar.layer.masksToBounds = false
        
        setupBackgroundAndBlur(image: #imageLiteral(resourceName: "bg"))
        
    }
    private func setupContainer(){
        
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70).isActive = true
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        containerView.addSubview(songNameLabel)
        songNameLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        songNameLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        songNameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        songNameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        containerView.addSubview(playBtn)
        playBtn.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        playBtn.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        playBtn.widthAnchor.constraint(equalToConstant: 100).isActive = true
        playBtn.heightAnchor.constraint(equalToConstant:100).isActive = true
        
        containerView.addSubview(songBtn)
        songBtn.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8).isActive = true
        songBtn.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive  = true
        songBtn.widthAnchor.constraint(equalToConstant: 85).isActive = true
        songBtn.heightAnchor.constraint(equalToConstant: 85).isActive = true
        
        containerView.addSubview(infoBtn)
     
        infoBtn.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
        infoBtn.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive  = true
        infoBtn.heightAnchor.constraint(equalToConstant: 85).isActive = true
        infoBtn.widthAnchor.constraint(equalToConstant: 85).isActive = true
        
        
    }
    
    func setupBackgroundAndBlur(image: UIImage){
        
        backgroundImage.image = image
        backgroundImage.alpha = 1
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
}
