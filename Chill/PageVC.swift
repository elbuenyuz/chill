//
//  PageVC.swift
//  Sanapp
//
//  Created by Daniel Ramirez on 9/1/17.
//  Copyright © 2017 Devius. All rights reserved.
//

import UIKit
class PageVC: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    //pages and control created
    var pages = [UIViewController]()
    let initialPage = 0
    
    var pageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delegate and datasource
        self.dataSource = self
        self.delegate = self
        
        //arrayFetch
        let vc1 = FirstVC()
        let vc2 = MidVC()
        let vc3 = EndVC()
        pages.append(vc1)
        pages.append(vc2)
        pages.append(vc3)
        
        //set Controllers
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
        
        
        configurePageControl()
    }
    
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 50,width: UIScreen.main.bounds.width,height: 50))
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor(r: 100, g: 212, b: 199)
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = UIColor(r: 100, g: 212, b: 199)
        
        pageControl.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 20, height: 20))
        
        self.view.addSubview(pageControl)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let viewControllerIndex = self.pages.index(of: viewController) {
            if viewControllerIndex == 0 {
                // wrap to last page in array
                return self.pages.last
            } else {
                // go to previous page in array
                return self.pages[viewControllerIndex - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let viewControllerIndex = self.pages.index(of: viewController) {
            if viewControllerIndex < self.pages.count - 1 {
                // go to next page in array
                return self.pages[viewControllerIndex + 1]
            } else {
                // wrap to first page in array
                return self.pages.first
            }
        }
        return nil
    }
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        // set the pageControl.currentPage to the index of the current viewController in pages
        if let viewControllers = pageViewController.viewControllers {
            if let viewControllerIndex = self.pages.index(of: viewControllers[0]) {
                self.pageControl.currentPage = viewControllerIndex
            }
        }
    }
}
//first
class FirstVC: UIViewController {
    //elements
    let bg : UIImageView = {
        let imgView = UIImageView()
        imgView.image = #imageLiteral(resourceName: "slides")
        imgView.contentMode = .scaleAspectFill
        imgView.translatesAutoresizingMaskIntoConstraints = false
        
        return imgView
    }()
    
    let blurView: UIView = {
        let blur = UIView()
        blur.backgroundColor = .black
        blur.alpha = 0.5
        blur.translatesAutoresizingMaskIntoConstraints = false
        return blur
    }()
    
    //information for slide
    let titleLabel : UILabel = {
        let title = UILabel()
        title.font = UIFont(name: "Dosis-Regular", size: 40)
        title.text = "Welcome Soul"
        title.textColor = .white
        title.textAlignment = .center
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let infoLabel : UILabel = {
        let info = UILabel()
        info.font = UIFont(name: "Dosis-Regular", size: 16)
        info.text = "Music not only reflects the kind of mood we are in, but it also affects it. Listen to our plailist so you can shift your mood and energy level and help you overcome and reach your mood balance today!. Chill is a mood maintenance."
        info.textColor = .white
        info.numberOfLines = 5
        info.textAlignment = .center
        info.translatesAutoresizingMaskIntoConstraints = false
        return info
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        
        view.addSubview(bg)
        view.addSubview(blurView)
        view.addSubview(titleLabel)
        view.addSubview(infoLabel)
        
        bg.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bg.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        bg.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        bg.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        blurView.topAnchor.constraint(equalTo: bg.topAnchor).isActive = true
        blurView.leftAnchor.constraint(equalTo: bg.leftAnchor).isActive = true
        blurView.rightAnchor.constraint(equalTo: bg.rightAnchor).isActive = true
        blurView.bottomAnchor.constraint(equalTo: bg.bottomAnchor).isActive = true
        
        titleLabel.centerXAnchor.constraint(equalTo: bg.centerXAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: infoLabel.topAnchor, constant: -8).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: infoLabel.widthAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        infoLabel.centerXAnchor.constraint(equalTo: bg.centerXAnchor).isActive = true
        infoLabel.centerYAnchor.constraint(equalTo: bg.centerYAnchor).isActive = true
        infoLabel.widthAnchor.constraint(equalTo: bg.widthAnchor, constant: -16).isActive = true
        infoLabel.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    
}
//mid
class MidVC: UIViewController {
    
    let bg : UIImageView = {
        let imgView = UIImageView()
        imgView.image = #imageLiteral(resourceName: "slides")
    
        imgView.translatesAutoresizingMaskIntoConstraints = false
        
        return imgView
    }()
    
    var blurView: UIView = {
        let blur = UIView()
        blur.backgroundColor = .black
        blur.alpha = 0.5
        blur.translatesAutoresizingMaskIntoConstraints = false
        return blur
    }()
    
    //information for slide
    let titleLabel : UILabel = {
        let title = UILabel()
        title.font = UIFont(name: "Dosis-Regular", size: 40)
        title.text = "Chill's moods"
        title.textColor = .white
        title.textAlignment = .center
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let infoLabel : UILabel = {
        let info = UILabel()
        info.font = UIFont(name: "Dosis-Regular", size: 16)
        info.text = "This application it is going to help you in every different daily moods, Because music activates every region of our brain, our brain chemistry can be altered through the use of music. So if you’re looking for ways to boost your actual mood."
        info.textColor = .white
        info.numberOfLines = 5
        info.textAlignment = .center
        info.translatesAutoresizingMaskIntoConstraints = false
        return info
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        view.addSubview(bg)
        view.addSubview(blurView)
        view.addSubview(titleLabel)
        view.addSubview(infoLabel)
        
        bg.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bg.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        bg.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        bg.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        blurView.topAnchor.constraint(equalTo: bg.topAnchor).isActive = true
        blurView.leftAnchor.constraint(equalTo: bg.leftAnchor).isActive = true
        blurView.rightAnchor.constraint(equalTo: bg.rightAnchor).isActive = true
        blurView.bottomAnchor.constraint(equalTo: bg.bottomAnchor).isActive = true
        
        titleLabel.centerXAnchor.constraint(equalTo: bg.centerXAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: infoLabel.topAnchor, constant: -8).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: infoLabel.widthAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        infoLabel.centerXAnchor.constraint(equalTo: bg.centerXAnchor).isActive = true
        infoLabel.centerYAnchor.constraint(equalTo: bg.centerYAnchor).isActive = true
        infoLabel.widthAnchor.constraint(equalTo: bg.widthAnchor, constant: -16).isActive = true
        infoLabel.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
}
//last one
class EndVC: UIViewController {
  
    let bg : UIImageView = {
        let imgView = UIImageView()
        imgView.image = #imageLiteral(resourceName: "slides")
        imgView.contentMode = .scaleAspectFill
        imgView.translatesAutoresizingMaskIntoConstraints = false
        
        return imgView
    }()
    
    var blurView: UIView = {
        let blur = UIView()
        blur.backgroundColor = .black
        blur.alpha = 0.5
        blur.translatesAutoresizingMaskIntoConstraints = false
        return blur
    }()

    //information for slide
    let titleLabel : UILabel = {
        let title = UILabel()
        title.font = UIFont(name: "Dosis-Regular", size: 40)
        title.text = "Enjoy and Relax"
        title.textColor = .white
        title.textAlignment = .center
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let infoLabel : UILabel = {
        let info = UILabel()
        info.font = UIFont(name: "Dosis-Regular", size: 16)
        info.text = "You can support the app by giving us a feedback and a rate on the appstore, dont forget to subscribe to get access to premium content."
        info.textColor = .white
        info.numberOfLines = 5
        info.textAlignment = .center
        info.translatesAutoresizingMaskIntoConstraints = false
        return info
    }()
    
    let button: UIButton = {
        let btn = UIButton(type: UIButtonType.system)
        btn.setTitle("Got it", for: .normal)
        btn.backgroundColor = UIColor(red:0.03, green:0.61, blue:0.54, alpha:1.0)
        btn.layer.cornerRadius = 5
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        btn.layer.shadowColor = UIColor.red.cgColor
        btn.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidLoad() {
       
        
        super.viewDidLoad()
        view.backgroundColor = .orange
        view.addSubview(bg)
        view.addSubview(blurView)
        view.addSubview(titleLabel)
        view.addSubview(infoLabel)
        view.addSubview(button)
        
        
        blurView.topAnchor.constraint(equalTo: bg.topAnchor).isActive = true
        blurView.leftAnchor.constraint(equalTo: bg.leftAnchor).isActive = true
        blurView.rightAnchor.constraint(equalTo: bg.rightAnchor).isActive = true
        blurView.bottomAnchor.constraint(equalTo: bg.bottomAnchor).isActive = true
        
        bg.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bg.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        bg.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        bg.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        titleLabel.centerXAnchor.constraint(equalTo: bg.centerXAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: infoLabel.topAnchor, constant: -8).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: infoLabel.widthAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        infoLabel.centerXAnchor.constraint(equalTo: bg.centerXAnchor).isActive = true
        infoLabel.centerYAnchor.constraint(equalTo: bg.centerYAnchor).isActive = true
        infoLabel.widthAnchor.constraint(equalTo: bg.widthAnchor, constant: -16).isActive = true
        infoLabel.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        button.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: -8).isActive = true
        button.centerXAnchor.constraint(equalTo: bg.centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 90).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    
    func handleDismiss(){
        print("we handle dismiss")
        dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(true, forKey: "completeWalk")
        print("button pressed se ha completado el Walk")
    }
}
