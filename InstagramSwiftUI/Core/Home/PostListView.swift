//
//  HomeView.swift
//  InstagramSwiftUI
//
//  Created by kashee on 12/03/24.
//

import SwiftUI

struct PostListView: View {
    @ObservedObject var feedViewModel = FeedViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(feedViewModel.posts) { post in
                        PostItemView(post: post)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                        Image("Instagram_text")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 40)
                    }
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        
                    } label: {
                        Image(systemName: "camera")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 26, height: 26)
                    }.foregroundStyle(.black)

                }
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 10) {
                        Button {
                            
                        } label: {
                            Image(systemName: "heart")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 22, height: 22)
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "ellipsis.message")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 22, height: 22)
                        }
                    }.foregroundStyle(.black)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
}

#Preview {
    PostListView()
}
