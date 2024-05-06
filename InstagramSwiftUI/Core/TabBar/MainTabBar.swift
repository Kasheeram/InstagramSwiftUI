//
//  MainTabBar.swift
//  InstagramSwiftUI
//
//  Created by kashee on 13/03/24.
//

import SwiftUI

struct MainTabBar: View {
    @State var shouldPresentImagesView = false
    @State private var oldSelectedItem = 0
    @State private var selectedTabIndex = 0
    var body: some View {
        TabView(selection: $selectedTabIndex) {
            PostListView()
                .tabItem { Label("", systemImage: "house") }
                .tag(0)
            SearchView()
                .tabItem { Label("", systemImage: "magnifyingglass") }
                .tag(1)
            Text("")
                .tabItem { Label("", systemImage: "plus") }
                .tag(2)
            NotificationView()
                .tabItem { Label("", systemImage: "heart") }
                .tag(3)
            ProfileView()
                .tabItem { Label("", systemImage: "person") }
                .tag(4)
        }
        
        .onChange(of: selectedTabIndex, { oldValue, newValue in
            self.oldSelectedItem = oldValue
            if newValue == 2 {
                self.shouldPresentImagesView = true
            }
        })
        .fullScreenCover(isPresented: $shouldPresentImagesView, onDismiss: {
            self.selectedTabIndex = self.oldSelectedItem
        }, content: {
            SelectImagesView()
        })
    }
}

#Preview {
    MainTabBar()
}
