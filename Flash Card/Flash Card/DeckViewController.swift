//
//  DeckViewController.swift
//  Flash Card
//
//  Created by Brandon Lopez on 8/5/25.
//

import UIKit

class DeckViewController: UITableViewController {
    var flashcards: [Flashcard] = [
        Flashcard(question: "Capital of France?", answer: "Paris"),
        Flashcard(question: "2 + 2", answer: "4")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Flashcards"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCard))
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flashcards.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let card = flashcards[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath)
        cell.textLabel?.text = card.question
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCard = flashcards[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "FlashcardVC") as! FlashcardViewController
        vc.card = selectedCard
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func addCard() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddCardVC") as! AddCardViewController
        vc.delegate = self
        present(vc, animated: true)
    }
}

extension DeckViewController: AddCardDelegate {
    func didAddCard(_ card: Flashcard) {
        flashcards.append(card)
        tableView.reloadData()
    }
}
