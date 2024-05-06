//
//  RootView.swift
//  InstagramSwiftUI
//
//  Created by kashee on 17/03/24.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                MainTabBar()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    RootView()
}
