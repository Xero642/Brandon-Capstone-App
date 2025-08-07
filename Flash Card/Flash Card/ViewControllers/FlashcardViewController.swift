//
//  FlashcardViewController.swift
//  Flash Card
//
//  Created by Brandon Lopez on 8/5/25.
//

import UIKit

class FlashcardViewController: UIViewController {
    var topic: Topic!
    var startingIndex: Int = 0
    var flipped = false

    @IBOutlet weak var cardLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Flashcard"
        setupGesture()
        showCurrentCard()
    }

    func setupGesture() {
        cardLabel.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(flipCard))
        cardLabel.addGestureRecognizer(tap)
    }

    func showCurrentCard() {
        let card = topic.cards[startingIndex]
        cardLabel.text = card.frontContent
        flipped = false
    }

    @objc func flipCard() {
        let card = topic.cards[startingIndex]
        flipped.toggle()
        UIView.transition(with: cardLabel, duration: 0.5, options: .transitionFlipFromRight, animations: {
            self.cardLabel.text = self.flipped ? card.backContent : card.frontContent
        }, completion: nil)
    }
}
