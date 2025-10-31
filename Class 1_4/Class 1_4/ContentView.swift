//
//  ContentView.swift
//  Class 1_4
//
//  Created by SDGKU on 31/10/25.
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
    
    @State private var selection: NavigationItem?
    @State private var showGroupManagerSheet = false

    var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                Section {
                    ForEach(groups) { group in
                        NavigationLink(value: NavigationItem.group(group.id)) {
                            Label(group.name, systemImage: group.iconName)
                        }
                    }
                } header: {
                    HStack {
                        Text("My Groups")
                        Spacer()
                        Button {
                            showGroupManagerSheet = true
                        } label: {
                            Image(systemName: "gearshape")
                        }
                        .buttonStyle(.borderless)
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
            .sheet(isPresented: $showGroupManagerSheet) {
                GroupManagerView()
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
                    ContentUnavailableView(
                        "Welcome",
                        systemImage: "checklist.unchecked",
                        description: Text("Select a group, or create one using the 'gear' icon in the sidebar.")
                    )
                }
            }
            .navigationTitle(navigationTitle(for: selection))
        }
        .onAppear {
            if selection == nil, let firstGroup = groups.first {
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
            return groups.first(where: { $0.id == groupID })?.name ?? "Tasks"
        }
    }
}
