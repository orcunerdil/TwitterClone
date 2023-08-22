//
//  DatabaseManager.swift
//  TwitterClone
//
//  Created by Orçun Erdil on 22.08.2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestoreCombineSwift
import Combine

class DatabaseManager {
    static let shared = DatabaseManager()
    
    let db = Firestore.firestore()
    let usersPath:String = "users"
    
    
    func collectionUser(add user:User) -> AnyPublisher <Bool,Error> {
        
        let twitterUser = TwitterUser(frame: user)
        return db.collection(usersPath).document(twitterUser.id).setData(from: twitterUser)
            .map { _ in
                return true
            }
            .eraseToAnyPublisher()
        
    }
    
    func collectionUsers(retreive id :String) -> AnyPublisher <TwitterUser,Error> {
        db.collection(usersPath).document(id).getDocument()
            .tryMap {
               try $0.data(as: TwitterUser.self)
            }
            .eraseToAnyPublisher()
    }
    
}
