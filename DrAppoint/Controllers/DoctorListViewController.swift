//
//  DoctorListViewController.swift
//  DrAppoint
//
//  Created by Hemant Rajkumar Pancheshwar on 23/12/23.
//

import UIKit

class DoctorListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    

    private func setupUI() {
         // Create plus button
         let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonTapped))
         navigationItem.rightBarButtonItem = plusButton
     }
    
    @objc private func plusButtonTapped() {
        // Handle the plus button tap event
        print("Plus button tapped")
    }
    
    

}
