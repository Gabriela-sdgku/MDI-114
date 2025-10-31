//
//  TodoListView.swift
//  Class 1_4
//
//  Created by Gabriela Sanchez on 30/10/25.
//

import SwiftUI
import SwiftData

struct TodoListView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var group: TodoGroup
    
    @State private var newTaskTitle = ""
    @FocusState private var isTaskFieldFocused: Bool
    
    var body: some View {
        List {
            Section {
                HStack(spacing: 12) {
                    Image(systemName: "circle")
                        .font(.title2)
                        .foregroundStyle(.gray)
                    
                    TextField("NewTaskDescription", text: $newTaskTitle)
                        .focused($isTaskFieldFocused)
                        .onSubmit(saveNewTask)
                    
                    Button("Save", action: saveNewTask)
                        .buttonStyle(.borderless)
                        .fontWeight(.semibold)
                        .disabled(newTaskTitle.isEmpty)
                }
            }
            
            Section {
                ForEach(group.todos?.sorted(by: { $0.creationDate < $1.creationDate }) ?? []) { todo in
                    TodoRowView(todo: todo)
                }
                .onDelete(perform: deleteTodo)
            }
        }
        .listStyle(.insetGrouped)
        .overlay {
            if (group.todos ?? []).isEmpty {
                ContentUnavailableView(
                    "noTasks",
                    systemImage: "checklist.unchecked",
                    description: Text("addYourFirstTask")
                )
            }
        }
    }
    
    private func saveNewTask() {
        guard !newTaskTitle.isEmpty else { return }
        let newTodo = TodoItem(title: newTaskTitle)
        newTodo.group = group
        modelContext.insert(newTodo)
        
        newTaskTitle = ""
        isTaskFieldFocused = false
    }
    
    private func deleteTodo(at offsets: IndexSet) {
        let sortedTodos = group.todos?.sorted(by: { $0.creationDate < $1.creationDate }) ?? []
        for index in offsets {
            let todoToDelete = sortedTodos[index]
            modelContext.delete(todoToDelete)
        }
    }
}
