//
//  SignupView.swift
//  InstagramSwiftUI
//
//  Created by kashee on 17/03/24.
//

import SwiftUI

struct SignupView: View {
    @Environment(\.dismiss) var dismiss
    @State private var email = ""
    @State private var username = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 20) {
                    Image("plus_photo")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .foregroundStyle(.pink)
                    
                    VStack(spacing: 12) {
                        TextField("Email", text: $email)
                            .modifier(TextFieldViewModifier())
                            .background(.white)
                            
                        TextField("Username", text: $username)
                            .modifier(TextFieldViewModifier())
                            .background(.white)
                           
                        TextField("Password", text: $password)
                            .modifier(TextFieldViewModifier())
                            .background(.white)
                            
                        Button {
                            Task {
                                try await viewModel.createUser(withEmail:email,password:password,fullname: "kashee kushwaha")
                            }
                        } label: {
                            Spacer()
                            Text("Sign Up")
                            Spacer()
                        }
                        .padding(12)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .background(.pink)
                        .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                    }
                    
                    
                }.padding()
            }
            HStack {
                Spacer()
                Button {
                    
                } label: {
                    Button {
                        dismiss()
                    } label: {
                        Text(attributedString)
                    }

                    
                }
                .foregroundStyle(.gray)
                Spacer()
            }
        }
        .background(Color(.init(white: 0, alpha: 0.05)))
        
    }
    
    var attributedString: AttributedString {
        var attributedString = AttributedString("Already have an account? Login")
        attributedString.font = .system(size: 16)
        guard let range = attributedString.range(of: "Login") else {return attributedString}
        attributedString[range].foregroundColor = .blue
        attributedString[range].font = .system(size: 16, weight: .semibold)
        return attributedString
    }
}

struct TextFieldViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
        .padding(12)
        .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
    }
}

#Preview {
    SignupView()
}
