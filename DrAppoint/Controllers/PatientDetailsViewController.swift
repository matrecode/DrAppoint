import UIKit

class PatientDetailsViewController: UIViewController {

    var doctor: Doctor?
    var appointmentDate: Date?
    
    private let nameLabel: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Name"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let emailLabel: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Email"
        textField.keyboardType = .emailAddress
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Confirm Appointment", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupUI()
    }

    private func setupUI() {
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        view.addSubview(confirmButton)

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            confirmButton.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 16),
            confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

    @objc private func confirmButtonTapped() {
        // Handle confirmation or submission logic
        // You can save the patient details, appointment details, etc., and show a confirmation screen or navigate to a success screen.
        showConfirmationScreen()
    }
    
    private func showConfirmationScreen() {
        let confirmationVC = ConfirmationViewController()
        confirmationVC.doctor = doctor
        confirmationVC.appointmentDate = appointmentDate
        confirmationVC.patientName = nameLabel.text
        confirmationVC.patientEmail = emailLabel.text
        navigationController?.pushViewController(confirmationVC, animated: true)
    }
}
