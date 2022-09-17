//
//  Copyright © 2022 Ohlulu. All rights reserved.
//

import Combine
import Foundation

public final class URLSessionHTTPClient: HTTPClient {

    private struct UnexpectedValuesRepresentation: Error {}

    private let session: URLSession

    public init(session: URLSession) {
        self.session = session
    }

    public func get(from url: URL) -> AnyPublisher<(Data, HTTPURLResponse), Error> {
        session.dataTaskPublisher(for: url)
            .tryMap { result in
                guard let httpURLResponse = result.response as? HTTPURLResponse else {
                    throw UnexpectedValuesRepresentation()
                }
                return (result.data, httpURLResponse)
            }
            .mapError { $0 }
            .eraseToAnyPublisher()
    }
}
