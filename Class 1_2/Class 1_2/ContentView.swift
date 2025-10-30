//
//  ContentView.swift
//  Class 1_2
//
//  Created by Gabriela Sanchez on 30/10/25.
//

import SwiftUI

struct ContentView: View {
    enum NavigationItem: Hashable {
        case profile
        case group(UUID)
    }
    @EnvironmentObject var viewModel: TodoViewModel
    @State private var selection: NavigationItem?

    var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                Section("My Groups") {
                    ForEach(viewModel.groups) { group in
                        NavigationLink(value: NavigationItem.group(group.id)) {
                            Label(group.name, systemImage: group.iconName)
                        }
                    }
                }
                
                Section("Account") {
                    NavigationLink(value: NavigationItem.profile) {
                        Label(viewModel.userProfile.name, systemImage: viewModel.userProfile.profileImageName)
                    }
                }
            }
            .listStyle(.sidebar)
            .navigationTitle("My Todo Tracker")
        } detail: {
            Group {
                if let selection {
                    switch selection {
                    case .profile:
                        ProfileView()
                    case .group(let groupID):
                        if let group = viewModel.groups.first(where: { $0.id == groupID }) {
                            TodoListView(group: group)
                        } else {
                            Text("Group not found.")
                        }
                    }
                } else {
                    ContentUnavailableView(
                        "Welcome",
                        systemImage: "checklist.unchecked",
                        description: Text("Select a group or your profile from the sidebar to get started.")
                    )
                }
            }
            .navigationTitle(navigationTitle(for: selection))
        }
        .onAppear {
            if selection == nil, let firstGroup = viewModel.groups.first {
                selection = .group(firstGroup.id)
            }
        }
    }
    
    private func navigationTitle(for item: NavigationItem?) -> String {
        guard let item else { return "" }
        switch item {
        case .profile:
            return "Profile"
        case .group(let groupID):
            return viewModel.groups.first(where: { $0.id == groupID })?.name ?? "Tasks"
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(TodoViewModel())
}
