//
//  TasksView.swift
//  PomodoroHub (iOS)
//
//  Created by 鈴木航 on 2020/08/07.
//

import SwiftUI

struct TasksView: View {
    @EnvironmentObject var store: PomodoroStore

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Task.createdAt, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Task>

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
                trailing: Button(action: addTask, label: {
                    Image(systemName: "plus")
                }))
    }
    #endif//iOS
    
    #if os(macOS)
    private var macOSBody: some View {
        commonBody
            .toolbar(content: {
                Button(action: addTask) {
                    Label("Add Item", systemImage: "plus")
                }
            })
    }
    #endif //macOS
    
    private var commonBody: some View {
        List {
            ForEach(items) { item in
                NavigationLink(destination: DetailView()) {
                    Text("Item at \(item.createdAt!, formatter: itemFormatter)")
                }
            }
            .onDelete(perform: deleteItems)
        }
    }

//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(self.activities.tasks) { task in
//                    let viewModel = TaskViewModel(task: task)
//                    let destination = TaskDetailsView(activities: activities, task: viewModel)
//                    NavigationLink(destination: destination) {
//                        Text(viewModel.title)
//                    }
//                }
//            }
//            .navigationBarTitle(TopMenus.tasks.describing.localized)
//            .navigationBarItems(
//                trailing:
//                    Button(action: {
//                        taskRouter.sheet = .addingNewTask
//                    }) {
//                        Image(systemName: "plus")
//                    }
//            )
//            .sheet(item: $taskRouter.sheet) { item in
//                switch item {
//                case .addingNewTask:
//                    AddingTaskView(activities: activities)
//                        .environmentObject(taskRouter)
//                }
//            }
//        }
//    }
    private func addTask() {
        withAnimation {
            let _ = PomodoroHubRepository.shared.addTask()
//            store.dispatch(.play)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
//            PomodoroHubRepository.shared.deleteItems(items: items, offsets: offsets)
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
    }
}
