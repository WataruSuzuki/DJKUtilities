//
//  SessionRepository.swift
//  PomodoroHub
//
//  Created by 鈴木 航 on 2020/12/16.
//

import Foundation
import Combine

class SessionState: ObservableObject {
    @Published var isCompleted = false
    @Published var focusTime = pomodoroTechFocusTime
    @Published var mode = Mode.focusTime
    @Published var state = State.idle {
        didSet {
            if state != .complete {
                isCompleted = false
            } else {
                state = .idle
                if let nextMode = Mode(rawValue: mode.rawValue + 1) {
                    mode = nextMode
                } else {
                    if interval < threashold {
                        interval += 1
                        mode = .focusTime
                    } else {
                        interval = 0
                        isCompleted = true
                        mode = .determined
                    }
                }
                focusTime = countDownTime
            }
        }
    }
    let threashold = 2
    var interval = 1
    
    var repository: Session?
    
    private lazy var timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
        guard self.state == .play else { return }
        
        self.focusTime -= 1.0
        if self.focusTime <= 0.0 {
            self.state = .complete
        }
    }
    var countDownTime: Double {
        get {
            switch mode {
            case .focusTime: return pomodoroTechFocusTime
            case .breakTime: return pomodoroTechShortBreakTime
            default:
                return pomodoroTechLongBreakTime
            }
        }
    }
    
    init() {
        timer.fire()
    }
    
    enum State: Hashable {
        case determined,
             idle,
             play,
             pause,
             interruption,
             complete
    }
    
    enum Mode: Int {
        case determined = 0,
             focusTime,
             breakTime
    }
}

