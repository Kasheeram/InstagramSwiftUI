//
//  SharePostView.swift
//  InstagramSwiftUI
//
//  Created by kashee on 29/03/24.
//

import SwiftUI

struct SharePostView: View {
    
    @State private var text = ""
    
    var body: some View {
        VStack {
            VStack(spacing: 0){
                HStack(spacing: 8) {
                    Image("post_1")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
                    
                    TextEditor(text: $text)
                        .frame(height: 100)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 8)
                .background(.white)
                
                
            }
            
            Spacer()
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationBarItems(trailing: Button(action: {
            
        }, label: {
            Text("Share")
        }).foregroundStyle(.black)
        )
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color(uiColor: .init(white: 0.9, alpha: 1)), for: .navigationBar)
        
        .background(Color(uiColor: .init(white: 0.9, alpha: 1)))
    }
    
}

#Preview {
    SharePostView()
}

