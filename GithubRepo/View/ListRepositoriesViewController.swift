//
//  ListRepositoriesViewController.swift
//  GithubRepo
//
//  Created by Ândriu Felipe Coelho on 21/04/20.
//  Copyright © 2020 afcmobile. All rights reserved.
//

import UIKit

final class ListRepositoriesViewController: UIViewController {

    // MARK: - Attributes

    private(set) lazy var presenter = ListRepositoriesPresenter()
    var currentView: ListRepositoriesView {
        return view as! ListRepositoriesView
    }

    // MARK: - View life cycle

    override func loadView() {
        let mainView = ListRepositoriesView(presenter)
        mainView.delegate = self
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = currentView.title
        presenter.outputDelegate = self
        getRepositories()
    }

    // MARK: - Methods

    func getRepositories() {
        presenter.toggleLoading(value: true)
        LoadingViewManager(self).showLoading()
        presenter.search(page: presenter.page)
    }
}

extension ListRepositoriesViewController: ListRepositoriesViewDelegate {
    func requestRepository(view: ListRepositoriesView) {
        getRepositories()
    }
}

extension ListRepositoriesViewController: ListRepositoriesResultOutput {
    func updateViewState(state: ListRepositoriesViewState) {
        switch state {
        case .searchSuccess:
            presenter.incrementPage()
            currentView.reloadData()
        case .searchError:
            presenter.toggleLoading(value: false)
        case .completed:
            presenter.toggleLoading(value: true)
        }
        LoadingViewManager(self).hideLoading()
    }
}
