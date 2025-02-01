//
//  CoreDataManager.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 31/01/25.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() {}
    
    var context: NSManagedObjectContext {
        return PersistenceController.shared.viewContext
    }

    func saveContext() {
        PersistenceController.shared.saveContext()
    }
}
