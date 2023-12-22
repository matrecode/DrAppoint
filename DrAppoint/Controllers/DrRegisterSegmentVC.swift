//
//  registerSegmentVC.swift
//  DrAppoint
//
//  Created by Hemant Rajkumar Pancheshwar on 22/12/23.
//

import Foundation
import UIKit

class DrRegisterSegmentVC : UIViewController {
    
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        emailField.addBottomBorderWithColour(color: UIColor.lightGray, width: 0.5)
        passwordField.addBottomBorderWithColour(color: UIColor.lightGray, width: 0.5)
        
        emailField.addPaddingToTextField()
        passwordField.addPaddingToTextField()
    }
}

