//
//  ListRepositoriesViewTest.swift
//  GithubRepoTests
//
//  Created by Ândriu Felipe Coelho on 26/04/20.
//  Copyright © 2020 afcmobile. All rights reserved.
//

import XCTest
@testable import GithubRepo

class ListRepositoriesViewTests: XCTestCase {

    var repositoryView: ListRepositoriesView!

    // MARK: - Setup

    override func setUp() {
        super.setUp()
        let presenter = ListRepositoriesPresenter()
        repositoryView = ListRepositoriesView(presenter)
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: - Test methods

    func testTableViewDataSourceShouldNotNilAfterInstance() {
        XCTAssertNotNil(repositoryView.repositoryTableView.dataSource)
    }

    func testTableViewDelegateShouldNotNilAfterInstance() {
        XCTAssertNotNil(repositoryView.repositoryTableView.delegate)
    }
}
