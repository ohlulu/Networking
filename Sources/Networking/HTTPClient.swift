//
//  Copyright © 2022 Ohlulu. All rights reserved.
//

import Combine
import Foundation

public protocol HTTPClient {
    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    func get(from url: URL) -> AnyPublisher<(Data, HTTPURLResponse), Error>
}
