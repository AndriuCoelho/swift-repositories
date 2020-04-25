//
//  EndpointSetting.swift
//  GithubRepo
//
//  Created by Ândriu Felipe Coelho on 21/04/20.
//  Copyright © 2020 afcmobile. All rights reserved.
//

import Foundation
import Alamofire

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}

struct EndpointSetting {
    struct ProductionServer {
        static let baseURL = "https://api.github.com/"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
