import UIKit
import CoreData

class UserDrViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate{

    private let tableView = UITableView()
    private var doctors: [Doctor] = []
    private let pickerView = UIPickerView()
    private var specialities: [String] = []
    let fetchRequest: NSFetchRequest<Doctor> = NSFetchRequest(entityName: "Doctor")
    private var isPickerViewVisible = false
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.dataSource = self
        tableView.delegate = self
        setupUI()

        view.addSubview(tableView)
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        
        fetchUniqueSpecialties()
        
        let fetchRequest: NSFetchRequest<Doctor> = Doctor.fetchRequest()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DoctorCell")
        
        do {
               doctors = try CoreDataManager.shared.persistentContainer.viewContext.fetch(fetchRequest)
               tableView.reloadData()
           } catch {
               print("Error fetching doctors: \(error.localizedDescription)")
           }
       
        fetchAllDoctors()
    }
    
    private func setupUI() {
         // Create plus button
        let filterButton = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterButtonTapped))
//        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))

        navigationItem.rightBarButtonItems = [filterButton]
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
        showDoctorDetails(doctor: selectedDoctor)
    }
    
    private func fetchUniqueSpecialties() {
        let fetchRequest = NSFetchRequest<NSDictionary>(entityName: "Doctor")
        fetchRequest.resultType = .dictionaryResultType
        fetchRequest.propertiesToFetch = ["speciality"]
        fetchRequest.returnsDistinctResults = true

        do {
            if let results = try CoreDataManager.shared.persistentContainer.viewContext.fetch(fetchRequest) as? [NSDictionary] {
                specialities = results.compactMap { $0["speciality"] as? String }
                specialities.insert("All", at: 0)
            }
        } catch {
            print("Error fetching specialities: \(error.localizedDescription)")
        }
    }
    
    private func fetchAllDoctors() {
        let fetchRequest: NSFetchRequest<Doctor> = Doctor.fetchRequest()

        do {
            doctors = try CoreDataManager.shared.persistentContainer.viewContext.fetch(fetchRequest)
            tableView.reloadData()
        } catch {
            print("Error fetching doctors: \(error.localizedDescription)")
        }
    }
    
    private func fetchDoctorsWithSpecialty(_ specialty: String) {
        let fetchRequest: NSFetchRequest<Doctor> = Doctor.fetchRequest()

        if specialty != "All" {
            fetchRequest.predicate = NSPredicate(format: "speciality == %@", specialty)
        }

        do {
            doctors = try CoreDataManager.shared.persistentContainer.viewContext.fetch(fetchRequest)
            tableView.reloadData()
        } catch {
            print("Error fetching doctors with specialty: \(error.localizedDescription)")
        }
    }
    
    private func showDoctorDetails(doctor: Doctor) {
        let doctorDetailsViewController = DoctorDetailsViewController()
        doctorDetailsViewController.doctor = doctor
        navigationController?.pushViewController(doctorDetailsViewController, animated: true)
    }
    
    private func toggleDoneButtonVisibility() {
        if isPickerViewVisible {
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
            navigationItem.rightBarButtonItem = doneButton
        } else {
            let filterButton = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterButtonTapped))
            navigationItem.rightBarButtonItem = filterButton
        }
    }
    
    private func showPickerView() {
        // Add pickerView to the main view
        pickerView.frame = CGRect(x: 0, y: view.frame.height - 216, width: view.frame.width, height: 216) // Adjust the frame as needed
        view.addSubview(pickerView)

        isPickerViewVisible = true
        toggleDoneButtonVisibility()

    }

    @objc func doneButtonTapped() {
        // Handle done button action
        pickerView.removeFromSuperview()

        isPickerViewVisible = false
        toggleDoneButtonVisibility()
    }

    @objc func filterButtonTapped() {
        showPickerView()
    }



    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return specialities.count
    }


    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return specialities[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedSpecialty = specialities[row]
        fetchDoctorsWithSpecialty(selectedSpecialty)
    }
    
    
    
}
    
 



