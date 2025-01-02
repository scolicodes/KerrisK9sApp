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
        }
        .navigationBarTitle("Settings")
    }
}

#Preview {
    NavigationStack {
        SettingsView(showLoginView: .constant(false))
    }
}
