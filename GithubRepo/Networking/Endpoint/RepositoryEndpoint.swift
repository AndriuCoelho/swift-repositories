//
//  RepositoryEndpoint.swift
//  GithubRepo
//
//  Created by Ândriu Felipe Coelho on 21/04/20.
//  Copyright © 2020 afcmobile. All rights reserved.
//

import Alamofire

enum RepositoryEndpoint: APIConfiguration {

    case search(_ page: String, _ quantityResults: String)

    var method: HTTPMethod {
        switch self {
        case .search:
            return .get
        }
    }

    var path: String {
        switch self {
        case .search(let page, let quantityResults):
            return "search/repositories?q=language:swift&sort=stars&page=\(page)&per_page=\(quantityResults)"
        }
    }

    var parameters: Parameters? {
        switch self {
        case .search:
            return nil
        }
    }

    func asURLRequest() throws -> URLRequest {
        let baseURL = EndpointSetting.ProductionServer.baseURL + path

        guard let encodedUrl = baseURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
            fatalError("error to create encodedUrl")
        }

        guard let url = URL(string: encodedUrl) else {
            fatalError("error to create baseURL")
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)

        if let parameters = parameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }

        return request
    }
}
