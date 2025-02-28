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
                    } catch {
                        print("Error logging out: \(error.localizedDescription)")
                    }
                }
            }

            if viewModel.isAdmin {
                Section(header: Text("Admin Settings")) {
                    Button("Manage Walk Schedules") {
                        // TODO: Open Schedule Manager
                    }
                }
            }
            
            Section {
                Button(role: .destructive) {
                    Task {
                        do {
                            try await viewModel.deleteAccount()
                            showLoginView = true
                        } catch {
                            print("Error deleting account: \(error.localizedDescription)")
                        }
                    }
                } label: {
                    Text("Delete Account")
                }
            }
            
            emailSection
        }
        .onAppear {
            Task {
                await viewModel.loadCurrentUser()  // ✅ Ensure isAdmin updates
            }
        }
        .navigationBarTitle("Settings")
    }
    
    private var emailSection: some View {
        Section(header: Text("Email Functions")) {
            Button("Reset password") {
                Task {
                    do {
                        try await viewModel.resetPassword()
                        print("Password Reset!")
                    } catch {
                        print("Error resetting password: \(error.localizedDescription)")
                    }
                }
            }
            Button("Update password") {
                Task {
                    do {
                        try await viewModel.updatePassword()
                        print("Password Updated!")
                    } catch {
                        print("Error updating password: \(error.localizedDescription)")
                    }
                }
            }
            Button("Update email") {
                Task {
                    do {
                        try await viewModel.updateEmail()
                        print("Email Updated!")
                    } catch {
                        print("Error updating email: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView(showLoginView: .constant(false))
    }
}
