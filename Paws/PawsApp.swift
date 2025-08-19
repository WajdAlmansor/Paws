//
//  PawsApp.swift
//  Paws
//
//  Created by Wajd on 19/08/2025.
//

import SwiftUI
import SwiftData

@main
struct PawsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Pet.self)
        }
    }
}
