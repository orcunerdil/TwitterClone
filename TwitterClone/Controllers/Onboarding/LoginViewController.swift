//
//  LoginViewController.swift
//  TwitterClone
//
//  Created by Orçun Erdil on 22.08.2023.
//

import UIKit
import Combine
class LoginViewController: UIViewController {

    private var viewModel = AuthenticationViewViewModel()
    private var subscription :Set<AnyCancellable> = []
    
    private let loginTitleLabel :UILabel = {
       
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Login to your account"
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        return label
        
    }()
    
    private let emailTextField : UITextField = {
       
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .emailAddress
        textField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        return textField
    }()
    
    private let passwordTextField : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let loginButton : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 25
        button.isEnabled = false
        return button
         
    }()
    
    @objc func didChangeEmailField(){
        viewModel.email = emailTextField.text
        viewModel.validateAuthenticationForm()
    }
    
    @objc func didChangePasswordField(){
        viewModel.password = passwordTextField.text
        viewModel.validateAuthenticationForm()
    }
    
    private func bindViews(){
        emailTextField.addTarget(self, action: #selector(didChangeEmailField), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(didChangePasswordField), for: .editingChanged)
        viewModel.$isAuthenticationValidate.sink { [weak self] validationState in
            self?.loginButton.isEnabled = validationState
        }
        .store(in: &subscription)
        
        viewModel.$user.sink { [weak self] user in
            guard user != nil else {return}
            guard let vc = self?.navigationController?.viewControllers.first as? OnboardingViewController else {return}
            vc.dismiss(animated: true)

        }
        .store(in: &subscription)
        viewModel.$error.sink { [weak self] errorString in
            guard let error = errorString else {return}
            self?.presentAlert(with: error)
        }
        .store(in: &subscription)
    }
    
    private func presentAlert(with error:String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okBtn)
        present(alert, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(loginTitleLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        configureConstraints()
        bindViews()
    }
    
    @objc func didTapLogin(){
        viewModel.loginUser()
    }
    
    private func configureConstraints(){
        
        let loginTitleLabelConstraints = [
            loginTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ]
        
        let emailTextFieldConstraints = [
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.topAnchor.constraint(equalTo: loginTitleLabel.bottomAnchor, constant: 20),
            emailTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 60)
        ]
        
        let passwordTextFieldConstraints = [
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15),
            passwordTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 60)
        
        ]
        
        let  loginButtonConstraints = [
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.widthAnchor.constraint(equalToConstant: 180),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        
        ]
        NSLayoutConstraint.activate(loginTitleLabelConstraints)
        NSLayoutConstraint.activate(emailTextFieldConstraints)
        NSLayoutConstraint.activate(passwordTextFieldConstraints)
        NSLayoutConstraint.activate(loginButtonConstraints)
    }
   

}
