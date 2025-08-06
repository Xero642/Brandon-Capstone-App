//
//  FlashcardViewController.swift
//  Flash Card
//
//  Created by Brandon Lopez on 8/5/25.
//

import UIKit

class FlashcardViewController: UIViewController {
    var card: Flashcard!
    var flipped = false

    @IBOutlet weak var cardLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Flashcard"
        cardLabel.text = card.question
        cardLabel.isUserInteractionEnabled = true

        let tap = UITapGestureRecognizer(target: self, action: #selector(flipCard))
        cardLabel.addGestureRecognizer(tap)
    }

    @objc func flipCard() {
        flipped.toggle()
        UIView.transition(with: cardLabel, duration: 0.5, options: .transitionFlipFromRight, animations: {
            self.cardLabel.text = self.flipped ? self.card.answer : self.card.question
        }, completion: nil)
    }
}
