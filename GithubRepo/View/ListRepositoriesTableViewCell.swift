//
//  ListRepositoriesTableViewCell.swift
//  GithubRepo
//
//  Created by Ândriu Felipe Coelho on 23/04/20.
//  Copyright © 2020 afcmobile. All rights reserved.
//

import UIKit
import AlamofireImage

final class ListRepositoriesTableViewCell: UITableViewCell {

    // MARK: - Attributes

    static private(set) var identifier = "ListRepositoriesTableViewCell"

    private let horizontalStackView: UIStackView = {
        let horizontalStack = UIStackView()
        horizontalStack.axis = .horizontal
        horizontalStack.alignment = .fill
        horizontalStack.distribution = .fill
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false

        return horizontalStack
    }()

    private let verticalStackView: UIStackView = {
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .fill
        verticalStackView.distribution = .fillEqually
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false

        return verticalStackView
    }()

    private let backgroundImageView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .clear

        return view
    }()

    private let backgroundVerticalStackView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .clear

        return view
    }()

    private let repositoryImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false

        return image
    }()

    private let starImage: UIImageView = {
        let starIcon = UIImageView()
        starIcon.image = UIImage(named: "icon-star")
        starIcon.contentMode = .scaleAspectFill
        starIcon.clipsToBounds = true
        starIcon.translatesAutoresizingMaskIntoConstraints = false

        return starIcon
    }()

    private let repositoryNameLabel: UILabel = {
        let repositoryNameLabel = UILabel()
        repositoryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        repositoryNameLabel.font = UIFont(name: "Helvetica", size: 16.0)

        return repositoryNameLabel
    }()

    private let starsLabel: UILabel = {
        let starsLabel = UILabel()
        starsLabel.translatesAutoresizingMaskIntoConstraints = false
        starsLabel.font = UIFont(name: "Helvetica", size: 14.0)

        return starsLabel
    }()

    // MARK: - Methods

    func setupCell(_ repository: Repository) {
        addSubview(horizontalStackView)
        horizontalStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        horizontalStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        horizontalStackView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor).isActive = true
        horizontalStackView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor).isActive = true

        horizontalStackView.addArrangedSubview(backgroundImageView)
        backgroundImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        horizontalStackView.addArrangedSubview(verticalStackView)

        guard let url = URL(string: repository.owner.imageUrl) else { return }
        repositoryImage.af.setImage(withURL: url, placeholderImage: UIImage(named: "icon-placeholder"))
        backgroundImageView.addSubview(repositoryImage)
        repositoryImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
        repositoryImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
        repositoryImage.centerXAnchor.constraint(equalTo: backgroundImageView.centerXAnchor).isActive = true
        repositoryImage.centerYAnchor.constraint(equalTo: backgroundImageView.centerYAnchor).isActive = true

        verticalStackView.addArrangedSubview(repositoryNameLabel)
        repositoryNameLabel.text = repository.title

        verticalStackView.addArrangedSubview(backgroundVerticalStackView)
        backgroundVerticalStackView.addSubview(starImage)
        starImage.widthAnchor.constraint(equalToConstant: 15).isActive = true
        starImage.heightAnchor.constraint(equalToConstant: 15).isActive = true

        backgroundVerticalStackView.addSubview(starsLabel)
        starsLabel.text = "\(repository.stars)"
        starsLabel.leadingAnchor.constraint(equalTo: starImage.trailingAnchor, constant: 5).isActive = true
    }
}
