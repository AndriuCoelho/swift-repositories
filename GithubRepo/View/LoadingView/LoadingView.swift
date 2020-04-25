//
//  LoadingView.swift
//  GithubRepo
//
//  Created by Ândriu Felipe Coelho on 22/04/20.
//  Copyright © 2020 afcmobile. All rights reserved.
//

import UIKit
import Lottie

class LoadingView: UIView {

    // MARK: - Initializer
    
    class func instance() -> LoadingView {
        let view = LoadingView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.height))
        view.backgroundColor = UIColor(white: 1, alpha: 0.5)
        view.tag = LoadingView.viewIdentifier
        view.configure()

        return view
    }

    // MARK: - Attributes

    static var viewIdentifier = 99

    // MARK: - Method

    func configure() {
        let animationView = AnimationView(name: "loading-animation-circle")
        animationView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        animationView.center = self.center
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        animationView.play()
        addSubview(animationView)
    }
}
