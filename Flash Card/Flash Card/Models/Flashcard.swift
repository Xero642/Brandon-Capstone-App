//
//  Flashcard.swift
//  Flash Card
//
//  Created by Brandon Lopez on 8/5/25.
//

import Foundation

class Flashcard: Codable {
    var frontContent: String
    var backContent: String
    var createdDate: Date

    init(frontContent: String = "", backContent: String = "") {
        self.frontContent = frontContent
        self.backContent = backContent
        self.createdDate = Date()
    }
}
