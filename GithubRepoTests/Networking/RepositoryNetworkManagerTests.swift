//
//  RepositoryNetworkManagerTests.swift
//  GithubRepoTests
//
//  Created by Ândriu Felipe Coelho on 25/04/20.
//  Copyright © 2020 afcmobile. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import GithubRepo

class RepositoryNetworkManagerTests: XCTestCase {

    // MARK: - Attributes

    private let path = "api.github.com"

    // MARK: - Setup

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: - Test Methods

    func getJsonMock() -> [String: Any]? {
        if let filePath = Bundle(for: type(of: self)).path(forResource: "repositories-mock", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: filePath), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let result = jsonResult as? [String: Any] {
                    return result
                }
              } catch {
                print(error.localizedDescription)
              }
        }
        return nil
    }

    func testGetRepositories() {
        guard let json = getJsonMock() else {
            fatalError("error to read json file")
        }

        stub(condition: isHost(path)) { (_ ) -> HTTPStubsResponse in
            return HTTPStubsResponse(jsonObject: json, statusCode: 200, headers: [:])
        }

        let expectation = self.expectation(description: "calls the callback with a resource json")

        let page = 1, quantityResult = 10
        RepositoryNetworkManager.getRepositories(page, quantityResult) { (repositoryList, error) in
            if error == nil {
                XCTAssertNotNil(repositoryList)
                XCTAssertEqual(10, repositoryList.count)
                expectation.fulfill()
            } else {
                XCTFail(error!.localizedDescription)
                expectation.fulfill()
            }
        }
        self.waitForExpectations(timeout: 1.5, handler: nil)
    }
}
