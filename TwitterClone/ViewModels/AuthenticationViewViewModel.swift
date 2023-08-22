//
//  RegisterViewViewModel.swift
//  TwitterClone
//
//  Created by Orçun Erdil on 21.08.2023.
//

import Foundation
import Firebase
import Combine

//Final olarak işaretlemek oradan miras alınamayacağı anlamına gelir.
final class AuthenticationViewViewModel : ObservableObject {
    
    @Published var email:String?
    @Published var password:String?
    @Published var isAuthenticationValidate :Bool = false
    @Published var user: User?
    @Published var error: String?
    
    private var subscription :Set<AnyCancellable> = []
    
    func validateAuthenticationForm(){
        
        guard let email = email, let password = password else {
            isAuthenticationValidate = false
            return
        }
        
        isAuthenticationValidate = isValidEmail(email) && password.count >= 8
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func createUser() {
        guard let email = email,let password = password else {return}
        AuthManager.shared.registerUser(with: email, password: password)
            .handleEvents(receiveOutput: { [weak self] user in
                self?.user = user
            })
            .sink { [weak self] completion in
            
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
                
            } receiveValue: { [weak self] user in
                self?.createdRecord(for: user)
            }
            .store(in: &subscription)

    }
    
    func createdRecord(for user: User) {
        DatabaseManager.shared.collectionUser(add: user)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { state in
                print("Adding user record to db \(state)")
            }
            .store(in: &subscription)
    }
    
    
    func loginUser() {
        guard let email = email,let password = password else {return}
        AuthManager.shared.loginUser(with: email, password: password)
            .sink { [weak self] completion in
                
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] user in
                self?.user = user
            }
            .store(in: &subscription)

    }
}
