//
//  CoreDataToDoListApp.swift
//  CoreDataToDoList
//
//  Created by Marcelle Ribeiro Queiroz on 20/04/25.
//

import SwiftUI

@main
struct CoreDataToDoListApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            
//            let context = persistenceController.container.viewContext
//            let dateHolder = DateHolder(context)
            
            TaskListView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//                .environmentObject(dateHolder)
        }
    }
}
