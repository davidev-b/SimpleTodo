//
//  TaskDetailView.swift
//  SimpleTodo
//
//  Created by David B. on 28.11.20.
//

import SwiftUI

struct TaskDetailView: View {
    
    @ObservedObject var task : Task
    
    @State var number : Int = 0
    
    @State var date : Date = Date()
    
    @State var selectedPriority = 0
    
    var body: some View {
        List() {
            Section {
                TextField("Title", text: $task.title,
                 onCommit: {print("New task title entered.")})

                TextField("Notes", text: $task.details,
                 onCommit: {print("New task title entered.")})
            }
            
            Section {
                HStack {
                    Image(systemName: "calendar.badge.plus")
                        .renderingMode(.template)
                        .foregroundColor(Color.blue)
                    
                    DatePicker("Date", selection: $date, displayedComponents: [.date])
                }
            }
            
            Section {
                NavigationLink(destination: Text("Priority")) {
                    Text("Priority")
                    Spacer()
                    Text("Low")
                        .foregroundColor(.gray)
                }
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .listStyle(GroupedListStyle())
        .toolbar {
            EditButton()
        }
    }
}

//struct TaskDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskDetailView()
//    }
//}
