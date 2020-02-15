//
//  CoreDataStack.swift
//  Journal (Core Data)
//
//  Created by Kevin Stewart on 2/12/20.
//  Copyright © 2020 Kevin Stewart. All rights reserved.
//

import Foundation
import CoreData


class CoreDataStack {
    
    
    static let shared = CoreDataStack()
    
    private init() {}
    
    lazy var container: NSPersistentContainer = {
        let newContainer = NSPersistentContainer(name: "Journal (Core Data)")
        newContainer.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Failed to load persistent stores: \(error)")
            }
        }
        return newContainer
    }()
    
    
    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }
    
}


