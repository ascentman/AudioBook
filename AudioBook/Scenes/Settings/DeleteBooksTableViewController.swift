//
//  DeleteBooksTableViewController.swift
//  AudioBook
//
//  Created by user on 5/24/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

final class DeleteBooksTableViewController: UITableViewController {

    @IBOutlet private weak var bookTitleLabel: UILabel!

    private var foundBooks: [String] = []
    private let fileHandler = FileHandler()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupFoundBooks()
        tableView.tableFooterView = UIView()
    }

    @IBAction func editPressed(_ sender: UIBarButtonItem) {
        tableView.isEditing = !tableView.isEditing
        sender.title = tableView.isEditing ? "Завершити" : "Редагувати"
    }

    // MARK: - Data Source & Deledate

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foundBooks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DeleteBookTableViewCell.description(), for: indexPath) as? DeleteBookTableViewCell
        cell?.setBook(name: foundBooks[indexPath.row])
        return cell ?? UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Видалити") { [weak self] (_, _, _) in
            self?.deleteBook(indexPath: indexPath)
        }
        deleteAction.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }

    // MARK: - Private

    private func setupFoundBooks() {
        let arrayOfBookLabels = fileHandler.createBookArray()
        for label in arrayOfBookLabels {
            if let name = BooksDict[label] {
                foundBooks.append(name)
            }
        }
    }

    private func deleteBook(indexPath: IndexPath) {
        if let bookLabel = BooksDict.someKey(forValue: foundBooks[indexPath.row]) {
            let book = BookOnline(label: bookLabel, previewURL: URL(string: "/")!, chaptersCount: 0)
            fileHandler.remove(book: book, completion: { result in
                if result {
                    foundBooks.remove(at: indexPath.row)
                    tableView.reloadData()
                }
            })
        }
    }
}
