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
    @Environment(\.editMode) private var editMode

    let group: TodoGroup
    
    @State private var newTaskTitle = ""
    @FocusState private var isTaskFieldFocused: Bool
    
    private var isEditing: Bool {
        editMode?.wrappedValue == .active
    }
    
    var body: some View {

        List {
            if !isEditing {
                Section {
                    HStack(spacing: 12) {
                        Image(systemName: "circle")
                            .font(.title2)
                            .foregroundStyle(.gray)
                        
                        TextField("New task description...", text: $newTaskTitle)
                            .focused($isTaskFieldFocused)
                            .onSubmit(saveNewTask)
                        
                        Button("Save", action: saveNewTask)
                            .buttonStyle(.borderless)
                            .fontWeight(.semibold)
                            .disabled(newTaskTitle.isEmpty)
                    }
                }
            }
            
            Section {
                let sortedTodos = group.todos?.sorted(by: { $0.creationDate < $1.creationDate }) ?? []
                
                ForEach(sortedTodos) { todo in
                    TodoRowView(todo: todo)
                }
                .onDelete(perform: { offsets in
                    deleteTodo(at: offsets, from: sortedTodos)
                })
            }
        }
        .listStyle(.insetGrouped)
        .overlay {

            if (group.todos ?? []).isEmpty && !isEditing {
                ContentUnavailableView("No Tasks Yet", systemImage: "checklist.unchecked")
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                EditButton()
            }
        }
    }
    
    private func saveNewTask() {
        guard !newTaskTitle.isEmpty else { return }
        
        let newTodo = TodoItem(title: newTaskTitle)
        modelContext.insert(newTodo)
        group.todos?.append(newTodo)
        
        newTaskTitle = ""
        isTaskFieldFocused = false
    }
    
    private func deleteTodo(at offsets: IndexSet, from sortedTodos: [TodoItem]) {
        for index in offsets {
            let todoToDelete = sortedTodos[index]
            modelContext.delete(todoToDelete)
            
            group.todos?.removeAll(where: { $0.id == todoToDelete.id })
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: TodoGroup.self, TodoItem.self, configurations: config)
        
        let sampleGroup = TodoGroup(name: "Preview Group", iconName: "star.fill")
        container.mainContext.insert(sampleGroup)
        
        let task1 = TodoItem(title: "First Task")
        let task2 = TodoItem(title: "Second Task")
        task1.group = sampleGroup
        task2.group = sampleGroup
        container.mainContext.insert(task1)
        container.mainContext.insert(task2)
        
        return NavigationStack {
            TodoListView(group: sampleGroup)
                .modelContainer(container)
        }
        
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}

