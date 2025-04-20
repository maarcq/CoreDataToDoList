//
//  TaskItemExtension.swift
//  CoreDataToDoList
//
//  Created by Marcelle Ribeiro Queiroz on 20/04/25.
//

import SwiftUI

extension TaskItem {
    // Verifica se a tarefa está marcada como concluída
    func isCompleted() -> Bool {
        return completedDate != nil
    }
    // Verifica se a tarefa está atrasada com 3 condições:
    func isOverdue() -> Bool {
        if let due = dueDate {
            // A tarefa não está concluída (!isCompleted())
            // A tarefa tem horário agendado (scheduleTime é true)
            // A data de vencimento (dueDate) é anterior à data atual (due < Date())
            return !isCompleted() && scheduleTime && due < Date()
        }
        return false
    }
    // Retorna a cor vermelha (Color.red) se a tarefa estiver atrasada
    func overDueColor() -> Color {
        return isOverdue() ? .red : .black
    }
    // Formata a data de vencimento para mostrar apenas o horário
    func dueDateTimeOnly() -> String {
        if let due = dueDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            return dateFormatter.string(from: due)
        }
        
        return ""
    }
}
