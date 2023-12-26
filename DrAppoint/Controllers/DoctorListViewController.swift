//
//  DoctorListViewController.swift
//  DrAppoint
//
//  Created by Hemant Rajkumar Pancheshwar on 23/12/23.
//

import UIKit
import CoreData

class DoctorListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
   
    
    private let tableView = UITableView()
    private var doctors: [Doctor] = []
    let fetchRequest: NSFetchRequest<Doctor> = NSFetchRequest(entityName: "Doctor")

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.dataSource = self
        tableView.delegate = self
        

        view.addSubview(tableView)
        
        let fetchRequest: NSFetchRequest<Doctor> = Doctor.fetchRequest()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DoctorCell")
        
        // to print and check table data
//        do {
//            let doctors = try CoreDataManager.shared.persistentContainer.viewContext.fetch(fetchRequest)
//            for doctor in doctors {
//                print("Name: \(doctor.name ?? "N/A"), Speciality: \(doctor.speciality ?? "N/A"), Phone: \(doctor.phone ?? "N/A")")
//            }
//        } catch {
//            print("Error fetching doctors: \(error.localizedDescription)")
//        }
        do {
               doctors = try CoreDataManager.shared.persistentContainer.viewContext.fetch(fetchRequest)
               tableView.reloadData()
           } catch {
               print("Error fetching doctors: \(error.localizedDescription)")
           }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTableView()
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
        
        let editDoctorViewController = EditDoctorViewController()
        editDoctorViewController.doctor = selectedDoctor
        editDoctorViewController.onUpdate = { [weak self] in
            self?.updateTableView()
        }
        
        let navigationController = UINavigationController(rootViewController: editDoctorViewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // to delete
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deletedDoctor = doctors.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)

            // Delete from Core Data
            CoreDataManager.shared.persistentContainer.viewContext.delete(deletedDoctor)
            CoreDataManager.shared.saveContext()
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedDoctor = doctors.remove(at: sourceIndexPath.row)
        doctors.insert(movedDoctor, at: destinationIndexPath.row)

        // Reload data to reflect the changes
        tableView.reloadData()
    }

    
    private func updateTableView() {
        DispatchQueue.main.async {
                do {
                    self.doctors = try CoreDataManager.shared.persistentContainer.viewContext.fetch(self.fetchRequest)
                    self.tableView.reloadData()
                } catch {
                    print("Error fetching doctors: \(error.localizedDescription)")
                }
            }
        }
  
    
    @objc private func plusButtonTapped() {
        // Handle the plus button tap event
        let addDoctorViewController = AddDoctorViewController()

        addDoctorViewController.onDoctorAdded = { [weak self] in
               self?.updateTableView()
        }
//        print(navigationController?.viewControllers ?? [])
        let navigationController = UINavigationController(rootViewController: addDoctorViewController)
           navigationController.modalPresentationStyle = .fullScreen
           present(navigationController, animated: true)

    }
    
    @objc private func editButtonTapped() {
        // Handle the plus button tap event
        tableView.setEditing(!tableView.isEditing, animated: true)
        
    }
    

}
