//
//  AddCardViewController.swift
//  FlashCard-Final
//
//  Created by Brandon Lopez on 8/12/25.
//

import UIKit

protocol AddCardDelegate: AnyObject {
    func didAddCard(_ card: Flashcard)
}

class AddCardViewController: UIViewController {

    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var answerTextView: UITextView!

    weak var delegate: AddCardDelegate?

    @IBAction func saveTapped(_ sender: UIButton) {
        // Make sure user typed something
        guard let question = questionTextView.text, !question.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              let answer = answerTextView.text, !answer.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return
        }

        let newCard = Flashcard(question: question, answer: answer)
        delegate?.didAddCard(newCard) // Send back to main VC


        if presentingViewController != nil {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }

    @IBAction func cancelTapped(_ sender: UIButton) {
        // Same logic for cancel: dismiss or pop
        if presentingViewController != nil {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}
