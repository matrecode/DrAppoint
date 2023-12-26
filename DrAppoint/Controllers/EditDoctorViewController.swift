import UIKit
import CoreData

class EditDoctorViewController: UIViewController {
    
    var doctor: Doctor?
    var onUpdate: (() -> Void)?
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var specialityTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Speciality"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var phoneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Phone"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var updateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Update", for: .normal)
        button.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        populateFields()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "Edit Doctor"
        
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(nameTextField)
        view.addSubview(specialityTextField)
        view.addSubview(phoneTextField)
        view.addSubview(updateButton)
    }
    
    private func setupConstraints() {
        let margin: CGFloat = 20.0
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        specialityTextField.translatesAutoresizingMaskIntoConstraints = false
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        updateButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: margin),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            
            specialityTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: margin),
            specialityTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            specialityTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            
            phoneTextField.topAnchor.constraint(equalTo: specialityTextField.bottomAnchor, constant: margin),
            phoneTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            phoneTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            
            updateButton.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: margin),
            updateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func populateFields() {
        guard let doctor = doctor else { return }
        nameTextField.text = doctor.name
        specialityTextField.text = doctor.speciality
        phoneTextField.text = doctor.phone
    }
    
    @objc private func updateButtonTapped() {
        guard let doctor = doctor,
                  let name = nameTextField.text,
                  let speciality = specialityTextField.text,
                  let phone = phoneTextField.text else {
                return
            }

            // Clear existing data
            nameTextField.text = nil
            specialityTextField.text = nil
            phoneTextField.text = nil

            // Update the doctor object with the new data
            doctor.name = name
            doctor.speciality = speciality
            doctor.phone = phone

            do {
                try CoreDataManager.shared.persistentContainer.viewContext.save()
                onUpdate?()

                // Populate fields with updated data
                populateFields()
                dismiss(animated: true, completion: nil)

                // Display an alert or perform any other action to indicate successful update
            } catch {
                print("Error updating doctor: \(error.localizedDescription)")
            }

        
      
    }
}
