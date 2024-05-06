//
//  LoginView.swift
//  InstagramSwiftUI
//
//  Created by kashee on 14/03/24.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var shoulPresentSignupView = false
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack {
                        HStack {
                            Spacer()
                            Image("Instagram_logo_white")
                            Spacer()
                        }
                        .frame(height: 160)
                        .background(.pink)
                        
                        VStack(spacing: 16) {
                            Group {
                                TextField("Email", text: $email)
                                    .keyboardType(.emailAddress)
                                TextField("Password", text: $password)
                            }
                            .padding(12)
                            .background(.white)
    //                        .background(RoundedRectangle(cornerRadius: 5).fill(Color.white)) // we can make corner rounded in this way as well
                            .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                        }.padding()
                        
                        Button {
                            Task {
                                try await viewModel.signIn(withEmail: email, password: password)
                            }
                        } label: {
                            Spacer()
                            Text("Login")
                            Spacer()
                        }
                        .frame(height: 40)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .background(.pink)
                        .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                        .padding()
                        
                       
                    }
                }
                .ignoresSafeArea()
                
                HStack {
                    Spacer()
                    Button {
                        shoulPresentSignupView.toggle()
                    } label: {
                        Text(attributedString)
                    }
                    .foregroundStyle(.gray)
                    Spacer()
                }
                
            }
            .background(Color(.init(white: 0, alpha: 0.05)))
            .fullScreenCover(isPresented: $shoulPresentSignupView, content: {
                SignupView()
            })
        }
    }
    
    var attributedString: AttributedString {
        var attributedString = AttributedString("Don't have an account? Sign Up")
        attributedString.font = .system(size: 16)
        guard let range = attributedString.range(of: "Sign Up") else {return attributedString}
        attributedString[range].foregroundColor = .blue
        attributedString[range].font = .system(size: 16, weight: .semibold)
        return attributedString
    }
}

#Preview {
    LoginView()
}
