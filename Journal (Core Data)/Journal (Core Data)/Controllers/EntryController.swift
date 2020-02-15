//
//  EntryController.swift
//  Journal (Core Data)
//
//  Created by Kevin Stewart on 2/12/20.
//  Copyright © 2020 Kevin Stewart. All rights reserved.
//

import Foundation
import CoreData

class EntryController {
    
    var entries: [Entry] {
        loadFromPersistentStore()
    }
   
    
    private func saveToPersistentStore() {
        let moc = CoreDataStack.shared.mainContext
        do {
            try moc.save()
        } catch {
            moc.reset()
            print("Error saving to persistent store: \(error)")
        }
    }
    
    private func loadFromPersistentStore() -> [Entry] {
        let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
        let moc = CoreDataStack.shared.mainContext
        do {
           return try moc.fetch(fetchRequest)
        } catch {
            print("Error fetching: \(error)")
        }
        return []
    }
    
    private func createCRUD(title: String, bodyText: String, identifier: String, timestamp: Date, mood: String) {
        saveToPersistentStore()
    }
    
    private func updateCRUD(for entry: Entry, update title: String, update bodyText: String, update mood: String) {
        guard let entryList = entries.firstIndex(of: entry) else { return }
        
        entries[entryList].title = title
        entries[entryList].bodyText = bodyText
        entries[entryList].timestamp = Date()
        entries[entryList].mood = mood
        saveToPersistentStore()
    }
    
    
    private func deleteCRUD(for entry: Entry) {
        guard let entryList = entries.firstIndex(of: entry) else { return }
        let moc = CoreDataStack.shared.mainContext
        moc.delete(entries[entryList])
        saveToPersistentStore()
    }
    
    
    
}


