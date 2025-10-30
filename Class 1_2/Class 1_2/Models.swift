//
//  Models.swift
//  Class 1_2
//
//  Created by Gabriela Sanchez on 30/10/25.
//

import SwiftUI

struct TodoItem: Identifiable, Hashable {
    let id: UUID
    var title: String
    var isCompleted: Bool
    let groupID: UUID

    init(id: UUID = UUID(), title: String, isCompleted: Bool = false, groupID: UUID) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.groupID = groupID
    }
}

struct TodoGroup: Identifiable, Hashable {
    let id: UUID
    var name: String
    var iconName: String

    init(id: UUID = UUID(), name: String, iconName: String) {
        self.id = id
        self.name = name
        self.iconName = iconName
    }
}

struct UserProfile {
    var name: String
    var profileImageName: String
}
