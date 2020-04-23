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
    
    var entries: [Entry]?
    
    var baseURL = URL(string: "https://journal-4fecc.firebaseio.com/")!
    typealias CompletionHandler = (Error?) -> Void
    
    //PUTting the entry onto firebase
    private func put(entry: Entry, completion: @escaping CompletionHandler = { _ in}) {
        let uuid = entry.identifier ?? UUID()
        let requestURL = baseURL.appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = "PUT"
        
        do {
            guard var representation = entry.entryRepresntation else {
                completion(NSError())
                return
            }
            representation.identifier = uuid.uuidString
            entry.identifier = uuid
            try saveToPersistentStore()
            request.httpBody = try JSONEncoder().encode(representation)
            } catch {
                print("Error encoding entry \(entry): \(error)")
                completion(error)
                return
        }
        
       URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard error == nil else {
                print("Error PUTting task to server: \(error!)")
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            DispatchQueue.main.async {
                completion(nil)
            }
        }.resume()
    }
    
    // Deleting from firebase
    func deleteEntryFromServer(_ entry: Entry, completion: @escaping CompletionHandler = { _ in }) {
        guard let uuid = entry.identifier else {
            completion(NSError())
            return
        }
        let requestURL = baseURL.appendingPathComponent(uuid.uuidString).appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            guard error == nil else {
                print("Error deleting task: \(error!)")
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            DispatchQueue.main.async {
                completion(nil)
            }
        }.resume()
    }
    
    private func update(entry: Entry) {
        
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
    
//    private func loadFromPersistentStore() -> [Entry] {
//        let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
//        let moc = CoreDataStack.shared.mainContext
//        do {
//           return try moc.fetch(fetchRequest)
//        } catch {
//            print("Error fetching: \(error)")
//        }
//        return []
//    }
    
    private func createCRUD(title: String, bodyText: String, identifier: String, timestamp: Date, mood: String) {
        put(entry: Entry())
        saveToPersistentStore()
    }
    
    private func updateCRUD(for entry: Entry, update title: String, update bodyText: String, update mood: String) {
        guard let entryList = entries!.firstIndex(of: entry) else { return }
        
        entries?[entryList].title = title
        entries?[entryList].bodyText = bodyText
        entries?[entryList].timestamp = Date()
        entries?[entryList].mood = mood
        put(entry: Entry())
        saveToPersistentStore()
    }
    
    
    private func deleteCRUD(for entry: Entry) {
        guard let entryList = entries?.firstIndex(of: entry) else { return }
        let moc = CoreDataStack.shared.mainContext
        moc.delete((entries?[entryList])!)
        deleteEntryFromServer(entry)
        saveToPersistentStore()
    }
    
    
    
}


