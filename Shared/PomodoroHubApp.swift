//
//  PomodoroHubApp.swift
//  Shared
//
//  Created by 鈴木 航 on 2020/12/08.
//

import SwiftUI

@main
struct PomodoroHubApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
