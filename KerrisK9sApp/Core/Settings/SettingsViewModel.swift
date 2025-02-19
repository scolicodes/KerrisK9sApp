//
//  SettingsViewModel.swift
//  KerrisK9sApp
//
//  Created by Michael Scoli on 2/19/25.
//

import Foundation

@MainActor
final class SettingsViewModel: ObservableObject {
    
    @Published var authProviders: [AuthProviderOption] = []
    
    func loadAuthProviders() {
        if let providers = try? AuthManager.shared.getProviders() {
            authProviders = providers
        }
            
    }
    
    func signOut() throws {
        try AuthManager.shared.signOut()
    }
    
    func deleteAccount() async throws {
        try await AuthManager.shared.delete()
    }
    
    func resetPassword() async throws {
        let authUser = try AuthManager.shared.getAuthenticatedUser()
        
        guard let email = authUser.email else {
            throw URLError(.fileDoesNotExist) // change this to actually handle error in UI
        }
        
        try await AuthManager.shared.resetPassword(email: email)
    }
    
    func updateEmail() async throws {
        let email = "hello123@gmail.com" // temp hardcoded email
        try await AuthManager.shared.updateEmail(email: email)
    }
    
    func updatePassword() async throws {
        let password = "hello123" // temp hardcoded password
        try await AuthManager.shared.updatePassword(password: password)
    }
}
