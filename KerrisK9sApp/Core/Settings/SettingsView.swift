//
//  SettingsView.swift
//  KerrisK9sApp
//
//  Created by Michael Scoli on 12/23/24.
//

import SwiftUI



struct SettingsView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showLoginView: Bool
    
    var body: some View {
        List {
            Button("Log out") {
                Task {
                    do {
                        try viewModel.signOut()
                        showLoginView = true
                    }
                    catch {
                        print(error) // actually handle this error and display it to user
                    }
                }
            }
            
            Button(role: .destructive) {
                Task {
                    do {
                        try await viewModel.deleteAccount()
                        showLoginView = true
                    }
                    catch {
                        print(error) // actually handle this error and display it to user
                    }
                }
            } label: {
                Text("Delete account")
            }
            
            if viewModel.authProviders.contains(.email) {
                emailSection
            }
            
        }
        .onAppear {
            viewModel.loadAuthProviders()
        }
        .navigationBarTitle("Settings")
    }
}

#Preview {
    NavigationStack {
        SettingsView(showLoginView: .constant(false))
    }
}

extension SettingsView {
    private var emailSection: some View {
        Section {
            Button("Reset password") {
                Task {
                    do {
                        try await viewModel.resetPassword()
                        print("Password Reset!")
                    }
                    catch {
                        print(error) // actually handle this error and display it to user
                    }
                }
            }
            Button("Update password") {
                Task {
                    do {
                        try await viewModel.updatePassword()
                        print("Password Updated!")
                    }
                    catch {
                        print(error) // actually handle this error and display it to user
                    }
                }
            }
            Button("Update email") {
                Task {
                    do {
                        try await viewModel.updateEmail()
                        print("Email Updated!")
                    }
                    catch {
                        print(error) // actually handle this error and display it to user
                    }
                }
            }
        } header: {
            Text("Email functions")
        }
    }
}
