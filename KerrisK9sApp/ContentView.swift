//
//  ContentView.swift
//  KerrisK9sApp
//
//  Created by Michael Scoli on 12/19/24.
//

import SwiftUI

extension Color {
    static let lightPink = Color(UIColor(red: 204/255, green: 51/255, blue: 153/255, alpha: 1.0)) // Hex: #cc3399
}

struct LoginPage: View {
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                Spacer() // Push content down
                
                // Logo
                Image("KerrisLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200) // Fixed width
                    .padding(.bottom, 20)

                // Email Field
                TextField("Email", text: $email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.lightPink, lineWidth: 1) // Use custom pink
                    )
                    .padding(.horizontal, 16)

                // Password Field
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.lightPink, lineWidth: 1) // Use custom pink
                    )
                    .padding(.horizontal, 16)
                    .padding(.top, 10)

                // Login Button
                Button(action: {
                    // Handle login
                }) {
                    Text("Login")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.lightPink) // Use custom pink
                        .cornerRadius(8)
                        .padding(.horizontal, 16)
                }
                .padding(.top, 20)

                // Navigation to Sign-Up Page
                NavigationLink(destination: SignUpPage()) {
                    Text("Don't have an account? Sign Up")
                        .font(.footnote)
                        .foregroundColor(Color.lightPink) // Use custom pink
                        .padding(.top, 10)
                }

                Spacer() // Push content up
            }
            .padding(.vertical, 20) // Add vertical padding for better spacing
            .background(Color.white)
            .ignoresSafeArea()
        }
    }
}


struct SignUpPage: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""

    var body: some View {
        VStack {
            Spacer() // Push content down
            
            // Title
            Text("Sign Up")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.lightPink) // Use custom pink
                .padding(.bottom, 20)

            // Email Field
            TextField("Email", text: $email)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.lightPink, lineWidth: 1) // Use custom pink
                )
                .padding(.horizontal, 16)

            // Password Field
            SecureField("Password", text: $password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.lightPink, lineWidth: 1) // Use custom pink
                )
                .padding(.horizontal, 16)
                .padding(.top, 10)

            // Confirm Password Field
            SecureField("Confirm Password", text: $confirmPassword)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.lightPink, lineWidth: 1) // Use custom pink
                )
                .padding(.horizontal, 16)
                .padding(.top, 10)

            // Sign-Up Button
            Button(action: {
                // Handle sign-up
            }) {
                Text("Sign Up")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.lightPink) // Use custom pink
                    .cornerRadius(8)
                    .padding(.horizontal, 16)
            }
            .padding(.top, 20)

            Spacer() // Push content up
        }
        .padding(.vertical, 20) // Add vertical padding for better spacing
        .background(Color.white)
        .ignoresSafeArea()
    }
}



#Preview {
    LoginPage()
}
