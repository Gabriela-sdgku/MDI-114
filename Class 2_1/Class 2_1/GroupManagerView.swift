//
//  GroupManagerView.swift
//  Class 1_4
//
//  Created by Gabriela Sanchez on 31/10/25.
//

import SwiftUI
import _SwiftData_SwiftUI

struct GroupManagerView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    @Query(sort: \TodoGroup.name) private var groups: [TodoGroup]
    
    let icons = ["list.bullet", "star.fill", "briefcase.fill", "heart.fill", "book.fill", "house.fill"]
    @State private var newGroupName: String = ""
    @State private var selectedIcon: String = "list.bullet"
    
    var body: some View {
        NavigationStack {
            List {
                Section("Add New Group") {
                    TextField("Group Name (e.g., Work)", text: $newGroupName)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(icons, id: \.self) { icon in
                                Button {
                                    selectedIcon = icon
                                } label: {
                                    Image(systemName: icon)
                                        .font(.title2)
                                        .padding(8)
                                        .background(selectedIcon == icon ? Color.blue.opacity(0.3) : Color.clear)
                                        .clipShape(Circle())
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    
                    Button("Add") {
                        addGroup()
                    }
                    .disabled(newGroupName.isEmpty)
                }
                
                Section("Manage Groups") {
                    if groups.isEmpty {
                        Text("You haven't added any groups yet.")
                            .foregroundStyle(.secondary)
                    }
                    
                    ForEach(groups) { group in
                        Label(group.name, systemImage: group.iconName)
                    }
                    .onDelete(perform: deleteGroup)
                }
            }
            .navigationTitle("Manage Groups")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
    
    private func addGroup() {
        guard !newGroupName.isEmpty else { return }
        let newGroup = TodoGroup(name: newGroupName, iconName: selectedIcon)
        modelContext.insert(newGroup)
        
        newGroupName = ""
        selectedIcon = "list.bullet"
    }
    
    private func deleteGroup(at offsets: IndexSet) {
        for index in offsets {
            let groupToDelete = groups[index]
            modelContext.delete(groupToDelete)
        }
    }
}

