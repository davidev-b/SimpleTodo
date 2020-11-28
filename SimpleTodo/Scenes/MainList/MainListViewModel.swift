//
//  MainListViewModel.swift
//  SimpleTodo
//
//  Created by David B. on 28.11.20.
//

import SwiftUI

class MainListViewModel : ObservableObject {
    let viewContext = PersistenceController.shared.container.viewContext
    
    @Published var newTaskTitle : String = ""
    
    func addItem() {
        withAnimation {
            let newTask = Task(context: viewContext)
            newTask.title = newTaskTitle
            newTask.createdAt = Date()
            newTask.isDone = false
            newTask.details = ""

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
        
        //Reset TextField String
        self.newTaskTitle = ""
    }
}
