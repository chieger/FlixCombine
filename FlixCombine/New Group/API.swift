//
//  API.swift
//  FlixCombine
//
//  Created by Charles Hieger on 4/14/20.
//  Copyright © 2020 Charles Hieger. All rights reserved.
//

import Foundation
import Combine

struct API {

    /// API Errors
    enum Error: LocalizedError {
        case addressUnreachable(URL)
        case invalidResponse
        case unableToCreateValidURL // ❓ Can we throw this when/if our URL formatiuon fails?
        case invalidStatusCode(Int)

        var errorDescription: String? {
            switch self {
            case .invalidResponse: return "🗑 The server responded with garbage"
            case .addressUnreachable(let url): return "☎️ \(url.absoluteString) is unreachable"
            case .unableToCreateValidURL: return "🤮 Unable to create a valid URL"
            case .invalidStatusCode(let code): return "🤯 Invalid status code: \(code))"
            }
        }
    }

    /// API Endpoints
    enum EndPoint {
        private static let scheme = "https"
        private static let host = "api.themoviedb.org"
        private static let apiKey = "3fc4c235756257eca55e964b82f1a1a6"

        case nowPlaying
        case upcomming
        case popular
        case topRated

        private var queryParams: [String: String?]? {
            switch self {
            default:
                return nil
            }
        }

        private var authParams: [String: String?]? {
            return ["api_key": EndPoint.apiKey]
        }

        private var path: String {
            switch self {
            case .nowPlaying:
                return "/3/movie/now_playing"
            case .upcomming:
                return "/3/movie/upcoming"
            case .popular:
                return "/3/movie/popular"
            case .topRated:
                return "/3/movie/top_rated"
            }
        }

        var url: URL {
            var components = URLComponents()
            components.scheme = EndPoint.scheme
            components.host = EndPoint.host
            components.path = path
            components.addQueryItems(with: queryParams)
            components.addQueryItems(with: authParams)
            let url = components.url! // ❓QUESTION: How to deal with optional URL here? Maybe handle in the request itself and throw error?
            print(url)
            return url
        }
    }

    /// A shared JSON decoder to use in calls.
    private var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    // ❓ How to make this more generic? i.e. accept different return types based on caller.
    // Should we be checking the response code?
    func getMovies(_ endpoint: API.EndPoint) -> AnyPublisher<MovieResponse, Error> {
        URLSession.shared
        .dataTaskPublisher(for: endpoint.url)
        .tryFilter { (_, response) -> Bool in // ❓ Does this seem right for checing the code? Is there a range of codes to check for?
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { throw Error.invalidResponse }
            guard statusCode == 200 else { throw Error.invalidStatusCode(statusCode) }
            return true
        }
        .map(\.data) // ❓ Is using a keypath just kind of a syntactic sugar shortcut? We could do the samething with transform closure?
        .decode(type: MovieResponse.self, decoder: decoder)
        .mapError { error -> API.Error in
            switch error {
            case is URLError:
                return Error.addressUnreachable(endpoint.url)
            default:
                return Error.invalidResponse
            }
        }
        .eraseToAnyPublisher()
    }
}

extension URLComponents {

    /// Converts the given parameters to an array of `URLQueryItem` and adds them to the `queryItems` array for the `URLComponent`.
    /// - Parameter parameters: The `[String: String?]?` dictionary of parameteres
    mutating func addQueryItems(with parameters: [String: String?]?) {
        guard let params = parameters else { return }
        let newItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        let existingItems = queryItems ?? [URLQueryItem]()
        queryItems = existingItems + newItems
    }
}
