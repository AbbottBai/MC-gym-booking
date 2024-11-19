//
//  SwiftUIView.swift
//  MC gym booking
//
//  Created by user267421 on 11/18/24.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

struct LoginView: View {
    @StateObject private var auth = Authentication()
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    class Authentication: ObservableObject {
        @Published var signed_in: Bool = false
        
        func email_signup(email: String, password: String, completion: @escaping (Bool, String?) -> Void) {
            Auth.auth().createUser(withEmail: email, password: password) {(result,error) in
                if let error = error {
                    completion(false, "Error: \(error.localizedDescription)")
                } else {
                    self.signed_in = true
                    completion(true,nil)
                }
            }
        }
        
        func email_login(email: String, password: String, completion: @escaping (Bool, String?) -> Void) {
            Auth.auth().signIn(withEmail: email, password: password) {(result, error) in
                if let error = error {
                    completion(false, "error:\(error.localizedDescription)")
                } else {
                    self.signed_in = true
                    completion (true, nil)
                }
            }
        }
        
        func email_logout(completion: @escaping(Bool, String?) -> Void) {
            do{
                try Auth.auth().signOut()
                completion(true, nil)
                self.signed_in = false
            } catch let error {
                completion(false, "Error: \(error.localizedDescription)")
                self.signed_in = true
            }
        }
        
        func check_email_auth(completion: @escaping(Bool, String?) -> Void) {
            if let user = Auth.auth().currentUser {
                completion(true,user.email)
            } else{
                completion(false,nil)
            }
        }
        
        func get_current_email() -> User? {
            return Auth.auth().currentUser
        }
        
    }
    
    var body: some View {
        
        VStack{
            TextField("Enter email", text: $email)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
            
            SecureField("Enter password", text: $password)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Sign up") {
                auth.email_signup(email: self.email, password: self.password) { success, error in
                    if success {
                        print("Signup successful")
                    } else {
                        print("Signup failed due to \(error ?? "Unknown error")")
                    }
                }
            }
        }
            
    }
}



#Preview {
    LoginView()
}
