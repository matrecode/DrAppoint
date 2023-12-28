import Foundation
import UIKit
import CoreData

class UserLoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        setupUI()
        updateUIForCurrentState()
    }
    
    private enum ViewState: Int {
        case register = 0
        case login = 1
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
    
    private let segmentedControl: UISegmentedControl = {
        let items = ["Register", "Login"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        return segmentedControl
    }()
    
    private func setupUI() {
        view.addSubview(segmentedControl)
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(actionButton)
        view.addSubview(cancelButton)

        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
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
    
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        currentState = ViewState(rawValue: sender.selectedSegmentIndex) ?? .register
    }
    
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
            registerUser(username: enteredUsername, password: enteredPassword)
            showAlert(message: "User registered successfully")
           
        case .login:
            if authenticateUser(username: enteredUsername, password: enteredPassword) {
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
    
    @objc private func userCancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }


    private func registerUser(username: String, password: String) {
       
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let newUser = UsersModel(context: context)
        newUser.username = username
        newUser.password = password

        do {
            try context.save()
        } catch {
            print("Error saving user: \(error)")
        }
    }

    private func authenticateUser(username: String, password: String) -> Bool {
        // Replace with your CoreData logic to authenticate user
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let request = NSFetchRequest<UsersModel>(entityName: "UsersModel")
        request.predicate = NSPredicate(format: "username == %@ AND password == %@", username, password)

        do {
            let users = try context.fetch(request)
            return !users.isEmpty
        } catch {
            print("Error fetching user: \(error)")
            return false
        }
    }
}

