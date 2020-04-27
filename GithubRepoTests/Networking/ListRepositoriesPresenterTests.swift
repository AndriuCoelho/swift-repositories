//
//  ListRepositoriesPresenterTests.swift
//  GithubRepoTests
//
//  Created by Ândriu Felipe Coelho on 27/04/20.
//  Copyright © 2020 afcmobile. All rights reserved.
//

import XCTest
@testable import GithubRepo

class ListRepositoriesPresenterTests: XCTestCase {

    // MARK: - Attributes

    private var presenter: ListRepositoriesPresenter!

    // MARK: - Setup

    override func setUp() {
        super.setUp()
        presenter = ListRepositoriesPresenter()
    }

    override func tearDownWithError() throws { }

    // MARK: - Test methods

    func testIncrementPage() {
        XCTAssertEqual(1, presenter.page)
        presenter.incrementPage()
        XCTAssertEqual(2, presenter.page)
    }

    func testToggleLoading() {
        XCTAssertFalse(presenter.isLoading)
        presenter.toggleLoading(value: true)
        XCTAssertTrue(presenter.isLoading)
    }

    func testAddRepository() {
        let alamofire = Repository(id: 1, title: "Alamofire", owner: Owner(imageUrl: ""), stars: 100)
        presenter.addRepository(new: alamofire)
        XCTAssertEqual(1, presenter.repositories.count)

        let alamofireImage = Repository(id: 2, title: "Alamofire Image", owner: Owner(imageUrl: ""), stars: 150)
        presenter.addRepository(new: alamofireImage)
        XCTAssertEqual(2, presenter.repositories.count)

        let awesomeIos = Repository(id: 3, title: "awesome-ios", owner: Owner(imageUrl: ""), stars: 200)
        presenter.addRepository(new: awesomeIos)
        XCTAssertEqual(3, presenter.repositories.count)

        guard let first = presenter.repositories.first else { return }
        XCTAssertEqual(3, first.id)
        XCTAssertEqual("awesome-ios", first.title)
        XCTAssertEqual(200, first.stars)
    }
}
