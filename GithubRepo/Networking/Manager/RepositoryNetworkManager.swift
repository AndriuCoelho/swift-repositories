//
//  RepositoryNetworkManager.swift
//  GithubRepo
//
//  Created by Ândriu Felipe Coelho on 22/04/20.
//  Copyright © 2020 afcmobile. All rights reserved.
//

import Foundation
import Alamofire

struct RepositoryNetworkManager {
    static func getRepositories(_ page: Int, _ quantityResults: Int,
                                completion: @escaping(_ results: [Repository], _ error: Error?) -> Void) {
        AF.request(RepositoryEndpoint.search("\(page)", "\(quantityResults)")).responseJSON(completionHandler: { response in
            let repositories = Repository.serialize(response: response)
            completion(repositories, response.error)
        })
    }
}
