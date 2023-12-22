//
//  DoctorLoginVC.swift
//  DrAppoint
//
//  Created by Hemant Rajkumar Pancheshwar on 21/12/23.
//

import Foundation
import UIKit

class DoctorLoginVC : UIViewController {
    
  
    @IBOutlet weak var SegmentOutlet: UISegmentedControl!
    @IBOutlet weak var registerSegmentView: UIView!
    @IBOutlet weak var loginSegmentView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.bringSubviewToFront(loginSegmentView)
    }
    
    
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0 :
            self.view.bringSubviewToFront(loginSegmentView)
        case 1 :
            self.view.bringSubviewToFront(registerSegmentView)
        default :
            break
        }

    }
    
}
