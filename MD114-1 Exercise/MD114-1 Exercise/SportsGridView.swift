//
//  SportsGridView.swift
//  MD114-1 Exercise
//
//  Created by Gabriela Sanchez on 09/09/25.
//

import SwiftUI
struct SportsGridView: View {
    let category: SportCategory
    @State private var selectedSport: Sport?

    let columns = [
        GridItem(.adaptive(minimum: 160, maximum: 200))
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(Array(category.sports.enumerated()), id: \.element) { index, sport in
                    Button(action: {
                        selectedSport = sport
                    }) {
                        VStack {
                            Spacer()
                            Image(systemName: sport.icon)
                                .font(.system(size: 50))
                                .foregroundColor(.white.opacity(0.9))
                            Spacer()
                            Text(LocalizedStringKey(sport.name))
                                .font(.system(.headline, design: .rounded))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .padding(.bottom, 8)
                        }
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 160)
                        .background(GradientHelper.getGradient(for: index))
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
        }
        .navigationTitle(LocalizedStringKey(category.name))
        .sheet(item: $selectedSport) { sport in
            SportDetailView(sport: sport)
        }
    }
}
