//
//  Class_2_1App.swift
//  Class 2_1
//
//  Created by Gabriela Sanchez on 31/10/25.
//

import SwiftUI

@main
struct Class_2_1App: App {
    
    @State private var settings = SettingsStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(settings)
        }
        .modelContainer(for: [TodoGroup.self, TodoItem.self])
    }
}
