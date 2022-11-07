//
//  DatabaseHandler.swift
//  Pokemon
//
//  Created by Consultant on 6/24/22.
//

import UIKit
import CoreData

class DatabaseHandler {
    private let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func add<T: NSManagedObject>(_ type: T.Type)-> T? {
        guard let entityName = T.entity().name else { return nil }
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: viewContext) else { return nil }
        let object = T(entity: entity, insertInto: viewContext)
        
        return object
    }
    
    func fetch<T:NSManagedObject>(_ type:T.Type)-> [T] {
        let request = T.fetchRequest()
        do {
            let result = try viewContext.fetch(request)
            return result as! [T]
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func delete<T: NSManagedObject>(_ object: T) {
        viewContext.delete(object)
        save()
    }
    
//        func find<T: NSManagedObject>(_ type:T.Type, name: String)->[T]{
//            let request = T.fetchRequest()
//            do {
//                request.predicate = NSPredicate(format: "name = %@", name)
//                let result = try viewContext.fetch(request)
//                return result as! [T]
//            } catch {
//                print(error.localizedDescription)
//                return []
//            }
//        }
}
