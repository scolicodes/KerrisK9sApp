//
//  ProfileViewModel.swift
//  KerrisK9sApp
//
//  Created by Michael Scoli on 2/24/25.
//

import Foundation

@MainActor
final class ProfileViewModel: ObservableObject {
    @Published private(set) var user: DBUser? = nil
    @Published private(set) var isAdmin: Bool = false
    
    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthManager.shared.getAuthenticatedUser()
        let fetchedUser = try await UserManager.shared.getUser(userId: authDataResult.uid)
        
        
        self.user = fetchedUser
        self.isAdmin = (fetchedUser.role == .admin)
    }
    
}
