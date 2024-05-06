//
//  InstagramSwiftUIApp.swift
//  InstagramSwiftUI
//
//  Created by kashee on 12/03/24.
//

import SwiftUI
import Firebase

@main
struct InstagramSwiftUIApp: App {
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView().environmentObject(viewModel)
        }
    }
}
