//
//  Persistence.swift
//  CoreDataToDoList
//
//  Created by Marcelle Ribeiro Queiroz on 20/04/25.
//

import CoreData

// gerencia a pilha do CoreData
struct PersistenceController {
    // Cria uma instância singleton (única e compartilhada) do PersistenceController para ser usada em toda a aplicação.
    static let shared = PersistenceController()
    
    static var preview: PersistenceController = {
        
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    // Armazena o NSPersistentContainer que é o coração da pilha do Core Data, gerenciando:
    // Modelo de dados, Contexto de objeto (NSManagedObjectContext), Loja persistente (banco de dados SQLite, normalmente)
    let container: NSPersistentContainer
    
    // Cria um container com o nome do modelo de dados ("CoreDataToDoList.xcdatamodeld")
    // O parâmetro inMemory determina se os dados serão armazenados em memória ou em disco
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "CoreDataToDoList")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
