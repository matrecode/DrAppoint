import UIKit

class ConfirmationViewController: UIViewController {

    var doctor: Doctor?
    var appointmentDate: Date?
    var patientName: String?
    var patientEmail: String?
    
    private let confirmationLabel: UILabel = {
        let label = UILabel()
        label.text = "Appointment Confirmed"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let detailsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let goToHomeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Go to Home", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(goToHomeButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupUI()
        displayConfirmationDetails()
    }

    private func setupUI() {
        view.addSubview(confirmationLabel)
        view.addSubview(detailsLabel)
        view.addSubview(goToHomeButton)

        NSLayoutConstraint.activate([
            confirmationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            confirmationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            detailsLabel.topAnchor.constraint(equalTo: confirmationLabel.bottomAnchor, constant: 16),
            detailsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            detailsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            goToHomeButton.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 16),
            goToHomeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

    private func displayConfirmationDetails() {
        guard let doctor = doctor, let appointmentDate = appointmentDate, let patientName = patientName, let patientEmail = patientEmail else {
            return
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short

        let formattedDate = dateFormatter.string(from: appointmentDate)

        let confirmationText = """
        Doctor: \(doctor.name ?? "N/A")
        Appointment Date: \(formattedDate)
        Patient Name: \(patientName)
        Patient Email: \(patientEmail)
        """

        detailsLabel.text = confirmationText
    }

    @objc private func goToHomeButtonTapped() {
        if let userDrViewController = navigationController?.viewControllers.first(where: { $0 is UserDrViewController }) {
            navigationController?.popToViewController(userDrViewController, animated: true)
        }
    }
}
