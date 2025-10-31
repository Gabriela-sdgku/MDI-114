//
//  TodoViewModel.swift
//  Class 1_4
//
//  Created by SDGKU on 30/10/25.
//

import SwiftUI

@Observable
class SettingsStore {
    var profile: UserProfile
    
    init() {
        self.profile = UserProfile(name: "Your Name", profileImageName: "person.crop.circle")
    }
    
    func updateName(_ newName: String) {
        profile.name = newName
    }
}
