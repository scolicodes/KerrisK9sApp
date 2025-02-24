//
//  LoginView.swift
//  KerrisK9sApp
//
//  Created by Michael Scoli on 12/21/24.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift


struct LoginView: View {
    
    @StateObject private var viewModel = LoginViewModel()
    @Binding var showLoginView: Bool
    @State private var errorMessage: String?
    
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

                if let errorMessage {
                    Text(errorMessage)
                        .font(.footnote)
                        .foregroundColor(.red)
                        .padding(.top, 5)
                        .padding(.horizontal, 16)
                }
                
                Button(action: {
                    Task {
                        do {
                            try await viewModel.signIn()
                            showLoginView = false
                        } catch {
                            errorMessage = error.localizedDescription  // Update UI with error
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
                
                HStack {
                    Spacer()
                    GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal)) {
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
                    .frame(width: 250, height: 50) // Adjust width and height for a better fit
                    .cornerRadius(10) // Smooth rounded edges
                    Spacer()
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
