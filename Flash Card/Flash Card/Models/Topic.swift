//
//  Topic.swift
//  Flash Card
//
//  Created by Brandon Lopez on 8/6/25.
//

import Foundation

class Topic: Codable {
    var name: String
    var cards: [Flashcard]
    var createdDate: Date

    init(name: String) {
        self.name = name
        self.cards = []
        self.createdDate = Date()
    }
}
