//
//  Models.swift
//  Class 1_4
//
//  Created by Gabriela Sanchez on 30/10/25.
//

import SwiftUI
import SwiftData


@Model
class TodoItem: Identifiable {
    @Attribute(.unique) var id: UUID
    var title: String
    var isCompleted: Bool
    var group: TodoGroup?
    var creationDate: Date

    init(id: UUID = UUID(), title: String, isCompleted: Bool = false, creationDate: Date = .now) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.creationDate = creationDate
    }
}

@Model
class TodoGroup: Identifiable {
    @Attribute(.unique) var id: UUID
    var name: String
    var iconName: String
    @Relationship(deleteRule: .cascade, inverse: \TodoItem.group)
    var todos: [TodoItem]? = []

    init(id: UUID = UUID(), name: String, iconName: String) {
        self.id = id
        self.name = name
        self.iconName = iconName
    }
}

struct UserProfile {
    var name: String = "Alex Smith"
    var profileImageName: String = "person.crop.circle"
}
