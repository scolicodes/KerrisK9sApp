import Foundation
import FirebaseAuth

enum SignUpError: LocalizedError {
    case emptyFields
    case passwordsDoNotMatch

    var errorDescription: String? {
        switch self {
        case .emptyFields:
            return "Please fill in all fields."
        case .passwordsDoNotMatch:
            return "Passwords do not match."
        }
    }
}

@MainActor
final class SignUpViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    private let adminEmails = ["kerri1@example.com", "kerri2@example.com"] // Hardcoded admin emails
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
            throw SignUpError.emptyFields
        }
        
        guard password == confirmPassword else {
            throw SignUpError.passwordsDoNotMatch
        }
        
        let authDataResult = try await AuthManager.shared.createUser(email: email, password: password)
        
        let role: UserRole = adminEmails.contains(email) ? .admin : .walker
        
        let user = DBUser(auth: authDataResult, role: role)
        try await UserManager.shared.createNewUser(user: user)
        
    }

}
