//
//  AddCardViewController.swift
//  Flash Card
//
//  Created by Brandon Lopez on 8/5/25.
//
import UIKit

class AddCardViewController: UIViewController {
    @IBOutlet weak var questionField: UITextField!
    @IBOutlet weak var answerField: UITextField!

    var topic: Topic! // Injected from DeckViewController

    @IBAction func saveTapped(_ sender: UIButton) {
        guard let q = questionField.text, !q.isEmpty,
              let a = answerField.text, !a.isEmpty else { return }

        let newCard = Flashcard(frontContent: q, backContent: a)
        topic.cards.append(newCard)
        dismiss(animated: true)
    }

    @IBAction func cancelTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
