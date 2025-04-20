//
//  TaskFilter.swift
//  CoreDataToDoList
//
//  Created by Marcelle Ribeiro Queiroz on 20/04/25.
//

import SwiftUI

enum TaskFilter: String {
    
    static var allFilters: [TaskFilter] {
        return [.NonCompleted,.Completed,.OverDue,.All]
    }
    
    case All = "All"
    case NonCompleted = "To Do"
    case Completed = "Completed"
    case OverDue = "Overdue"
}
