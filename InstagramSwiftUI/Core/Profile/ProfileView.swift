//
//  ProfileView.swift
//  InstagramSwiftUI
//
//  Created by kashee on 13/03/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State var shouldShowLogOutOption = false
    
    let images = ["post_1", "profile_image", "gradient"] // images should be unique
    
    
    let layout = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear
        appearance.backgroundColor = .white
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    var body: some View {
        NavigationStack {
            ScrollView {
                
                VStack(alignment: .leading, spacing: 0) {
                    headerView
                    LazyVGrid(columns: layout, spacing: 1) {
                        ForEach(images, id: \.self) { image in
                            VStack {
                                Image(image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 100)
                                    .clipped()
                                    

                                    
                            }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(viewModel.currentUser?.username ?? "")
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        shouldShowLogOutOption.toggle()
                    } label: {
                        Image(systemName: "gear")
                    }.foregroundStyle(.black)

                }
            }
            .listStyle(.plain)
            .navigationBarTitleDisplayMode(.inline)
            .confirmationDialog("Options", isPresented: $shouldShowLogOutOption) {
                Button("Sign Out", role: .destructive) {
                                // Handle empty trash action.
                    viewModel.signOut()
                    shouldShowLogOutOption = false
                    print("Handle Signout action")
                }
                Button("Cancel", role: .cancel) {
                    shouldShowLogOutOption = false
                }

            }
        }
    }
    
    func attributedString(value: String, text: String) -> AttributedString {
        var value = AttributedString("\(value)\n")
        value.font = .systemFont(ofSize: 16, weight: .semibold)
        value.foregroundColor = .black
        
        var text = AttributedString(text)
        text.font = .systemFont(ofSize: 16 )
        text.foregroundColor = .gray
        
        return value + text
    }
    
    private var headerView: some View {
        VStack {
            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .top, spacing: 16) {
                   
                    WebImage(url: URL(string: viewModel.currentUser?.profileImgeUrl ?? ""))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(.circle)
                            .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                    
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text(attributedString(value: "11", text: "Posts"))
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                            Text(attributedString(value: "8", text: "Followers"))
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                            Text(attributedString(value: "2", text: "Following"))
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                        }
                        
                        Button {
                            
                        } label: {
                            Text("Edit Profile")
                                .font(.system(size: 16, weight: .semibold))
                        }
                        .foregroundStyle(.black)
                        .frame(width: 186, height: 40)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                    }
                }
                Text(viewModel.currentUser?.username ?? "")
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
            }.padding()
            
            Divider()
            
            HStack {
                Button {
                   
                } label: {
                    Image(systemName: "square.grid.4x3.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 14, height: 14)
                        .frame(maxWidth: .infinity)
                }

                Button {
                    
                } label: {
                    Image(systemName: "list.bullet")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 14, height: 14)
                        .frame(maxWidth: .infinity)
                }

                Button {
                    
                } label: {
                    Image(systemName: "bookmark")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 14, height: 14)
                        .frame(maxWidth: .infinity)
                }

            }
            .foregroundStyle(.black)
            .padding(10)
            
            Divider()
        }
    }
    
    
}

#Preview {
    ProfileView()
}
