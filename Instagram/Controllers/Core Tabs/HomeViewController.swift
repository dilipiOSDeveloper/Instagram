//
//  ViewController.swift
//  Instagram
//
//  Created by Dilip Tiwari on 28/08/2563 BE.
//  Copyright © 2563 Dilip Tiwari. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
 
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleNotAuthenticated()
        
//        do {
//            try Auth.auth().signOut()
//        }
//        catch {
//            print("failed to sign out")
//        }
    }
    
    private func handleNotAuthenticated() {
        //Check auth status
        if Auth.auth().currentUser == nil {
            //Show login
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
        }
    }
}

