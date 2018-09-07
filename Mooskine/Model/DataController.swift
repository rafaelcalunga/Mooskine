//
//  DataController.swift
//  Mooskine
//
//  Created by Rafael Calunga on 2018-08-21.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation
import CoreData

class DataController: NSObject {
    
    let persisteContainer: NSPersistentContainer
    
    var backgroundContext: NSManagedObjectContext!
    
    var viewContext: NSManagedObjectContext {
        return persisteContainer.viewContext
    }
    
    init(modelName: String) {
        persisteContainer = NSPersistentContainer(name: modelName)
    }
    
    func configureContexts() {
        backgroundContext = persisteContainer.newBackgroundContext()
        
        viewContext.automaticallyMergesChangesFromParent = true
        backgroundContext.automaticallyMergesChangesFromParent = true
        
        backgroundContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
    }
    
    func load(completion: (() -> Void)? = nil) {
        persisteContainer.loadPersistentStores { description, error in
            guard error == nil else {
                fatalError("Failed to load Core Data stack: \(error!.localizedDescription)")
            }
            self.autoSaveViewController()
            self.configureContexts()
            completion?()
        }
    }
}

extension DataController {
    
    func autoSaveViewController(interval: TimeInterval = 30) {
        guard interval > 0 else {
            print("cannot set negative autosave interval")
            return
        }
        if viewContext.hasChanges {
            try? viewContext.save()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            self.autoSaveViewController(interval: interval)
        }
    }
    
}
