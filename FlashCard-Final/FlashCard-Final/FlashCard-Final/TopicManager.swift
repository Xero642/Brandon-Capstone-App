//
//  TopicManager.swift
//  FlashCard-Final
//
//  Created by Brandon Lopez on 8/12/25.
//

import Foundation

struct Topic: Codable {
    var title: String
    var cards: [Flashcard]
}

class TopicManager {
    private static let key = "topics"

    static func loadTopics() -> [Topic] {
        if let data = UserDefaults.standard.data(forKey: key),
           let topics = try? JSONDecoder().decode([Topic].self, from: data) {
            return topics
        }
        // Default: one "All Cards" topic with starter cards
        return [Topic(title: "All Cards", cards: [
            Flashcard(question: "What is 2+2?", answer: "4"),
            Flashcard(question: "Capital of Japan?", answer: "Tokyo")
        ])]
    }

    static func saveTopics(_ topics: [Topic]) {
        if let data = try? JSONEncoder().encode(topics) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    static func addTopic(title: String) {
        var topics = loadTopics()
        topics.append(Topic(title: title, cards: []))
        saveTopics(topics)
    }

    static func removeTopic(at index: Int) {
        var topics = loadTopics()
        guard topics.indices.contains(index) else { return }
        topics.remove(at: index)
        saveTopics(topics)
    }

    static func updateTopic(at index: Int, with cards: [Flashcard]) {
        var topics = loadTopics()
        guard topics.indices.contains(index) else { return }
        topics[index].cards = cards
        saveTopics(topics)
    }
}
