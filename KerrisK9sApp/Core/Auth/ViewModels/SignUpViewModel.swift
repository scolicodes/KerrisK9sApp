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
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
            throw SignUpError.emptyFields
        }
        
        // Check if passwords match
        guard password == confirmPassword else {
            throw SignUpError.passwordsDoNotMatch
        }
        
        let authDataResult = try await AuthManager.shared.signInUser(email: email, password: password)
        try await AuthManager.shared.createUser(email: email, password: password)
        
    }
}
