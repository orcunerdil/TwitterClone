//
//  TwitterUser.swift
//  TwitterClone
//
//  Created by Orçun Erdil on 22.08.2023.
//

import Foundation
import Firebase

struct TwitterUser : Codable {
    let id: String
    var displayName: String = ""
    var username :String = ""
    var followersCount :Double = 0
    var followingCount :Double = 0
    var createdOn :Date = Date()
    var bio : String = ""
    var avatarPath: String = ""
    var isUserOnboarded :Bool = false
    
    init(frame user:User) {
        self.id = user.uid
    }
   
}
