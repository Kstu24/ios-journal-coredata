//
//  Entry+Convenience.swift
//  Journal (Core Data)
//
//  Created by Kevin Stewart on 2/12/20.
//  Copyright © 2020 Kevin Stewart. All rights reserved.
//

import Foundation
import CoreData

enum MoodSwing: String {
    case 🤬
    case 😐
    case 😄
    
    static var allMoods: [MoodSwing] {
        return [.🤬, .😐, .😄]
    }
}

extension Entry {
    
    var entryRepresntation: EntryRepresentation? {
        guard let title = title,
            let mood = mood else {
                return nil
        }
        
        return EntryRepresentation(bodyText: bodyText,
                                   identifier: identifier?.uuidString,
                                   mood: mood,
                                   timestamp: timestamp ?? Date(),
                                   title: title)
    }
    
    @discardableResult
    convenience init(title: String,
                     bodyText: String?,
                     mood: MoodSwing = .😐,
                     identifier: UUID? = UUID(),
                     timestamp: Date,
                     context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        self.init(context: context)
        self.title = title
        self.bodyText = bodyText
        self.mood = mood.rawValue
        self.identifier = identifier
        self.timestamp = timestamp
    }
}
