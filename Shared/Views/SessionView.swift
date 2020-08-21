//
//  SessionView.swift
//  PomodoroHub (iOS)
//
//  Created by 鈴木 航 on 2020/12/16.
//

import SwiftUI

struct SessionView: View {
    @EnvironmentObject var store: PomodoroStore
    
    var body: some View {
        #if os(iOS)
        iOSBody
        #else
        NavigationView {
            GeometryReader { navigation in
                if navigation.size.width > navigation.size.height {
                    HStack {
                        TimerView(session: store.state.session)
                        ControlPanelView()
                            .padding()
                    }
                } else {
                    VStack {
                        TimerView(session: store.state.session)
                        ControlPanelView(session: store.state.session)
                            .padding()
                    }
                }
            }
        }
        #endif//iOS
    }
    
    #if os(iOS)
    private var iOSBody: some View {
        NavigationView {
            GeometryReader { navigation in
                if navigation.size.width > navigation.size.height {
                    HStack {
                        TimerView(session: store.state.session)
                        ControlPanelView(session: store.state.session)
                            .padding()
                    }
                } else {
                    VStack {
                        TimerView(session: store.state.session)
                        ControlPanelView(session: store.state.session)
                        .padding()
                    }
                }
            }
            .navigationBarTitle(
                TopMenus.session.describing.localized
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    #endif
}

struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SessionView()
            #if os(iOS)
            SessionView()
                .previewLayout(
                    .fixed(
                        width: UIScreen.main.bounds.height,
                        height: UIScreen.main.bounds.width))
            #endif//iOS
        }
    }
}
