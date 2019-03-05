//
//  ProfilePageController.swift
//  JobApp
//
//  Created by Corneliu Siscanu on 05/03/2019.
//  Copyright © 2019 Corneliu Siscanu. All rights reserved.
//

import UIKit

class ProfilePageController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mainPageSelectionController)
        
        setupMainPageSegmentControl()
        
    }
    
    let mainPageSelectionController : UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Home", "Profilo", "Messaggi", "Lavoro"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor.blue
        sc.selectedSegmentIndex = 1
        sc.addTarget(self, action: #selector(handleMainPageSelectionChange), for: .valueChanged)
        
        return sc
    }()
    
    @objc func handleMainPageSelectionChange(){
        let profilePageController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfilePageController") as UIViewController
        
        let jobSearchPageController = JobSearchPageController()
        let messagesController = MessagesController()
        let title = mainPageSelectionController.titleForSegment(at: mainPageSelectionController.selectedSegmentIndex)
        
        switch title {
        case "Home": present(messagesController, animated: true, completion: nil)
            
        case "Profilo": present(profilePageController, animated: true, completion: nil)
            
        case "Lavoro": present(jobSearchPageController, animated: true, completion: nil)
            
        default: present(messagesController, animated: true, completion: nil)
        }
        
        
    }
    
    func setupMainPageSegmentControl(){
        mainPageSelectionController.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainPageSelectionController.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12).isActive = true
        mainPageSelectionController.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -12).isActive = true
        mainPageSelectionController.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
        
}


