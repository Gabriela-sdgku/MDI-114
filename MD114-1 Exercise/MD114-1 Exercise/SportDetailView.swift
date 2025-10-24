//
//  SportDetailView.swift
//  MD114-1 Exercise
//
//  Created by Gabriela Sanchez on 09/09/25.
//

import SwiftUI
struct SportDetailView: View {
    let sport: Sport
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.accentColor.opacity(0.8), .accentColor]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Image(systemName: sport.icon)
                    .font(.system(size: 120))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.2), radius: 10, y: 10)
                
                Text(LocalizedStringKey(sport.name))
                    .font(.system(size: 48, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Text(LocalizedStringKey(sport.detail))
                    .font(.body)
                    .foregroundColor(.white.opacity(0.9))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Spacer()
                
                Button(action: {
                    dismiss()
                }) {
                    Text("Done")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.accentColor)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.white)
                        .cornerRadius(15)
                }
            }
            .padding(40)
        }
    }
}
