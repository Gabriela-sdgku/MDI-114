//
//  AdaptiveiPadLayoutView.swift
//  MD114-1 Exercise
//
//  Created by Gabriela Sanchez on 09/09/25.
//

import SwiftUI

struct GradientHelper {
    static let gradients: [LinearGradient] = [
        LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing),
        LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing),
        LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]), startPoint: .topLeading, endPoint: .bottomTrailing),
        LinearGradient(gradient: Gradient(colors: [Color.pink, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing),
        LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.orange]), startPoint: .topLeading, endPoint: .bottomTrailing),
        LinearGradient(gradient: Gradient(colors: [Color.teal, Color.green]), startPoint: .topLeading, endPoint: .bottomTrailing)
    ]
    
    static func getGradient(for index: Int) -> LinearGradient {
        return gradients[index % gradients.count]
    }
}

struct AdaptiveiPadLayoutView: View {
    @State private var sportCategories = [
        SportCategory(name: "category_ball_sports", icon: "soccerball", sports: [
            Sport(name: "sport_soccer", detail: "detail_soccer", icon: "soccerball"),
            Sport(name: "sport_basketball", detail: "detail_basketball", icon: "basketball.fill"),
            Sport(name: "sport_tennis", detail: "detail_tennis", icon: "tennis.racket"),
            Sport(name: "sport_baseball", detail: "detail_baseball", icon: "figure.baseball")
        ]),
        SportCategory(name: "category_water_sports", icon: "figure.pool.swim", sports: [
            Sport(name: "sport_swimming", detail: "detail_swimming", icon: "figure.pool.swim"),
            Sport(name: "sport_surfing", detail: "detail_surfing", icon: "figure.surfing"),
            Sport(name: "sport_water_polo", detail: "detail_water_polo", icon: "sportscourt.fill")
        ]),
        SportCategory(name: "category_track_field", icon: "figure.run", sports: [
            Sport(name: "sport_running", detail: "detail_running", icon: "figure.run"),
            Sport(name: "sport_long_jump", detail: "detail_long_jump", icon: "figure.jumprope"),
            Sport(name: "sport_javelin", detail: "detail_javelin", icon: "arrow.up.forward")
        ])
    ]

    var body: some View {
        NavigationView {
            List {
                ForEach(sportCategories) { category in
                    NavigationLink(destination: SportsGridView(category: category)) {
                        Label(LocalizedStringKey(category.name), systemImage: category.icon)
                            .font(.headline)
                            .padding(.vertical, 8)
                    }
                }
            }
            .listStyle(.sidebar)
            .navigationTitle("sports_categories_title")
            
            Text("select_a_category_prompt")
                .font(.title)
        }
    }
}
