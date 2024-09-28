//
//  CoreDataManager.swift
//  Chat App
//
//  Created by Apple on 28/09/24.
//

import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ChatApp")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveMessage(id: Int32, title: String, body: String, userid: Int32) {
        let entity = NSEntityDescription.entity(forEntityName: "MessageEntity", in: context)!
        let message = NSManagedObject(entity: entity, insertInto: context)
        
        message.setValue(id, forKey: "id")
        message.setValue(title, forKey: "title")
        message.setValue(body, forKey: "body")
        message.setValue(userid, forKey: "userid")
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetchMessages() -> [Message] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MessageEntity")
        
        do {
            let fetchedMessages = try context.fetch(fetchRequest)
            return fetchedMessages.map { managedObject in
                return Message(
                    id: managedObject.value(forKey: "id") as! Int,
                    title: managedObject.value(forKey: "title") as! String,
                    body: managedObject.value(forKey: "body") as! String,
                    userId: managedObject.value(forKey: "userid") as! Int
                )
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
}
