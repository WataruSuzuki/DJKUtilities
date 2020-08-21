//
//  pomodoroReducer.swift
//  PomodoroHub
//
//  Created by 鈴木 航 on 2020/12/09.
//

import Foundation

typealias Reducer<State, Action> = (inout State, Action) -> Void

func pomodoroReducer(state: inout PomodoroState, action: PomodoroAction) -> Void {
    if action == .play {
        playSession(state: state)
    } else {
        pauseSessionRepository(state: state)
    }
    
    switch(action) {
    case .idle:
        state.session.state = .idle
    case .play:
        state.session.state = .play
    case .pause:
        state.session.state = .pause
    case .interruption:
        state.session.state = .interruption
    case .complete:
        state.session.state = .complete
    }
}

private func playSession(state: PomodoroState) {
    state.session.repository = PomodoroHubRepository.shared.play()
}

private func pauseSessionRepository(state: PomodoroState) {
    if let repository = state.session.repository {
        if PomodoroHubRepository.shared.pause(session: repository) {
            state.session.repository = nil
        }
    }
}
