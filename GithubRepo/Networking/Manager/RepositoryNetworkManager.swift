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

    @discardableResult
    private static func performRequest(route: RepositoryEndpoint, completion: @escaping(AFDataResponse<Any>?) -> Void) -> DataRequest {
        return AF.request(route).validate().responseJSON(completionHandler: { response in
            completion(response)
        })
    }

    static func getRepositories(_ page: Int, _ quantityResults: Int,
                                completion: @escaping(_ results: [Repository], _ error: Error?) -> Void) {
        performRequest(route: .search("\(page)", "\(quantityResults)"),
                       completion: { response in
                        let repositories = Repository.serialize(response: response)
                        completion(repositories, response?.error)
        })
    }
}
