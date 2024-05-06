//
//  SwiftUIView.swift
//  InstagramSwiftUI
//
//  Created by kashee on 17/03/24.
//

import SwiftUI

struct InputView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField = false
    var body: some View {
        if isSecureField {
            SecureField(placeholder, text: $text)
        } else {
            TextField(placeholder, text: $text)
        }
    }
}

#Preview {
    InputView(text: .constant(""), title: "Email", placeholder: "name@gmail.com")
}
