

import UIKit
import CoreData

class UserDrViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

    private let tableView = UITableView()
    private var doctors: [Doctor] = []
    let fetchRequest: NSFetchRequest<Doctor> = NSFetchRequest(entityName: "Doctor")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.dataSource = self
        tableView.delegate = self
        setupUI()

        view.addSubview(tableView)

        
        
        let fetchRequest: NSFetchRequest<Doctor> = Doctor.fetchRequest()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DoctorCell")
        
        do {
               doctors = try CoreDataManager.shared.persistentContainer.viewContext.fetch(fetchRequest)
               tableView.reloadData()
           } catch {
               print("Error fetching doctors: \(error.localizedDescription)")
           }

    }
    
    private func setupUI() {
         // Create plus button
         let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonTapped))
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTapped))

        navigationItem.rightBarButtonItems = [plusButton, editButton]
     }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doctors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorCell", for: indexPath)
        
        let doctor = doctors[indexPath.row]
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        // Configure the cell with doctor data
        let nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        nameLabel.text = doctor.name ?? "N/A"
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(nameLabel)
        
        let specialityLabel = UILabel()
        specialityLabel.font = UIFont.systemFont(ofSize: 14)
        specialityLabel.textColor = UIColor.gray
        specialityLabel.text = doctor.speciality ?? "N/A"
        specialityLabel.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(specialityLabel)
        
        let phoneNumberLabel = UILabel()
        phoneNumberLabel.font = UIFont.systemFont(ofSize: 14)
        phoneNumberLabel.textColor = UIColor.gray
        phoneNumberLabel.text = doctor.phone ?? "N/A"
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(phoneNumberLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 16),
            
            specialityLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            specialityLabel.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 16),
            
            phoneNumberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            phoneNumberLabel.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16),
        ])
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedDoctor = doctors[indexPath.row]
        showDoctorDetails(doctor: selectedDoctor)
    }
    
    private func showDoctorDetails(doctor: Doctor) {
        let doctorDetailsViewController = DoctorDetailsViewController()
        doctorDetailsViewController.doctor = doctor
        navigationController?.pushViewController(doctorDetailsViewController, animated: true)
    }
    
    
    @objc func plusButtonTapped(){
        
    }
    
    @objc func editButtonTapped(){
        
    }
    }
    
 


