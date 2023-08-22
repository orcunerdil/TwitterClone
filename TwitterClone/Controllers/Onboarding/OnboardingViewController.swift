//
//  OnboardingViewController.swift
//  TwitterClone
//
//  Created by Orçun Erdil on 17.08.2023.
//

import UIKit

class OnboardingViewController: UIViewController {

    
    private let welcomeLabel : UILabel = {
       
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "See what's happening in the world right now"
        label.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .label
        return label
        
    }()
    
    private let accountCreateButton : UIButton = {
       
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Create Account", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        button.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
        button.layer.masksToBounds = true
        button.tintColor = .white
        button.layer.cornerRadius = 30
        return button
        
    }()
    
    private let promptLabel : UILabel = {
        
       let label = UILabel()
       label.translatesAutoresizingMaskIntoConstraints = false
       label.tintColor = .gray
       label.text = "Have an account already ?"

       label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
       return label
    }()
    
    private let loginButton : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.tintColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        view.backgroundColor = .systemBackground
        view.addSubview(welcomeLabel)
        view.addSubview(accountCreateButton)
        view.addSubview(promptLabel)
        view.addSubview(loginButton)
        
        accountCreateButton.addTarget(self, action: #selector(didTapCreateBtn), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(didTapLoginBtn), for: .touchUpInside)
        
        configureConstraints()
    }
    
    @objc func didTapLoginBtn(){
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func didTapCreateBtn(){
        
        let vc = RegisterViewController()
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    private func configureConstraints(){
        
        let welcomeLabelConstraints = [
        
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            
        ]
        
        let accountCreateButtonConstraints = [
            
            accountCreateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            accountCreateButton.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 20),
            accountCreateButton.widthAnchor.constraint(equalTo: welcomeLabel.widthAnchor, constant: -20),
            accountCreateButton.heightAnchor.constraint(equalToConstant: 60)
          
        ]
        
        let promptLabelConstraints = [
            promptLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            promptLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60)
        ]
        
        let loginButtonConstraints = [
            loginButton.leadingAnchor.constraint(equalTo: promptLabel.trailingAnchor, constant: 10),
            loginButton.centerYAnchor.constraint(equalTo: promptLabel.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(welcomeLabelConstraints)
        NSLayoutConstraint.activate(accountCreateButtonConstraints)
        NSLayoutConstraint.activate(promptLabelConstraints)
        NSLayoutConstraint.activate(loginButtonConstraints)
    }

    
    
}
