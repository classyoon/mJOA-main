//
//  mJOAApp.swift
//  mJOA
//
//  Created by Tim Yoon on 5/23/24.
//

import SwiftUI
import SwiftData

@main
struct mJOAApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            ModifiedJOA.self, Patient.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            PatientListView()
        }
        .modelContainer(sharedModelContainer)
    }
}
