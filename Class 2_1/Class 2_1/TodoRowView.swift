//
//  TodoRowView.swift
//  Class 1_4
//
//  Created by Gabriela Sanchez on 30/10/25.
//

import SwiftUI
struct TodoRowView: View {
    @Bindable var todo: TodoItem
    
    var body: some View {
        HStack(spacing: 15) {
            Button {
                todo.isCompleted.toggle()
            } label: {
                Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundStyle(todo.isCompleted ? .green : .gray)
            }
            .buttonStyle(.plain)

            Text(todo.title)
                .font(.body)
                .strikethrough(todo.isCompleted, color: .secondary)
                .foregroundStyle(todo.isCompleted ? .secondary : .primary)
            
            Spacer()
        }
        .padding(.vertical, 8)
    }
}
