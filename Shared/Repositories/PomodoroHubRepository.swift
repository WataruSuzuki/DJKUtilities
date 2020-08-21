//
//  PomodoroHubRepository.swift
//  PomodoroHub
//
//  Created by 鈴木 航 on 2020/12/09.
//

import CoreData
import SwiftUI

struct PomodoroHubRepository {
    static let shared = PomodoroHubRepository()

    #if DEBUG
    let container: NSPersistentCloudKitContainer
    #else
    private let container: NSPersistentCloudKitContainer
    #endif
    var context: NSManagedObjectContext {
        get {
            return container.viewContext
        }
    }

    private init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "PomodoroHub")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    func play() -> Session? {
        let newSession = Session(context: context)
        newSession.playedAt = Date()
        do {
            try context.save()
            return newSession
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func pause(session: Session) -> Bool {
        session.pausedAt = Date()
        do {
            try context.save()
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }

    func addItem() {
        let newItem = Session(context: context)
        let date = Date()
        newItem.playedAt = date
        newItem.pausedAt = date

        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func deleteItems(items: FetchedResults<Session>, offsets: IndexSet) {
        offsets.map { items[$0] }.forEach(context.delete)

        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    static var preview: PomodoroHubRepository = {
        let result = PomodoroHubRepository(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = Session(context: viewContext)
            let date = Date()
            newItem.pausedAt = date
            newItem.playedAt = date
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
}
