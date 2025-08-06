//
//  AddCardViewController.swift
//  Flash Card
//
//  Created by Brandon Lopez on 8/5/25.
//

import UIKit

protocol AddCardDelegate: AnyObject {
    func didAddCard(_ card: Flashcard)
}

class AddCardViewController: UIViewController {
    @IBOutlet weak var questionField: UITextField!
    @IBOutlet weak var answerField: UITextField!
    
    weak var delegate: AddCardDelegate?

    @IBAction func saveTapped(_ sender: UIButton) {
        guard let q = questionField.text, !q.isEmpty,
              let a = answerField.text, !a.isEmpty else { return }

        let newCard = Flashcard(question: q, answer: a)
        delegate?.didAddCard(newCard)
        dismiss(animated: true)
    }

    @IBAction func cancelTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
