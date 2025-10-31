//
//  ProfileView.swift
//  Class 1_2
//
//  Created by Gabriela Sanchez on 30/10/25.
//

import SwiftUI

struct ProfileView: View {
    @Environment(SettingsStore.self) private var settings

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Image(systemName: settings.profile.profileImageName)
                    .font(.system(size: 80))
                Text(settings.profile.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                Form {
                    Section("Settings") { Button("Edit Profile", role: .none) {} }
                    Section("Danger Zone") { Button("Log Out", role: .destructive) {} }
                }
                .frame(height: 200)
                .scrollDisabled(true)
            }
            .padding(40)
        }
    }
}
