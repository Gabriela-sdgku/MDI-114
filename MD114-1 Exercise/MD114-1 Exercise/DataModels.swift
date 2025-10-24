//
//  DataModels.swift
//  MD114-1 Exercise
//
//  Created by Gabriela Sanchez on 09/09/25.
//

import SwiftUI

struct SportCategory: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let icon: String
    let sports: [Sport]
}

struct Sport: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let detail: String
    let icon: String
}
