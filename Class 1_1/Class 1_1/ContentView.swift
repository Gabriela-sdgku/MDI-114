//
//  ContentView.swift
//  Class 1_1
//
//  Created by Gabriela Sanchez on 30/10/25.
//

import SwiftUI



struct ContentView: View {
    
    @State private var selection: String? = "homework"
    
    var body: some View {

        NavigationSplitView {

            List(selection: $selection) {
                Section("My Groups") {
                    NavigationLink(value: "homework") {
                        Label("Homework", systemImage: "books.vertical.fill")
                    }
                    
                    NavigationLink(value: "chores") {
                        Label("House Chores", systemImage: "house.fill")
                    }
                }
                
                Section("Account") {
                    NavigationLink(value: "profile") {
                        Label("Alex Smith", systemImage: "person.crop.circle")
                    }
                }
            }
            .listStyle(.sidebar)
            .navigationTitle("My Todo Tracker")

        } detail: {
                        
            switch selection {
            case "homework":

                PlaceholderDetailView(title: "Homework", icon: "books.vertical.fill")
                
            case "chores":
                PlaceholderDetailView(title: "House Chores", icon: "house.fill")
                
            case "profile":
                PlaceholderDetailView(title: "Profile", icon: "person.crop.circle")
                
            default:
                ContentUnavailableView(
                    "Welcome",
                    systemImage: "checklist.unchecked",
                    description: Text("Select a group from the sidebar to get started.")
                )
            }
        }
    }
}

struct PlaceholderDetailView: View {
    let title: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: icon)
                .font(.system(size: 80))
                .foregroundStyle(.secondary)
            
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("This is a placeholder for our \(title) screen.")
                .font(.title3)
                .foregroundStyle(.secondary)
        }
        .navigationTitle(title)
    }
}

#Preview {
    ContentView()
}
