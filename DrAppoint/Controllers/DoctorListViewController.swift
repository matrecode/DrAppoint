//
//  DoctorListViewController.swift
//  DrAppoint
//
//  Created by Hemant Rajkumar Pancheshwar on 23/12/23.
//

import UIKit
import CoreData

class DoctorListViewController: UIViewController{
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        let fetchRequest: NSFetchRequest<Doctor> = Doctor.fetchRequest()

        do {
            let doctors = try CoreDataManager.shared.persistentContainer.viewContext.fetch(fetchRequest)
            for doctor in doctors {
                print("Name: \(doctor.name ?? "N/A"), Speciality: \(doctor.speciality ?? "N/A"), Phone: \(doctor.phone ?? "N/A")")
            }
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
    

    
    
    @objc private func plusButtonTapped() {
        // Handle the plus button tap event
        let addDoctorViewController = AddDoctorViewController()
//        addDoctorViewController.view.backgroundColor = .gray
        let navigationController = UINavigationController(rootViewController: addDoctorViewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
//        print("Plus button tapped")
    }
    
    @objc private func editButtonTapped() {
        // Handle the plus button tap event
//        print("Edit button tapped")
    }
    

}
