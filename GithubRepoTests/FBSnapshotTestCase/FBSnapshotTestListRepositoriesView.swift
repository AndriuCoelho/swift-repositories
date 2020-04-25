//
//  FBSnapshotTestListRepositoriesView.swift
//  GithubRepoTests
//
//  Created by Ândriu Felipe Coelho on 25/04/20.
//  Copyright © 2020 afcmobile. All rights reserved.
//

import FBSnapshotTestCase
@testable import GithubRepo

class FBSnapshotTestListRepositoriesView: FBSnapshotTestCase {

    override func setUp() {
        super.setUp()
        self.recordMode = false
    }

    func testVerifyView() {
        let listRepositoriesViewController = ListRepositoriesViewController()

        

        FBSnapshotVerifyView(listRepositoriesViewController.view)
    }
}
