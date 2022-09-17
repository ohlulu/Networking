//
//  Copyright © 2022 Ohlulu. All rights reserved.
//

import Foundation

public struct Request {
    public var method: String
    public var baseURL: URL
    public var path: String
    public var query: [(String, String)]?
    public var headers: [String: String]?
    
    public init(method: String, baseURL: URL, path: String, query: [(String, String)]? = nil, headers: [String : String]? = nil) {
        self.method = method
        self.baseURL = baseURL
        self.path = path
        self.query = query
        self.headers = headers
    }
}

extension Request {
    
    func makeRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: try makeURL())
        urlRequest.httpMethod = method
        urlRequest.allHTTPHeaderFields = headers
        return urlRequest
    }
    
    private func makeURL() throws -> URL {
        guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false) else {
            throw URLError(.badURL)
        }
        components.path = path
        if let query = query, !query.isEmpty {
            components.queryItems = query.map(URLQueryItem.init)
        }
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        return url
    }
}
