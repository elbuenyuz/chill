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
        followButton.setImage(#imageLiteral(resourceName: "miniLogo").withRenderingMode(.alwaysOriginal), for: .normal)
        followButton.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: followButton)
    }
    
    private func setupRightNavItem(){
        //rigthItem compose
        let composeButton = UIButton(type: .system)
        composeButton.setImage(#imageLiteral(resourceName: "OvalsMoreOptions").withRenderingMode(.alwaysOriginal), for: .normal)
        composeButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
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
        containerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        containerView.addSubview(songNameLabel)
        songNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4).isActive = true
        songNameLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        songNameLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        songNameLabel.bottomAnchor.constraint(equalTo: playBtn.topAnchor, constant: 8)
        
        containerView.addSubview(playBtn)
        playBtn.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 8).isActive = true
        playBtn.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        playBtn.widthAnchor.constraint(equalToConstant: 40).isActive = true
        playBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        containerView.addSubview(songBtn)
        songBtn.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16).isActive = true
        songBtn.centerYAnchor.constraint(equalTo: playBtn.centerYAnchor).isActive  = true
        songBtn.widthAnchor.constraint(equalToConstant: 40).isActive = true
        songBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        containerView.addSubview(timerBtn)
        timerBtn.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16).isActive = true
        timerBtn.centerYAnchor.constraint(equalTo: playBtn.centerYAnchor).isActive  = true
        timerBtn.widthAnchor.constraint(equalToConstant: 40).isActive = true
        timerBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
}
