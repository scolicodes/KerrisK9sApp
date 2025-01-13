//
//  SettingsView.swift
//  KerrisK9sApp
//
//  Created by Michael Scoli on 12/23/24.
//

import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    func signOut() throws {
        try AuthManager.shared.signOut()
    }
    
    func resetPassword() async throws {
        let authUser = try AuthManager.shared.getAuthenticatedUser()
        
        guard let email = authUser.email else {
            throw URLError(.fileDoesNotExist) // change this to actually handle error in UI
        }
        
        try await AuthManager.shared.resetPassword(email: email)
    }
}

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
        }
        .navigationBarTitle("Settings")
    }
}

#Preview {
    NavigationStack {
        SettingsView(showLoginView: .constant(false))
    }
}
