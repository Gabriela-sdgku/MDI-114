//
//  TodoListView.swift
//  Class 1_2
//
//  Created by Gabriela Sanchez on 30/10/25.
//

import SwiftUI

struct TodoListView: View {
    @EnvironmentObject var viewModel: TodoViewModel
    @State private var newTaskTitle = ""
    @FocusState private var isTaskFieldFocused: Bool
    let group: TodoGroup

    private var todos: [TodoItem] {
        viewModel.todos(for: group)
    }
    
    var body: some View {
        List {
            Section {
                HStack(spacing: 12) {
                    Image(systemName: "circle")
                        .font(.title2)
                        .foregroundStyle(.gray)
                    
                    TextField("New task description...", text: $newTaskTitle)
                        .focused($isTaskFieldFocused)
                        .onSubmit(saveNewTask)
                    
                    Button("Save") {
                        saveNewTask()
                    }
                    .buttonStyle(.borderless)
                    .fontWeight(.semibold)
                    .disabled(newTaskTitle.isEmpty)
                }
            }
            
            Section {
                ForEach(todos) { todo in
                    TodoRowView(todo: todo)
                }
                .onDelete { offsets in
                    viewModel.deleteTodo(at: offsets, in: group)
                }
            }
        }
        .listStyle(.insetGrouped)
        .overlay {
            if todos.isEmpty {
                ContentUnavailableView(
                    "No Tasks Yet",
                    systemImage: "checklist.unchecked",
                    description: Text("Add your first task above.")
                )
            }
        }
    }
    
    private func saveNewTask() {
        viewModel.addTodo(title: newTaskTitle, groupID: group.id)
        newTaskTitle = ""
        isTaskFieldFocused = false
    }
}
