//
//  FieldExtension.swift
//  DrAppoint
//
//  Created by Hemant Rajkumar Pancheshwar on 22/12/23.
//

import Foundation
import UIKit

extension UIView {
    func addBottomBorderWithColour(color : UIColor, width : CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x:0, y: self.frame.size.height - width,
                              width: self.frame.size.width - 25, height: width)
        self.layer.addSublayer(border)
        
    }
}

extension UITextField{
    func addPaddingToTextField() {
        let paddingView : UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        self.leftView = paddingView
        self.leftViewMode = .always
        self.rightView = paddingView
        self.rightViewMode = .always
        
    }
}
