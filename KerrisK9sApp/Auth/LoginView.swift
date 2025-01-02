//
//  LoginView.swift
//  KerrisK9sApp
//
//  Created by Michael Scoli on 12/21/24.
//

import SwiftUI

@MainActor
final class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
        
        try await AuthManager.shared.createUser(email: email, password: password)
    }
}

struct LoginView: View {
    
    @StateObject private var viewModel = LoginViewModel()
    @Binding var showLoginView: Bool
    
    var body: some View {
        VStack {
            Spacer()
            Image("KerrisLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 200)
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
            Button(action: {
                Task {
                    do {
                        try await viewModel.signIn()
                        showLoginView = false
                    }
                    catch {
                        print(error)
                    }
                    
                }
            }) {
                Text("Login")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.lightPink)
                    .cornerRadius(8)
                    .padding(.horizontal, 16)
            }
            .padding(.top, 20)
            NavigationLink(destination: SignUpView(showLoginView: .constant(false))) {
                Text("Don't have an account? Sign Up")
                    .font(.footnote)
                    .foregroundColor(Color.lightPink)
                    .padding(.top, 10)
            }
            Spacer()
        }
        .padding(.vertical, 20)
        .background(Color.white)
        .ignoresSafeArea()
    }
}

#Preview {
    LoginView(showLoginView: .constant(false))
}
