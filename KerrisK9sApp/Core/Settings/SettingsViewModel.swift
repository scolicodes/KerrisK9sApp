import Foundation

@MainActor
final class SettingsViewModel: ObservableObject {
    
    @Published var authProviders: [AuthProviderOption] = []
    @Published var isAdmin: Bool = false  // ✅ Add this property
    
    func loadAuthProviders() {
        if let providers = try? AuthManager.shared.getProviders() {
            authProviders = providers
        }
    }
    
    func loadCurrentUser() async {
        do {
            let authDataResult = try AuthManager.shared.getAuthenticatedUser()
            let user = try await UserManager.shared.getUser(userId: authDataResult.uid)
            
            DispatchQueue.main.async {  // ✅ Ensure UI updates on the main thread
                self.isAdmin = user.role == .admin  // Check user role
            }
        } catch {
            print("Failed to load user: \(error.localizedDescription)")
        }
    }
    
    func signOut() throws {
        try AuthManager.shared.signOut()
    }
    
    func deleteAccount() async throws {
        let authUser = try AuthManager.shared.getAuthenticatedUser()
        
        // Delete user from Firestore
        try await UserManager.shared.deleteUser(userId: authUser.uid)
        
        // Delete user from Firebase Authentication
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
