//
//  RepositoryTests.swift
//  GithubRepoTests
//
//  Created by Ândriu Felipe Coelho on 25/04/20.
//  Copyright © 2020 afcmobile. All rights reserved.
//

import XCTest
@testable import GithubRepo

class RepositoryTests: XCTestCase {

    // MARK: - Attributes

    override func setUp() {
        super.setUp()
    }

    override func tearDownWithError() throws { }

    // MARK: - Test methods

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

    func testSerialize() {
        guard let jsonMock = getJsonMock() else { return }
        let items = jsonMock["items"] as? [[String: Any]]
        guard let jsonRepository = items?.first else { return }
        let data = Repository.jsonToData(jsonRepository)

        XCTAssertNotNil(data)
    }

    func testDecodeJson() {
        guard let jsonMock = getJsonMock() else { return }
        let items = jsonMock["items"] as? [[String: Any]]
        guard let jsonRepository = items?.first else { return }
        guard let data = Repository.jsonToData(jsonRepository) else { return }

        let repository = Repository.decodeJson(data)

        XCTAssertNotNil(repository)
    }
}
