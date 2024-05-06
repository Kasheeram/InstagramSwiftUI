//
//  AddPostView.swift
//  InstagramSwiftUI
//
//  Created by kashee on 13/03/24.
//

import SwiftUI
import Photos

struct AddPostView: View {
    @State var shouldPresentImagesView = true
    
    var body: some View {
        Text("").fullScreenCover(isPresented: $shouldPresentImagesView, content: {
            SelectImagesView()
        })
    }
    
}



#Preview {
    AddPostView()
}

