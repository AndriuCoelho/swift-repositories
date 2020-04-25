//
//  ListRepositoriesView.swift
//  GithubRepo
//
//  Created by Ândriu Felipe Coelho on 21/04/20.
//  Copyright © 2020 afcmobile. All rights reserved.
//

import UIKit

protocol ListRepositoriesViewDelegate: class {
    func requestRepository(view: ListRepositoriesView)
}

class ListRepositoriesView: UIView {

    // MARK: - Attributes

    weak var delegate: ListRepositoriesViewDelegate?
    private(set) var title = "Top Swift Repositories"
    private(set) var presenter: ListRepositoriesPresenter

    lazy private var repositoryTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(ListRepositoriesTableViewCell.self, forCellReuseIdentifier: ListRepositoriesTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self

        return tableView
    }()

    private(set) lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshList(_:)), for: .valueChanged)

        return refreshControl
    }()

    // MARK: - Init

    init(_ presenter: ListRepositoriesPresenter) {
        self.presenter = presenter
        super.init(frame: UIScreen.main.bounds)
        customize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    private func customize() {
        addSubview(repositoryTableView)
        repositoryTableView.addSubview(refreshControl)
        repositoryTableView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        repositoryTableView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        repositoryTableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        repositoryTableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    private func requestMore(_ indexPath: IndexPath) -> Bool {
        return indexPath.row == presenter.repositories.count - 1 ? true : false
    }

    func reloadData() {
        repositoryTableView.reloadData()
    }

    // MARK: - Actions

    @objc func refreshList(_ sender: UIRefreshControl) {
        sender.endRefreshing()
        delegate?.requestRepository(view: self)
    }
}

extension ListRepositoriesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.repositories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListRepositoriesTableViewCell.identifier, for: indexPath) as? ListRepositoriesTableViewCell  else {
            fatalError("Error to create TableViewCell")
        }
        let repository = presenter.repositories[indexPath.item]
        cell.setupCell(repository)

        return cell
    }
}

extension ListRepositoriesView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if requestMore(indexPath) {
            delegate?.requestRepository(view: self)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}
