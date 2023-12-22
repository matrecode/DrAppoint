//
//  AdminLoginVC.swift
//  DrAppoint
//
//  Created by Hemant Rajkumar Pancheshwar on 22/12/23.
//

import Foundation
import UIKit

class AdminLoginVC : UIViewController {
    private let adminLoginView = AdminLoginView()
    
    override func loadView() {
        self.view = adminLoginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func configureNavigationBar(){
        navigationItem.title = "Doctor's Login"
    }
    
    private func setupLoginButton(){
        adminLoginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    @objc private func loginButtonTapped () {
        
    }
}
