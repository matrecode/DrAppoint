
import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "doctors")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy

        // Add this for background context
        container.newBackgroundContext()

        return container
    }()

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchUniqueSpecialities() -> [String]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Doctor")
        request.returnsObjectsAsFaults = false
        request.propertiesToFetch = ["speciality"]
        request.resultType = .dictionaryResultType

        do {
            if let results = try persistentContainer.viewContext.fetch(request) as? [[String: String]] {
                let uniqueSpecialities = Set(results.compactMap { $0["speciality"] })
                return Array(uniqueSpecialities)
            }
        } catch {
            print("Error fetching unique specialities: \(error.localizedDescription)")
        }

        return nil
    }
}
