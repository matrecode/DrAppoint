//
//  AdminLoginView.swift
//  DrAppoint
//
//  Created by Hemant Rajkumar Pancheshwar on 22/12/23.
//

import Foundation
import UIKit

class AdminLoginView : UIView {
    let usernameTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    
    let passwordtextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let loginButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    private func setupUI(){
        backgroundColor = .white
        addSubview(usernameTextField)
        addSubview(passwordtextField)
        addSubview(loginButton)
    }
}
