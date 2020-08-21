//
//  SessionTimerView.swift
//  PomodoroHub (iOS)
//
//  Created by 鈴木 航 on 2020/12/16.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject var session: SessionState
    
    var body: some View {
        GeometryReader { timer in
            ZStack {
                let textSize = min(timer.size.width, timer.size.height) / 4
                Circle()
                    .stroke(Color.green,
                            style: StrokeStyle(
                                lineWidth: 3,
                                lineCap: .butt,
                                dash: [5,3],
                                dashPhase: 10)
                    )
                    .padding(.all, 10)
                Circle()
                    .trim(from: 0.0, to: CGFloat(session.focusTime / session.countDownTime))
                    .rotation(.degrees(-90))
                    .stroke(Color.green, style: StrokeStyle(lineWidth: 10))
                    .padding(.all, 10)
//                Circle()
//                    .trim(from: 0.0, to: 1.0 - CGFloat(session.focusTime / session.countDownTime))
//                    .rotation(.degrees(270))
//                    .stroke(Color.green, style: StrokeStyle(lineWidth: 10))
//                    .padding(.all, 10)
                HStack {
                    Text(formatted(time: session.focusTime, unit: .minute))
                        .font(.system(size: textSize))
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                    Text(":")
                        .font(.system(size: textSize))
                    Text(formatted(time: session.focusTime, unit: .second))
                        .font(.system(size: textSize))
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            }
        }
    }
    
    fileprivate func formatted(time: TimeInterval, unit: NSCalendar.Unit) -> String {
        let calendar = Calendar.current
        let date = Date(timeInterval: -time, since: Date())

        let components = calendar.dateComponents([.year, .day, .hour, .minute, .second], from: date, to: Date())

        switch unit {
        case .minute:
            if let minute = components.minute {
                return String(format: "%02d", minute)
            }
        case .second:
            if let second = components.second {
                return String(format: "%02d", second)
            }
        default:
            break
        }
        return "??"
    }
}

struct SessionTimerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TimerView(session: previewSession)
            #if os(iOS)
            TimerView(session: previewSession)
                .previewLayout(
                    .fixed(
                        width: UIScreen.main.bounds.height,
                        height: UIScreen.main.bounds.width))
            #endif//iOS
        }
    }
    
    private static var previewSession: SessionState {
        get {
            let session = SessionState()
            session.state = .play
            return session
        }
    }
}
