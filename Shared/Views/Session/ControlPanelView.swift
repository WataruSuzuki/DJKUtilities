//
//  SessionControlPanelView.swift
//  PomodoroHub (iOS)
//
//  Created by 鈴木 航 on 2020/12/16.
//

import SwiftUI

struct ControlPanelView: View {
    @EnvironmentObject var store: PomodoroStore
    @ObservedObject var session: SessionState
    @State private var showingAlert: AlertItem?
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                store.dispatch(.interruption)
                showingAlert = AlertItem(alert: interruptionAlert)
            }, label: {
                Image(systemName: "xmark.circle")
                    .resizable()
                    .frame(width: 44, height: 44, alignment: .center)
                    .foregroundColor(.red)
            })
            .alert(item: $showingAlert) { (item) -> Alert in
                item.alert
            }
            Spacer()
            Button(action: {
                if store.state.session.state == .play {
                    store.dispatch(.pause)
                } else {
                    store.dispatch(.play)
                }
            }, label: {
                Image(systemName: store.state.session.state == .play
                        ? "pause.circle"
                        : "play.circle")
                    .resizable()
                    .frame(width: 44, height: 44, alignment: .center)
                    .foregroundColor(.orange)
            })
            Spacer()
            Button(action: {
                store.dispatch(.complete)
            }, label: {
                Image(systemName: "checkmark.circle")
                    .resizable()
                    .frame(width: 44, height: 44, alignment: .center)
                    .foregroundColor(.green)
            })
            .sheet(isPresented: $session.isCompleted, onDismiss: {}, content: {
                ReviewingView()
            })
            Spacer()
        }
        .padding(.all, 10)
        .cornerRadius(30)
    }
    
    private struct AlertItem: Identifiable {
        var id = UUID()
        var alert: Alert
    }
    
    private var interruptionAlert: Alert {
        Alert(
            title: Text("caution".localized),
            message: Text("msg_confirm_interruption".localized),
            primaryButton: .cancel(
                Text("cancel".localized), action: {
                    store.dispatch(.play)
                }),
            secondaryButton: .destructive(
                Text("interruption".localized), action: {
                    store.dispatch(.complete)
                })
        )
    }
}

struct SessionControlPanelView_Previews: PreviewProvider {
    static var previews: some View {
        ControlPanelView(session: SessionState())
    }
}
