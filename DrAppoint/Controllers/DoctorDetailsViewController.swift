import UIKit

class DoctorDetailsViewController: UIViewController {

    var doctor: Doctor?

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let specialityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupUI()
        displayDoctorDetails()
    }

    private func setupUI() {
        view.addSubview(nameLabel)
        view.addSubview(specialityLabel)
        view.addSubview(numberLabel)

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            specialityLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            specialityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            numberLabel.topAnchor.constraint(equalTo: specialityLabel.bottomAnchor, constant: 8),
            numberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        ])
    }

    private func displayDoctorDetails() {
        guard let doctor = doctor else {
            return
        }

        nameLabel.text = "Name: \(doctor.name ?? "N/A")"
        specialityLabel.text = "Speciality: \(doctor.speciality ?? "N/A")"
        numberLabel.text = "Number: \(doctor.phone ?? "N/A")"

 
    }
}
