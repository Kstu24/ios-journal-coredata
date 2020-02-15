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
    @discardableResult
    convenience init(title: String, bodyText: String, mood: MoodSwing = .😐, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        self.init(context: context)
        self.title = title
        self.bodyText = bodyText
        self.mood = mood.rawValue
//        self.identifier = identifier
//        self.timestamp = timestamp
    }
}
