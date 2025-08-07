//
//  DeckViewController.swift
//  Flash Card
//
//  Created by Brandon Lopez on 8/5/25.
//

import UIKit

class DeckViewController: UITableViewController {
    var topic: Topic!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = topic.name
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                             target: self,
                                                             action: #selector(addCard))
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topic.cards.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let card = topic.cards[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath)
        cell.textLabel?.text = card.frontContent
        return cell
    }

    @objc func addCard() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddCardVC") as! AddCardViewController
        vc.topic = topic
        navigationController?.pushViewController(vc, animated: true)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "FlashCardVC") as! FlashcardViewController
        vc.topic = topic
        vc.startingIndex = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
    }
}
