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
    let store = PomodoroStore(initialState: .init(session: SessionState()),
                             reducer: pomodoroReducer)

    var body: some Scene {
        WindowGroup {
            TopMenuView()
                .environment(\.managedObjectContext, repository.context)
                .environmentObject(store)
        }
    }
}

#if DEBUG
let pomodoroTechFocusTime = 30.0
let pomodoroTechShortBreakTime = 5.0
let pomodoroTechLongBreakTime = 10.0
#else
let pomodoroTechFocusTime = 25.0 * 60.0 // 25:00
let pomodoroTechShortBreakTime = 5.0 * 60.0 // 05:00
let pomodoroTechLongBreakTime = 15.0 * 60.0 // 15:00
#endif
