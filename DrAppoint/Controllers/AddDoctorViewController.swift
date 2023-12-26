//  AddDoctorViewController.swift
//  DrAppoint
//
//  Created by Hemant Rajkumar Pancheshwar on 24/12/23.
//

import UIKit
import CoreData

class AddDoctorViewController: UIViewController {
    var persistentContainer: NSPersistentContainer?
    var onDoctorAdded: (() -> Void)?


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupNavigationBarButtons()
    }
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let specialityTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Speciality"
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Phone Number"
        textField.keyboardType = .phonePad
        textField.borderStyle = .roundedRect
        return textField
    }()

 


    private func setupUI() {
        view.addSubview(nameTextField)
        view.addSubview(specialityTextField)
        view.addSubview(phoneNumberTextField)
    

        // Add your constraints here...
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        specialityTextField.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberTextField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // Name Text Field
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.bounds.width * 0.1),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.bounds.width * 0.1),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),

            // Speciality Text Field
            specialityTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            specialityTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.bounds.width * 0.1),
            specialityTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.bounds.width * 0.1),
            specialityTextField.heightAnchor.constraint(equalToConstant: 40),

            // Phone Number Text Field
            phoneNumberTextField.topAnchor.constraint(equalTo: specialityTextField.bottomAnchor, constant: 20),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.bounds.width * 0.1),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.bounds.width * 0.1),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        

    }
    
    private func setupNavigationBarButtons() {
        // Save Button on the right side of the navigation bar
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveButton

        // Cancel Button on the left side of the navigation bar
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
        navigationItem.leftBarButtonItem = cancelButton
    }
    
   
    
    
    @objc private func saveButtonTapped() {
        guard let name = nameTextField.text,
              let speciality = specialityTextField.text,
              let phone = phoneNumberTextField.text else {
            return
        }

        let newDoctor = Doctor(context: CoreDataManager.shared.persistentContainer.viewContext)
        newDoctor.name = name
        newDoctor.speciality = speciality
        newDoctor.phone = phone
        
        CoreDataManager.shared.saveContext()
        onDoctorAdded?()
        
        dismiss(animated: true, completion: nil)
    }

    @objc private func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
