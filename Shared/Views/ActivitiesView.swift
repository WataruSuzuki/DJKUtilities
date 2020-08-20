//
//  ActivitiesView.swift
//  Shared
//
//  Created by 鈴木 航 on 2020/12/08.
//

import SwiftUI
import CoreData

struct ActivitiesView: View {
    @EnvironmentObject var store: PomodoroStore
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Session.playedAt, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Session>

    var body: some View {
        NavigationView {
            #if os(iOS)
            iOSBody
            #else
            macOSBody
            #endif
        }
    }
    
    #if os(iOS)
    private var iOSBody: some View {
        commonBody
            .navigationBarItems(leading: EditButton())
            .navigationBarItems(
                leading: EditButton(),
                trailing: Button(action: addItem, label: {
                    Image(systemName: "plus")
                }))
    }
    #endif //iOS
    
    #if os(macOS)
    private var macOSBody: some View {
        commonBody
            .toolbar(content: {
                Button(action: addItem) {
                    Label("Add Item", systemImage: "plus")
                }
            })
    }
    #endif //macOS
    
    private var commonBody: some View {
        List {
            ForEach(items) { item in
                NavigationLink(destination: DetailView()) {
                    Text("Item at \(item.playedAt!, formatter: itemFormatter)")
                }
            }
            .onDelete(perform: deleteItems)
        }
    }

    private func addItem() {
        withAnimation {
            PomodoroHubRepository.shared.addItem()
            store.dispatch(.play)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            PomodoroHubRepository.shared.deleteItems(items: items, offsets: offsets)
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ActivitiesView().environment(\.managedObjectContext, PomodoroHubRepository.preview.container.viewContext)
    }
}
