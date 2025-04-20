//
//  DateHolder.swift
//  CoreDataToDoList
//
//  Created by Marcelle Ribeiro Queiroz on 20/04/25.
//

import CoreData
import SwiftUI

// Classe que conforma com ObservableObject para permitir atualizações de UI no SwiftUI
class DateHolder: ObservableObject {
    
    @Published var date: Date = Date()
    @Published var taskItems: [TaskItem] = []
    
    let calendar: Calendar = Calendar.current
    
    // Avança/retrocede a data atual pelo número de dias especificado
    func moveDate(_ days: Int, _ context: NSManagedObjectContext) {
        date = calendar.date(byAdding: .day, value: days, to: date)!
        refreshTaskItems(context)
    }
    // Ao inicializar, já carrega as tarefas da data atual
    init(_ context: NSManagedObjectContext) {
        refreshTaskItems(context)
    }
    // atualiza a lista de tarefas buscando do CoreData
    func refreshTaskItems(_ context: NSManagedObjectContext) {
        taskItems = fetchTaskItems(context)
    }
    // Busca tarefas no CoreData usando um fetch request personalizado
    func fetchTaskItems(_ context: NSManagedObjectContext) -> [TaskItem] {
        do {
            return try context.fetch(dailyTasksFetch()) as [TaskItem]
        }
        catch let error {
            fatalError("Unresolved error \(error)")
        }
    }
    // Combina critérios de ordenação e predicado para filtrar por data
    func dailyTasksFetch() -> NSFetchRequest<TaskItem> {
        let request = TaskItem.fetchRequest()
        
        request.sortDescriptors = sortOrder()
        request.predicate = predicate()
        return request
    }
    // Ordena tarefas por: data de conclusão, horário agendado e data de vencimento
    private func sortOrder() -> [NSSortDescriptor] {
        let completedDateSort = NSSortDescriptor(keyPath: \TaskItem.completedDate, ascending: true)
        let timeSort = NSSortDescriptor(keyPath: \TaskItem.scheduleTime, ascending: true)
        let dueDateSort = NSSortDescriptor(keyPath: \TaskItem.dueDate, ascending: true)
        
        return [completedDateSort, timeSort, dueDateSort]
    }
    // Filtra tarefas para mostrar apenas as do dia atual (das 00:00 até 23:59)
    private func predicate() -> NSPredicate {
        let start = calendar.startOfDay(for: date)
        let end = calendar.date(byAdding: .day, value: 1, to: start)
        return NSPredicate(format: "dueDate >= %@ AND dueDate < %@", start as NSDate, end! as NSDate)
    }
    // Salva as mudanças no contexto do CoreData
    func saveContext(_ context: NSManagedObjectContext) {
        do {
            try context.save()
            refreshTaskItems(context)
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
