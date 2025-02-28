//
//  UserManager.swift
//  KerrisK9sApp
//
//  Created by Michael Scoli on 2/24/25.
//

import Foundation
import FirebaseFirestore
 

final class UserManager {
    
    static let shared = UserManager()
    private init() {}
    
    private let userCollection = Firestore.firestore().collection("users")
    
    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    private let encoder: Firestore.Encoder = {
        let encoder = Firestore.Encoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    private let decoder: Firestore.Decoder = {
        let decoder = Firestore.Decoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func createNewUser(user: DBUser) async throws {
        try userDocument(userId: user.userId).setData(from: user, merge: false, encoder: encoder)
    }
    
    
    func getUser(userId: String) async throws -> DBUser {
            try await userDocument(userId: userId).getDocument(as: DBUser.self, decoder: decoder)
    }
    
    func deleteUser(userId: String) async throws {
            try await userDocument(userId: userId).delete()
    }
}
