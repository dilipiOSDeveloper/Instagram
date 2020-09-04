//
//  DatabaseManager.swift
//  Instagram
//
//  Created by Dilip Tiwari on 28/08/2563 BE.
//  Copyright © 2563 Dilip Tiwari. All rights reserved.
//

import FirebaseDatabase


public class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    // Mark:- Public
    
    /// Check if username and email is available
    /// - Parameters
    ///  - email: String representing email
    ///  - username: String representing username
    public func canCreateUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        completion(true)
        
    }
    
    /// Inserts new user data to database
    /// - Parameters
    ///  - email: String representing email
    ///  - username: String representing username
    ///  - completion: Async callback for result if database entry suceeded

    public func insertNewUser(with email: String, username: String, completion: @escaping(Bool) -> Void) {
        
        let key = email.safeDatabaseKey()
        print(key)
        
        database.child(key).setValue(["username": username]) { error, _ in
            if error == nil {
                // suceeded
                completion(true)
                return
            }
            else {
                // failed
                completion(false)
                return
            }
        }
    }
    
    // MARK: - Private
    
    private func safeKey() {
        
    }
}
