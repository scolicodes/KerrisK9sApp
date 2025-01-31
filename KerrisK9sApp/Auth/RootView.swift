//
//  RootView.swift
//  KerrisK9sApp
//
//  Created by Michael Scoli on 12/23/24.
//

import SwiftUI

struct RootView: View {
    
    @State private var showLoginView: Bool = false
    
    var body: some View {
        ZStack {
            if !showLoginView {
                NavigationStack {
                    SettingsView(showLoginView: $showLoginView)
                }
            }
        }
        .onAppear {
            let authUser = try? AuthManager.shared.getAuthenticatedUser()
            self.showLoginView = authUser == nil
        }
        .fullScreenCover(isPresented: $showLoginView) {
            NavigationStack {
                LoginView(showLoginView: $showLoginView)
            }
        }
    }
}


#Preview {
    RootView()
}
