//
//  TodoViewModel.swift
//  Class 1_2
//
//  Created by Gabriela Sanchez on 30/10/25.
//

import SwiftUI

@MainActor
class TodoViewModel: ObservableObject {

    @Published var groups: [TodoGroup] = []
    @Published var todos: [TodoItem] = []
    @Published var userProfile: UserProfile
    
    init() {
        let initialProfile = UserProfile(name: "Alex Smith", profileImageName: "person.crop.circle")
        
        let initialGroups = [
            TodoGroup(name: "Homework", iconName: "books.vertical.fill"),
            TodoGroup(name: "House Chores", iconName: "house.fill"),
            TodoGroup(name: "Groceries", iconName: "cart.fill")
        ]
        
        let initialTodos = [
            TodoItem(title: "Finish Math Assignment", groupID: initialGroups[0].id),
            TodoItem(title: "Read Chapter 4 of History", isCompleted: true, groupID: initialGroups[0].id),
            TodoItem(title: "Take out the trash", groupID: initialGroups[1].id),
        ]
        
        self.userProfile = initialProfile
        self.groups = initialGroups
        self.todos = initialTodos
    }

    func toggleCompletion(for todo: TodoItem) {
        guard let index = todos.firstIndex(where: { $0.id == todo.id }) else { return }
        todos[index].isCompleted.toggle()
    }
    
    func addTodo(title: String, groupID: UUID) {
        guard !title.isEmpty else { return }
        let newTodo = TodoItem(title: title, groupID: groupID)
        withAnimation {
            todos.append(newTodo)
        }
    }
    
    func deleteTodo(at offsets: IndexSet, in group: TodoGroup) {
        let groupTodos = todos.filter { $0.groupID == group.id }
        let idsToDelete = offsets.map { groupTodos[$0].id }
        
        withAnimation {
            todos.removeAll { idsToDelete.contains($0.id) }
        }
    }
    
    func todos(for group: TodoGroup) -> [TodoItem] {
        todos.filter { $0.groupID == group.id }
    }
}

