//
//  EntryRepresentation.swift
//  Journal (Core Data)
//
//  Created by Kevin Stewart on 2/18/20.
//  Copyright © 2020 Kevin Stewart. All rights reserved.
//

import Foundation

struct EntryRepresentation: Codable {
    var bodyText: String?
    var identifier: String?
    var mood: String
    var timestamp: Date
    var title: String
}
