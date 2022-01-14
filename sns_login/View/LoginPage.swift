//
//  ContentView.swift
//  sns_login
//
//  Created by mct-1 on 2022/01/14.
//

import SwiftUI
import AuthenticationServices

struct LoginPage: View {

    @Environment(\.colorScheme) var colorScheme
    @AppStorage("email") var email: String = ""
    @AppStorage("firstName") var firstName: String = ""
    @AppStorage("lastName") var lastName: String = ""
    @AppStorage("userId") var userId: String = ""

    var body: some View {
        NavigationView {
            VStack {
                
                VStack {
                    
                    Circle()
                        .fill(Color.yellow)
                        .frame(height: 200)
                        .overlay(Text("피이이인토오오오").foregroundColor(Color.pink))
                        .padding(.top, 50)
                    Spacer()
                    Text("들어올 땐 마음대로지만 나갈 땐 아니라네")
                   // Text("핀토 로그인")
                   //     .fontWeight(.bold)
                   //     .font(.system(size: 30))
                   //     .foregroundColor(Color.orange)
                   // .padding()
                   // .background(
                   // )


                    SignInWithAppleButton(.continue) { request in
                        request.requestedScopes = [.email, .fullName]
                    } onCompletion: { result in

                        switch result {
                        case .success(let auth):
                            switch auth.credential {
                            case let credential as ASAuthorizationAppleIDCredential:

                                // User Id
                                let userId = credential.user

                                // User Info
                                let email = credential.email
                                let firstName = credential.fullName?.givenName
                                let lastName = credential.fullName?.familyName

                                self.userId = userId
                                self.email = email ?? ""
                                self.firstName = firstName ?? ""
                                self.lastName = lastName ?? ""

                            default:
                                break
                            }

                        case .failure(let error):
                            print(error)
                        }
                    }
                        .signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black)
                        .frame(height: 50)
                        .padding(.horizontal)
                        .cornerRadius(8)

                    Button {

                    } label: {
                        HStack {
                            Image(systemName: "g.circle.fill")
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 28, height: 28)

                            Text("Continue with Google")
                            // .fontWeight(.medium)
                            .font(.title3)
                        }
                            .foregroundColor(Color.green)
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .background(
                            Capsule()
                                .strokeBorder(Color.green)
                        )
                    }
                    .padding([.leading, .bottom, .trailing])
                        // .padding()
                    
                Text(getAttributedString(string: "Studio Machete jerry"))
                }
                    .navigationTitle("핀토 로그인 페이지")
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    
            }
            .background(Color.yellow.opacity(0.1))
                
        }
        
    }


    // 일부 텍스트만 강조
    func getAttributedString(string: String) -> AttributedString {

        var attributedString = AttributedString(string)

        if let range = attributedString.range(of: "jerry") {
            attributedString[range].foregroundColor = .yellow
            attributedString[range].font = .body.bold()
        }
        return attributedString
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
            .preferredColorScheme(.light)
    }
}
