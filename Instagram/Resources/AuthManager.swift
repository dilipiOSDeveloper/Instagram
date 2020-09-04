//
//  AuthManager.swift
//  Instagram
//
//  Created by Dilip Tiwari on 28/08/2563 BE.
//  Copyright © 2563 Dilip Tiwari. All rights reserved.
//

import FirebaseAuth


public class AuthManager {
    
    static let shared = AuthManager()
    
    // Mark:- Public
    
    public func registerNewUser(username: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        
        /*
         - Check if username is available
         - Check if email is available
         - Create Account
         - Insert account to database
         */
        DatabaseManager.shared.canCreateUser(with: email, username: username) { canCreate in
            if canCreate {
                /*
                 - Create Account
                 - Insert account to database
                 */
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    
                    guard error == nil, result != nil else {
                        // Firebase auth could not create account
                        completion(false)
                        return
                    }
                    // Insert into database
                    DatabaseManager.shared.insertNewUser(with: email, username: username) { inserted in
                            
                        if inserted {
                            completion(true)
                            return
                        }
                        else {
                            // Failed to insert to database
                            completion(false)
                            return
                        }
                    }
                    
                }
            }
            else{
                // either username or email doesnot exist
                completion(false)
            }
        }
    }
    
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void) {
        if let email = email {
            //email login in
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
        }
        else if let username = username {
            //username log in
            print(username)
        }
    }
    
    /// Attempt to log out firebase user
    public func logOut(completion: (Bool) -> Void) {
        
        do {
            try Auth.auth().signOut()
            completion(true)
            return
        }
        catch {
            print(error)
            completion(false)
            return
        }
    }
}

