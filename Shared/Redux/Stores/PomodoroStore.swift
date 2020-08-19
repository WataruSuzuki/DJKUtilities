//
//  SessionStore.swift
//  PomodoroHub
//
//  Created by 鈴木 航 on 2020/12/09.
//

import Foundation

typealias PomodoroStore = Store<PomodoroState, PomodoroAction>
final class Store<State, Action>: ObservableObject {
    
    // Read only access to Session state
    @Published private(set) var state: State

    private let reducer: Reducer<State, Action>

    init(initialState: State, reducer: @escaping Reducer<State, Action>) {
        self.state = initialState
        self.reducer = reducer
    }

    // The dispatch function.
    func dispatch(_ action: Action) {
        reducer(&state, action)
    }
}
