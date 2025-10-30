//
//  Class_1_2App.swift
//  Class 1_2
//
//  Created by Gabriela Sanchez on 30/10/25.
//

import SwiftUI

@main
struct TodoTrackerApp_Class2: App {
    @StateObject private var viewModel = TodoViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
