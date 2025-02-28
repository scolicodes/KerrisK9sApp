//
//  DBUser.swift
//  KerrisK9sApp
//
//  Created by Michael Scoli on 2/24/25.
//

import Foundation
import FirebaseFirestore

enum UserRole: String, Codable {
    case admin
    case walker
}

struct DBUser: Codable {
    let userId: String
    let email: String?
    let photoUrl: String?
    let dateCreated: Date?
    let role: UserRole
    
   
    init(auth: AuthDataResultModel, role: UserRole = .walker) {
        self.userId = auth.uid
        self.email = auth.email
        self.photoUrl = auth.photoUrl
        self.dateCreated = Date()
        self.role = role
    }
}
