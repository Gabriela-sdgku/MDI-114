//
//  TodoViewModel.swift
//  Class 1_4
//
//  Created by Gabriela Sanchez on 30/10/25.
//

import SwiftUI

@Observable
class SettingsStore {
    var profile: UserProfile
    
    init() {
        self.profile = UserProfile()
    }
    
    func updateName(_ newName: String) {
        profile.name = newName
    }
}
