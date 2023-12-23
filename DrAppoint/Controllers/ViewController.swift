//
//  ViewController.swift
//  DrAppoint
//
//  Created by Hemant Rajkumar Pancheshwar on 23/12/23.
//
import UIKit

import Foundation

class ViewController : UIViewController {
    
    
    override func loadView() {
        super.loadView()
    }
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureDoctorButton()
        configureUserButton()
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureDoctorButton(){
        // Create "Doctor" button
        let doctorButton = UIButton(type: .system)
        doctorButton.setTitle("Doctor", for: .normal)
        doctorButton.frame = CGRect(x: 50, y: 100, width: 200, height: 40)
        doctorButton.addTarget(self, action: #selector(doctorButtonTapped), for: .touchUpInside)
        self.view.addSubview(doctorButton)
    }
    
    func configureUserButton(){
        let userButton = UIButton(type:.system)
        userButton.setTitle("User", for: .normal)
        userButton.frame = CGRect(x: 50, y: 160, width: 200, height: 40)
        userButton.addTarget(self, action: #selector(userButtonTapped), for: .touchUpInside)
        self.view.addSubview(userButton)
    }
    
    
    @objc func doctorButtonTapped() {
        let doctorLoginVC = DoctorLoginViewController()
        let navigationController = UINavigationController(rootViewController: doctorLoginVC)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
        
      
        print(#function)
    }

    @objc func userButtonTapped() {
        let userLoginVC = UserLoginViewController()
        present(userLoginVC, animated: true)
        print(#function)
    }

    
}
