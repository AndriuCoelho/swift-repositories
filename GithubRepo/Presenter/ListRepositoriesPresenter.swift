//
//  ListRepositoriesPresenter.swift
//  GithubRepo
//
//  Created by Ândriu Felipe Coelho on 21/04/20.
//  Copyright © 2020 afcmobile. All rights reserved.
//

import Foundation

enum ListRepositoriesViewState {
    case searchError, searchSuccess
}

protocol ListRepositoriesResultOutput: class {
    func updateViewState(state: ListRepositoriesViewState)
}

class ListRepositoriesPresenter {

    // MARK: - Attributes
    
    private(set) var page = 0
    private(set) var repositories: [Repository] = []
    weak var outputDelegate: ListRepositoriesResultOutput?

    // MARK: - Class methods

    func incrementPage() {
        page += 1
    }

    func addRepository(new: Repository) {
        repositories.append(new)
    }

    func search(page: Int, quantityResults: Int = 50) {
        RepositoryNetworkManager.getRepositories(page, quantityResults) { (repositoryList, error) in
            DispatchQueue.main.async {
                repositoryList.forEach({
                    if !self.repositories.contains($0) {
                        self.addRepository(new: $0)
                    }
                })
                self.outputDelegate?.updateViewState(state: error == nil ? .searchSuccess : .searchError)
            }
        }
    }
}
