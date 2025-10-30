//
//  TodoRowView.swift
//  Class 1_2
//
//  Created by Gabriela Sanchez on 30/10/25.
//

import SwiftUI
struct TodoRowView: View {
    @EnvironmentObject var viewModel: TodoViewModel
    let todo: TodoItem
    
    var body: some View {
        HStack(spacing: 15) {
            Button {
                viewModel.toggleCompletion(for: todo)
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
