//
//  Mind_s_EyeApp.swift
//  Mind's Eye
//
//  Created by BASHAER AZIZ on 16/06/1446 AH.
//

import SwiftUI
import SwiftData

@main
struct Mind_s_EyeApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
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
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
