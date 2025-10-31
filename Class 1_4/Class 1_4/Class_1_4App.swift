//
//  Class_1_4App.swift
//  Class 1_4
//
//  Created by Gabriela Sanchez on 31/10/25.
//

import SwiftUI

@main
struct TodoTrackerApp_Class4: App {
    @State private var settings = SettingsStore()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(settings)
        }

        .modelContainer(for: [TodoGroup.self, TodoItem.self])
    }
}
