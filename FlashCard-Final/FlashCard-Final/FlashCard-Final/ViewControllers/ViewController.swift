//
// ViewController.swift
// FlashCard-Final
//
// Created by Brandon Lopez on 8/12/25.
// Modified to support loading/saving flashcards for a given topicIndex.
//

import UIKit

class ViewController: UIViewController, AddCardDelegate {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!

    // If this VC is opened for a selected topic, TopicsViewController will set this.
    // If nil, the VC will use the old single-list UserDefaults behavior.
    var topicIndex: Int?

    // Flashcards array (saves automatically when changed)
    var flashcards: [Flashcard] = [] {
        didSet {
            saveFlashcards()
        }
    }

    var currentIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        loadFlashcards()
        updateCard()
    }

    // MARK: - AddCardDelegate
    func didAddCard(_ card: Flashcard) {
        flashcards.append(card)
        currentIndex = flashcards.count - 1 // show the new card
        updateCard()
    }

    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowAddCard" {
            if let addCardVC = segue.destination as? AddCardViewController {
                addCardVC.delegate = self
            }
        }
    }

    // MARK: - Actions

    // Show answer
    @IBAction func showAnswerTapped(_ sender: UIButton) {
        answerLabel.isHidden = false
    }

    // Next card
    @IBAction func nextTapped(_ sender: UIButton) {
        if flashcards.isEmpty { return }
        currentIndex = (currentIndex + 1) % flashcards.count
        updateCard()
    }

    // Previous card
    @IBAction func previousTapped(_ sender: UIButton) {
        if flashcards.isEmpty { return }
        currentIndex = (currentIndex - 1 + flashcards.count) % flashcards.count
        updateCard()
    }

    // Delete card
    @IBAction func deleteTapped(_ sender: UIButton) {
        if flashcards.isEmpty { return }
        flashcards.remove(at: currentIndex)

        if flashcards.isEmpty {
            currentIndex = 0
        } else if currentIndex >= flashcards.count {
            currentIndex = 0
        }

        updateCard()
    }

    // MARK: - UI update
    func updateCard() {
        if flashcards.isEmpty {
            questionLabel.text = "No cards available"
            answerLabel.text = ""
            answerLabel.isHidden = true
            return
        }

        let card = flashcards[currentIndex]
        questionLabel.text = card.question
        answerLabel.text = card.answer
        answerLabel.isHidden = true
    }

    // MARK: - Persistence (topic-aware)
    func saveFlashcards() {
        if let idx = topicIndex {
            // Save into that topic
            TopicManager.updateTopic(at: idx, with: flashcards)
        } else {
            // Fallback to old single-list behavior (keeps backwards compatibility)
            if let data = try? JSONEncoder().encode(flashcards) {
                UserDefaults.standard.set(data, forKey: "flashcards")
            }
        }
    }

    func loadFlashcards() {
        if let idx = topicIndex {
            let topics = TopicManager.loadTopics()
            if topics.indices.contains(idx) {
                flashcards = topics[idx].cards
                // also set title of nav to topic title if inside nav controller
                self.title = topics[idx].title
            } else {
                flashcards = []
            }
        } else {
            if let data = UserDefaults.standard.data(forKey: "flashcards"),
               let savedCards = try? JSONDecoder().decode([Flashcard].self, from: data) {
                flashcards = savedCards
            } else {
                // Default starter cards
                flashcards = [
                    Flashcard(question: "What is 2+2?", answer: "4"),
                    Flashcard(question: "Capital of Japan?", answer: "Tokyo")
                ]
            }
        }
    }
}
