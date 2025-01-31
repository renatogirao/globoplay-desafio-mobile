//
//  Persistence.swift
//  globoplay-desafio-mobile
//
//  Created by Renato Girão on 28/01/25.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    private init() {
        container = NSPersistentContainer(name: "globoplay_desafio_mobile")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Erro ao carregar Core Data: \(error), \(error.userInfo)")
            }
        }
    }

    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }

    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Erro ao salvar contexto: \(error.localizedDescription)")
            }
        }
    }
}
