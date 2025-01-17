//
//  LoginView.swift
//  KerrisK9sApp
//
//  Created by Michael Scoli on 12/21/24.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth

struct GoogleSignInResultModel {
    let idToken: String
    let accessToken: String
}

@MainActor
final class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
        
        try await AuthManager.shared.signInUser(email: email, password: password)
        print("Login successful")
    }
    
    func signInGoogle() async throws {
        guard let topVC = Utilities.shared.topViewController() else {
            throw URLError(.cannotFindHost)
        }
        
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        
        guard let idToken: String = gidSignInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        
        let accessToken: String = gidSignInResult.user.accessToken.tokenString
        
        let tokens = GoogleSignInResultModel(idToken: idToken, accessToken: accessToken)
        try await AuthManager.shared.signInWithGoogle(tokens: tokens)
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
            
            GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal))  {
                Task {
                    do {
                        try await viewModel.signInGoogle()
                        showLoginView = false
                    }
                    catch {
                        print(error)
                    }
                }
                
            }
            
            .padding(.top, 20)
            NavigationLink(destination: SignUpView(showLoginView: $showLoginView)) {
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
