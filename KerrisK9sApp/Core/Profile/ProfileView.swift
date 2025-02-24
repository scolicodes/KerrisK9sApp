//
//  ProfileView.swift
//  KerrisK9sApp
//
//  Created by Michael Scoli on 2/19/25.
//

import SwiftUI



struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    @Binding var showLoginView: Bool
    
    
    var body: some View {
        List {
            if let user = viewModel.user {
                Text("UserId: \(user.userId)")
            }
        }
        .task {
            try? await viewModel.loadCurrentUser()
        }
        .navigationTitle("Profile")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    SettingsView(showLoginView: $showLoginView)
                } label: {
                    Image(systemName: "gear")
                        .font(.headline)
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProfileView(showLoginView: .constant(false))
        }
    }
}
