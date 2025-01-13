//
//  SignUpView.swift
//  KerrisK9sApp
//
//  Created by Michael Scoli on 12/21/24.
//

import SwiftUI
import FirebaseAuth

@MainActor
final class SignUpViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
            print("Please fill in all fields.")
            return
        }
        
        // Check if passwords match
        guard password == confirmPassword else {
            print("Passwords do not match.")
            return
        }
        
        try await AuthManager.shared.createUser(email: email, password: password)
        print("Sign-up successful")
    }
}

struct SignUpView: View {
    @StateObject private var viewModel = SignUpViewModel()
    @Binding var showLoginView: Bool

    var body: some View {
        VStack {
            Spacer()
            Text("Sign Up")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.lightPink)
                .padding(.bottom, 20)
            TextField("Email", text: $viewModel.email)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.lightPink, lineWidth: 1)
                    )
                .padding(.horizontal, 16)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
            SecureField("Password", text: $viewModel.password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.lightPink, lineWidth: 1)
                    )
                .padding(.horizontal, 16)
                .padding(.top, 10)
            SecureField("Confirm Password", text: $viewModel.confirmPassword)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.lightPink, lineWidth: 1)
                    )
                .padding(.horizontal, 16)
                .padding(.top, 10)
            Button(action: {
                Task {
                        do {
                            try await viewModel.signUp()

                            
                            // Update showLoginView to trigger transition to SettingsView
                            showLoginView = false
                        } catch {
                            print("Sign-up error: \(error)")
                        }
                    }
            }) {
                Text("Sign Up")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.lightPink)
                    .cornerRadius(8)
                    .padding(.horizontal, 16)
            }
            .padding(.top, 20)
            Spacer()
        }
        .padding(.vertical, 20)
        .background(Color.white)
        .ignoresSafeArea()
    }
}

