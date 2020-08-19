//
//  PomodoroHubApp.swift
//  Shared
//
//  Created by 鈴木 航 on 2020/12/08.
//

import SwiftUI

@main
struct PomodoroHubApp: App {
    let repository = PomodoroHubRepository.shared
    let store = PomodoroStore(initialState: .init(current: .determined),
                             reducer: pomodoroReducer)

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, repository.context)
                .environmentObject(store)
        }
    }
}
