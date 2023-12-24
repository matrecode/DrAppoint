//
//  Doctor.swift
//  DrAppoint
//
//  Created by Hemant Rajkumar Pancheshwar on 24/12/23.
//

import UIKit
import CoreData

class Doctor: NSManagedObject {
    @NSManaged var name: String?
    @NSManaged var speciality : String?
    @NSManaged var phone : String?
}
