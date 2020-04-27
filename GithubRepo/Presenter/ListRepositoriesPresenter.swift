//
//  ListRepositoriesPresenter.swift
//  GithubRepo
//
//  Created by Ândriu Felipe Coelho on 21/04/20.
//  Copyright © 2020 afcmobile. All rights reserved.
//

import Foundation

enum ListRepositoriesViewState {
    case searchError, searchSuccess, completed
}

protocol ListRepositoriesResultOutput: class {
    func updateViewState(state: ListRepositoriesViewState)
}

class ListRepositoriesPresenter {

    // MARK: - Attributes
    
    private(set) var page = 1
    private(set) var isLoading = false
    private(set) var repositories: [Repository] = []
    weak var outputDelegate: ListRepositoriesResultOutput?

    // MARK: - Class methods

    func incrementPage() {
        page += 1
    }

    func toggleLoading(value: Bool) {
        isLoading = value
    }

    func addRepository(new: Repository) {
        repositories.append(new)
        repositories.sort(by: { $0.stars > $1.stars })
    }

    func search(page: Int, quantityResults: Int = 100) {
        RepositoryNetworkManager.getRepositories(page, quantityResults) { (repositoryList, error) in
            repositoryList.forEach({
                if !self.repositories.contains($0) {
                    self.addRepository(new: $0)
                }
            })
            if repositoryList.count == 0 {
                self.outputDelegate?.updateViewState(state: .completed)
                return
            }
            DispatchQueue.main.async {
                self.outputDelegate?.updateViewState(state: error == nil ? .searchSuccess : .searchError)
            }
        }
    }
}
