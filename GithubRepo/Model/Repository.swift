//
//  Repository.swift
//  GithubRepo
//
//  Created by Ândriu Felipe Coelho on 22/04/20.
//  Copyright © 2020 afcmobile. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

struct Repository: Codable, Equatable {

    private enum CodingKeys: String, CodingKey {
        case id, title = "name", owner, stars = "stargazers_count"
    }

    // MARK: - Attributes

    private(set) var id: Int
    private(set) var title: String
    private(set) var owner: Owner
    private(set) var stars: Int

    // MARK: - Class methods

    static func serialize(response: AFDataResponse<Any>?) -> [Repository] {
        var repositories: [Repository] = []
        if let dictionaryResponse = response?.value as? [String: Any], let items = dictionaryResponse["items"] as? [[String: Any]] {
            for item in items {
                guard let jsonData = Repository.jsonToData(item) else { return [] }
                guard let repository = Repository.decodeJson(jsonData) else { return [] }
                repositories.append(repository)
            }
        }
        return repositories
    }

    static func jsonToData(_ json:[String: Any]) -> Data? {
        return try? JSONSerialization.data(withJSONObject: json, options: [])
    }

    static func decodeJson(_ jsonData: Data) -> Repository? {
        do {
            return try JSONDecoder().decode(Repository.self, from: jsonData)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    static func == (lhs: Repository, rhs: Repository) -> Bool {
        return lhs.id == rhs.id
    }
}

struct Owner: Codable {
    private enum CodingKeys: String, CodingKey {
        case imageUrl = "avatar_url"
    }
    private(set) var imageUrl: String
}
