import UIKit

class AppointmentDetailsViewController: UIViewController {

    var doctor: Doctor?
    
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .dateAndTime
        picker.minimumDate = Date()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
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
        view.addSubview(datePicker)
        view.addSubview(confirmButton)

        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            confirmButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 16),
            confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

    @objc private func confirmButtonTapped() {

        let patientDetailsVC = PatientDetailsViewController()
        patientDetailsVC.doctor = doctor
        patientDetailsVC.appointmentDate = datePicker.date
        navigationController?.pushViewController(patientDetailsVC, animated: true)
    }
}
