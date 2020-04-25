//
//  LoadingViewManager.swift
//  GithubRepo
//
//  Created by Ândriu Felipe Coelho on 22/04/20.
//  Copyright © 2020 afcmobile. All rights reserved.
//

import UIKit

class LoadingViewManager {

    // MARK: - Attributes

    private var currentController: UIViewController
    lazy var loadingView = LoadingView.instance()

    // MARK: - Initializer

    init(_ controller: UIViewController) {
        self.currentController = controller
    }

    // MARK: - Methods

    private func hideNavigationBar(_ isHidden: Bool) {
        currentController.navigationController?.navigationBar.isHidden = isHidden
    }

    func showLoading() {
        let window = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
        window?.addSubview(loadingView)
    }

    func hideLoading() {
        let window = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
        let view = window?.viewWithTag(LoadingView.viewIdentifier)
        view?.removeFromSuperview()
    }
}
