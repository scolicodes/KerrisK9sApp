//
//  SignUpView.swift
//  KerrisK9sApp
//
//  Created by Michael Scoli on 12/21/24.
//

import SwiftUI

struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @Binding var showLoginView: Bool

    var body: some View {
        VStack {
            Spacer()
            Text("Sign Up")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.lightPink)
                .padding(.bottom, 20)
            TextField("Email", text: $email)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.lightPink, lineWidth: 1)
                    )
                .padding(.horizontal, 16)
            SecureField("Password", text: $password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.lightPink, lineWidth: 1)
                    )
                .padding(.horizontal, 16)
                .padding(.top, 10)
            SecureField("Confirm Password", text: $confirmPassword)
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
                // Handle sign-up
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

