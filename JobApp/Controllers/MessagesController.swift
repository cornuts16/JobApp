//
//  ViewController.swift
//  JobApp
//
//  Created by Corneliu Siscanu on 28/02/2019.
//  Copyright © 2019 Corneliu Siscanu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class MessagesController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(r: 255, g: 255, b: 255)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "logout", style: .plain, target: self, action: #selector(handleLogout))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(handleNewMessage))
        
        
        view.addSubview(mainPageSelectionController)
        
        checkIfUserIsLoggedIn()
        setupMainPageSegmentControl()
    }
    
    
    @objc func handleNewMessage(){
        let newNessageController = NewMessageController()
        let navController = UINavigationController(rootViewController: newNessageController)
        present(navController, animated: true, completion: nil)
    }
    
    func checkIfUserIsLoggedIn(){
        
        //user non loggato
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }
        else {
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    self.navigationItem.title = dictionary["name"] as? String
                }
            }, withCancel: nil)
            
        }
    }
    
    @objc func handleLogout(){
        
        do {
            try Auth.auth().signOut()
        } catch let logOutError {
            print(logOutError)
        }
        
        
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }

    
    
    let mainPageSelectionController : UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Home", "Profilo", "Messaggi", "Lavoro"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor.blue
        sc.selectedSegmentIndex = 0
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

