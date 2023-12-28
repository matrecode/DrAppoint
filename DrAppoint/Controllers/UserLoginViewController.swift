

import Foundation
import UIKit

class UserLoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        setupUI()
        updateUIForCurrentState()
       
    }
    
    private enum ViewState {
        case register
        case login
    }

    private var currentState: ViewState = .register {
        didSet {
            updateUIForCurrentState()
        }
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

    private let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.addTarget(self, action: #selector(userCancelButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private func setupUI() {
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(actionButton)
        view.addSubview(cancelButton)

        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            usernameTextField.widthAnchor.constraint(equalToConstant: 200),

            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            passwordTextField.widthAnchor.constraint(equalToConstant: 200),

            actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),

            cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cancelButton.topAnchor.constraint(equalTo: actionButton.bottomAnchor, constant: 20),
        ])
    }
    
//    @objc private func userLoginButtonTapped() {
//        // Dummy login logic for demonstration purposes
//        let dummyUsername = "Admin"
//        let dummyPassword = "Admin123"
//
//        guard let enteredUsername = usernameTextField.text, let enteredPassword = passwordTextField.text else {
//            return
//        }
//
//        if enteredUsername == dummyUsername && enteredPassword == dummyPassword {
//            // Successfully logged in, navigate to the new screen (replace it with your screen)
//            let userDrListVC = UserDrViewController()
//            userDrListVC.view.backgroundColor = .green
//            navigationController?.pushViewController(userDrListVC, animated: true)
//        } else {
//            // Show an alert or handle login failure
//            showAlert(message: "Invalid credentials")
//           
//        }
//    }
    
    private func updateUIForCurrentState() {
        switch currentState {
        case .register:
            actionButton.setTitle("Register", for: .normal)
        case .login:
            actionButton.setTitle("Login", for: .normal)
        }
    }

    @objc private func actionButtonTapped() {
        guard let enteredUsername = usernameTextField.text,
              let enteredPassword = passwordTextField.text else {
            return
        }

        switch currentState {
        case .register:
            CoreDataManager.shared.registerUser(username: enteredUsername, password: enteredPassword)
            showAlert(message: "User registered successfully")
            currentState = .login
        case .login:
            if CoreDataManager.shared.authenticateUser(username: enteredUsername, password: enteredPassword) {
                // Successfully logged in, navigate to the new screen (replace it with your screen)
                let userDrListVC = UserDrViewController()
                userDrListVC.view.backgroundColor = .green
                navigationController?.pushViewController(userDrListVC, animated: true)
            } else {
                showAlert(message: "Invalid credentials")
            }
        }
    }

    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func userCancelButtonTapped(){
        dismiss(animated: true, completion: nil)
    }


}
