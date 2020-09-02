//
//  TopMenuView.swift
//  PomodoroHub
//
//  Created by 鈴木 航 on 2020/12/16.
//

import SwiftUI

struct TopMenuView: View {

    var body: some View {
        TabView() {
            Menu(
                menu: .session,
                dependencyView: AnyView(SessionView())
            )
            Menu(
                menu: .tasks,
                dependencyView: AnyView(TasksView())
            )
            Menu(
                menu: .activities,
                dependencyView: AnyView(ActivitiesView())
            )
            Menu(
                menu: .settings,
                dependencyView: AnyView(Text(TopMenus.settings.describing))
            )
        }
    }
}

private struct Menu: View {
    var menu: TopMenus
    var dependencyView: AnyView
    
    var body: some View {
        dependencyView.tabItem {
            Image(systemName: menu.imageName)
                .onTapGesture(perform: {
                    //TODO: tap gesture is here
                })
            Text(menu.describing.localized)
        }
        .tag(menu)
    }
}

enum TopMenus: Int, CaseIterable {
    case session = 0,
         tasks,
         activities,
         settings
    
    var describing: String {
        get {
            return String(describing: self)
        }
    }
    
    var imageName: String {
        get {
            switch self {
            case .session: return "timer"
            case .tasks: return "list.number"
            case .activities: return "chart.bar"
            case .settings: return "gear"
            }
        }
    }
}

struct TopMenuView_Previews: PreviewProvider {
    static var previews: some View {
        TopMenuView()
    }
}
