//
//  ContentView.swift
//  Class 1_4
//
//  Created by Gabriela Sanchez on 31/10/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    enum NavigationItem: Hashable {
        case profile
        case group(UUID)
    }
    @Query(sort: \TodoGroup.name) private var groups: [TodoGroup]
    
    @Environment(SettingsStore.self) private var settings
    @Environment(\.modelContext) private var modelContext
    @State private var selection: NavigationItem?
    @State private var isAddingNewGroup = false
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                Section("My Groups") {
                    ForEach(groups) { group in
                        NavigationLink(value: NavigationItem.group(group.id)) {
                            Label(group.name, systemImage: group.iconName)
                        }
                    }
                }
                
                Section("Account") {
                    NavigationLink(value: NavigationItem.profile) {
                        Label(settings.profile.name, systemImage: settings.profile.profileImageName)
                    }
                }
            }
            .listStyle(.sidebar)
            .navigationTitle("My Todo Tracker")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isAddingNewGroup = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isAddingNewGroup) {
                NewGroupView(isPresented: $isAddingNewGroup)
                    .environment(\.modelContext, modelContext)
            }
            .overlay {
                if groups.isEmpty {
                    ContentUnavailableView {
                        Label("No Groups", systemImage: "checklist.unchecked")
                    } description: {
                        Text("Tap the '+' button to add your first group.")
                    }
                }
            }
            
        } detail: {
            Group {
                if let selection {
                    switch selection {
                    case .profile:
                        ProfileView()
                    case .group(let groupID):
                        if let group = groups.first(where: { $0.id == groupID }) {
                            TodoListView(group: group)
                        } else {
                            Text("Group not found.")
                        }
                    }
                } else {
                    ContentUnavailableView("Select a Group", systemImage: "sidebar.left")
                }
            }
            .navigationTitle(navigationTitle(for: selection))
        }
        
    }
    
    private func navigationTitle(for item: NavigationItem?) -> String {
        guard let item else { return "" }
        switch item {
        case .profile:
            return "Profile"
        case .group(let groupID):
            return groups.first(where: { $0.id == groupID })?.name ?? "Tasks"
        }
    }
}

struct NewGroupView: View {
    @Binding var isPresented: Bool
    @Environment(\.modelContext) private var modelContext
    
    @State private var groupName = ""
    @State private var selectedIcon = "list.bullet"
    
    let icons = ["list.bullet", "person.fill", "briefcase.fill", "star.fill", "heart.fill", "book.fill"]

    var body: some View {
        NavigationStack {
            Form {
                Section("Group Name") {
                    TextField("Personal, Work, etc.", text: $groupName)
                }
                
                Section("Icon") {
                    Picker("Icon", selection: $selectedIcon) {
                        ForEach(icons, id: \.self) { icon in
                            Image(systemName: icon).tag(icon)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .navigationTitle("New Group")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { isPresented = false }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveGroup()
                    }
                    .disabled(groupName.isEmpty)
                }
            }
        }
    }
    
    private func saveGroup() {
        let newGroup = TodoGroup(name: groupName, iconName: selectedIcon)
        modelContext.insert(newGroup)
        isPresented = false
    }
}


#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: TodoGroup.self, TodoItem.self, configurations: config)
        
        return ContentView()
            .modelContainer(container)
            .environment(SettingsStore())
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}

