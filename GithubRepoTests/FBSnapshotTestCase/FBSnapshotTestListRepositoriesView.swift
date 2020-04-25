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

        let awesome = Repository(id: 2, title: "awesome-ios",
        owner: Owner(imageUrl: "https://avatars2.githubusercontent.com/u/484656?v=4"),
        stars: 34700)
        listRepositoriesViewController.presenter.addRepository(new: awesome)

        let alamofire = Repository(id: 1, title: "Alamofire",
                                    owner: Owner(imageUrl: "https://avatars3.githubusercontent.com/u/7774181?v=4"),
                                    stars: 33356)
        listRepositoriesViewController.presenter.addRepository(new: alamofire)

        FBSnapshotVerifyView(listRepositoriesViewController.view)
    }
}
