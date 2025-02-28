//
//  LoginViewModel.swift
//  KerrisK9sApp
//
//  Created by Michael Scoli on 2/19/25.
//

import Foundation

@MainActor
final class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            throw NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Email and password cannot be empty."])
        }
        
        try await AuthManager.shared.signInUser(email: email, password: password)
    }
    
    func signInGoogle() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        let authDataResult = try await AuthManager.shared.signInWithGoogle(tokens: tokens)
        
        let existingUser = try? await UserManager.shared.getUser(userId: authDataResult.uid)
        let role = existingUser?.role ?? .walker  // Default role is walker

        let user = DBUser(auth: authDataResult, role: role)
        try await UserManager.shared.createNewUser(user: user)
    }
}
    
