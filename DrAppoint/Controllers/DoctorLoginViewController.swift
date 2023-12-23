//
//  DoctorLoginViewController.swift
//  DrAppoint
//
//  Created by Hemant Rajkumar Pancheshwar on 23/12/23.
//

import Foundation
import UIKit

class DoctorLoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        setupUI()
       
    }
    
    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()

  

    private func setupUI() {
        // Add and layout UI elements
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)

        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            usernameTextField.widthAnchor.constraint(equalToConstant: 200),

            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            passwordTextField.widthAnchor.constraint(equalToConstant: 200),

            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
        ])
    }
    
    @objc private func loginButtonTapped() {
            // Dummy login logic for demonstration purposes
            let dummyUsername = "Admin"
            let dummyPassword = "Admin123"

            guard let enteredUsername = usernameTextField.text, let enteredPassword = passwordTextField.text else {
                return
            }

            if enteredUsername == dummyUsername && enteredPassword == dummyPassword {
                // Successfully logged in, navigate to the new screen (replace it with your screen)
                let doctorListViewController = DoctorListViewController()
                doctorListViewController.view.backgroundColor = .green
                navigationController?.pushViewController(doctorListViewController, animated: true)
            } else {
                // Show an alert or handle login failure
                showAlert(message: "Invalid credentials")
               
            }
        }

        private func showAlert(message: String) {
            let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    
    



}
