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

    private enum Constants {
        static let done = "Готово"
        static let edit = "Редагувати"
        static let delete = "Видалити"
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupFoundBooks()
        setEmptyState()
        tableView.tableFooterView = UIView()
    }

    @IBAction func editPressed(_ sender: UIBarButtonItem) {
        tableView.isEditing = !tableView.isEditing
        sender.title = tableView.isEditing ? Constants.done  : Constants.edit
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
        let deleteAction = UIContextualAction(style: .destructive, title: Constants.delete) { [weak self] (_, _, _) in
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
                    setEmptyState()
                }
            })
        }
    }

    private func setEmptyState() {
        if foundBooks.isEmpty {
            tableView.setEmptyMessage("Ще немає завантажень")
        } else {
            tableView.restore()
        }
    }
}

extension UITableView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .lightGray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "Charter", size: 22)!
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
