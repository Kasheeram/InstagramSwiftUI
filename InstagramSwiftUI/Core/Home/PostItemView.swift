//
//  PostItemView.swift
//  InstagramSwiftUI
//
//  Created by kashee on 12/03/24.
//

import SwiftUI
import SDWebImageSwiftUI


struct PostItemView: View {
    let post: Post
    var body: some View {
        VStack {
            HStack(spacing: 8) {
                WebImage(url: URL(string: post.user.profileImgeUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 46, height: 46)
                        .clipShape(.circle)
                        .overlay(Circle().stroke(Color(.label),lineWidth: 1))
                    
                Text(post.user.username)
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                    
                    Spacer()
                    Image(systemName: "ellipsis")
                    .foregroundStyle(.black)

                    
            }.padding(.all, 10)
            
                
            WebImage(url: URL(string: post.imageUrl))
                .resizable()
                .scaledToFill()
                .frame(height: 340)
                .clipped()
            
            HStack(alignment: .top) {
                HStack(spacing: 16) {
                    Button {
                        
                    } label: {
                        Image("like_unselected")
                    }
                    Button {
                        
                    } label: {
                        Image("comment")
                    }
                    Button {
                        
                    } label: {
                        Image("send2")
                    }
                }
                Spacer()
                Button {
                    
                } label: {
                    Image(systemName: "bookmark")
                        .resizable()
                        
                }
                .frame(width: 16, height: 22)
                .foregroundStyle(.gray)
            }
            .padding(.horizontal)
            .padding(.top, 12) // .top, .vertical
               
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .top,spacing: 4) { // you can use here attributed text
                    Text(post.user.username).fontWeight(.semibold)
                    Text(post.caption)
                    Spacer()
                }
//                        .padding(.horizontal, 10)
//                        .padding(.vertical)
                .font(.system(size: 14))
                .foregroundStyle(.black)
                
                HStack {
                    Text(post.creationDate.timeAgoDisplay()).font(.system(size: 14)).foregroundStyle(.gray)
                }
            }
            .padding(.vertical)
            .padding(.horizontal, 10)
        }
    }
}

//#Preview {
//    PostItemView(post: feedViewModel.posts[0])
//}
