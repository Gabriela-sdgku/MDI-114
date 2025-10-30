//
//  ProfileView.swift
//  Class 1_2
//
//  Created by Gabriela Sanchez on 30/10/25.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: TodoViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Image(systemName: viewModel.userProfile.profileImageName)
                    .font(.system(size: 80))
                    .foregroundStyle(.tint)
                    .padding(20)
                    .background(.thinMaterial)
                    .clipShape(Circle())
                
                Text(viewModel.userProfile.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
                
                Form {
                    Section("Settings") {
                        Button("Edit Profile", role: .none) {}
                    }
                    Section("Danger Zone") {
                        Button("Log Out", role: .destructive) {}
                    }
                }
                .frame(height: 200)
                .scrollDisabled(true)
            }
            .padding(40)
        }
    }
}
