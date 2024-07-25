import UIKit
import CoreData

class CoreDataPersistenceManager<T: NSManagedObject> {

    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext) {
        self.context = context
    }
    
    func saveObject(properties: [String: Any]) throws {
        let entityName = String(describing: T.self)
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)!
        let object = T(entity: entity, insertInto: context)
        
        for (key, value) in properties {
            object.setValue(value, forKey: key)
        }
        
        try context.save()
    }
    
    func getObjectList() -> [T] {
        let entityName = String(describing: T.self)
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        
        do {
            let objects = try context.fetch(fetchRequest)
            return objects
        } catch {
            print("Failed to fetch objects: \(error)")
            return []
        }
    }
    
    func deleteObject(object: T) throws {
        context.delete(object)
        try context.save()
    }
    
    func updateObject(object: T, with properties: [String: Any]) throws {
        for (key, value) in properties {
            object.setValue(value, forKey: key)
        }
        
        try context.save()
    }
}

