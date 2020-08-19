//
//  pomodoroReducer.swift
//  PomodoroHub
//
//  Created by 鈴木 航 on 2020/12/09.
//

import Foundation

typealias Reducer<State, Action> = (inout State, Action) -> Void

func pomodoroReducer(state: inout PomodoroState, action: PomodoroAction) -> Void {
    switch(action) {
    case .play: fallthrough
    case .pause:
        state.current = [.play, .pause].randomElement() ?? .determined
    }
}
