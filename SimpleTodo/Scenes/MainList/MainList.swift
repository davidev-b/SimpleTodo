//
//  MainList.swift
//  SimpleTodo
//
//  Created by David B. on 28.11.20.
//

import SwiftUI

struct MainList: View {
    @Environment(\.managedObjectContext) var
     managedObjectContext
    
    @ObservedObject var viewModel = MainListViewModel()
    
    struct Layout {
        static let cellRowHeight: CGFloat = 50
    }
    
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.createdAt, ascending: false)]) var taskItems : FetchedResults<Task>

    @State var newTaskTitle : String = ""

    var sampleTasks = ["Task One" , "Task Two", "Task Three"]
    
    var body: some View {
        NavigationView {
            List() {
                if (!taskItems.isEmpty)
                {
                    Section {
                        ForEach(taskItems, id:\.self) { task in
                            NavigationLink(destination: TaskDetailView(task: task))
                            {
                                HStack {
                                    Text(task.title ?? "")
                                    Spacer()
                                    Button(action: {
                                        //action
                                    })
                                    {
                                        Image(systemName: "circle")
                                            .imageScale(.large)
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                        }
                        .onDelete(perform: deleteTask)
                        .frame(height: Layout.cellRowHeight)
                    }
                }

                Section {
                    HStack {
                        TextField("Add task...", text: $viewModel.newTaskTitle,
                         onCommit: {print("New task title entered.")})
                        
                        Button(action: {
                            viewModel.addItem()
                        })
                        {
                            Image(systemName: "plus")
                        }
                    }.frame(height: Layout.cellRowHeight)
                }
            }.listStyle(GroupedListStyle())
            .navigationBarTitle("Simple Todo", displayMode: .large)
            .toolbar {
                EditButton()
            }
        }
    }
    
    private func deleteTask(at offsets: IndexSet) {
        withAnimation {
            offsets.map { taskItems[$0] }.forEach(managedObjectContext.delete)

            do {
                try managedObjectContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct MainList_Previews: PreviewProvider {
    static var previews: some View {
        MainList()
    }
}
