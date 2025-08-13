//
// TopicsViewController.swift
// FlashCard-Final
//
// Created by Brandon Lopez on 8/12/25.
//

import UIKit

class TopicsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private var topics: [Topic] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        navigationItem.title = "Topics"
        loadTopics()
    }

    func loadTopics() {
        topics = TopicManager.loadTopics()
        tableView.reloadData()
    }

    @IBAction func addTopicTapped(_ sender: UIBarButtonItem) {
        let ac = UIAlertController(title: "New Topic", message: "Enter a topic name", preferredStyle: .alert)
        ac.addTextField { tf in
            tf.placeholder = "Topic name"
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "Add", style: .default) { _ in
            if let name = ac.textFields?.first?.text, !name.trimmingCharacters(in: .whitespaces).isEmpty {
                TopicManager.addTopic(title: name)
                self.loadTopics()
            }
        })
        present(ac, animated: true)
    }

    // Prepare for segue to card ViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowTopicCards",
           let dest = segue.destination as? ViewController,
           let index = sender as? Int {
            dest.topicIndex = index
        }
    }
}

// MARK: - Table View DataSource / Delegate
extension TopicsViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        topics.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let reuseId = "TopicCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId) ??
                   UITableViewCell(style: .subtitle, reuseIdentifier: reuseId)
        let topic = topics[indexPath.row]
        cell.textLabel?.text = topic.title
        cell.detailTextLabel?.text = "\(topic.cards.count) cards"
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    // On tap, push your existing ViewController with the selected topic index
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ShowTopicCards", sender: indexPath.row)
    }

    // Allow swipe-to-delete topics
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            TopicManager.removeTopic(at: indexPath.row)
            loadTopics()
        }
    }
}
