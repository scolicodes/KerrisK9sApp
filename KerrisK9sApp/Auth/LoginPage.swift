//
//  LoginPage.swift
//  KerrisK9sApp
//
//  Created by Michael Scoli on 12/21/24.
//

import SwiftUI

struct LoginPage: View {
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Image("KerrisLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
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
                Button(action: {
                    // Handle login
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
                NavigationLink(destination: SignUpPage()) {
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
}

#Preview {
    LoginPage()
}
