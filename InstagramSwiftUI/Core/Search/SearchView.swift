//
//  SearchView.swift
//  InstagramSwiftUI
//
//  Created by kashee on 13/03/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct SearchView: View {
    @ObservedObject var viewModel = SearchViewModel()
    @State var searchText = ""
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(viewModel.users) { user in
                        HStack(alignment: .center, spacing: 8) {
                            WebImage(url: URL(string: user.profileImgeUrl))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 48, height: 48)
                                .clipShape(.circle)
                                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                            Text(user.username).font(.system(size: 14)).fontWeight(.semibold)
                            Spacer()
                        }.padding(.horizontal)
                        Divider().padding(.leading, 70)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always),
                        prompt: Text("Enter username")
                .foregroundColor(.secondary))
        }
    }
}

#Preview {
    SearchView()
}
