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

        var errorDescription: String? {
            switch self {
            case .invalidResponse: return "🗑 The server responded with garbage"
            case .addressUnreachable(let url): return "☎️ \(url.absoluteString) is unreachable"
            }
        }
    }

    /// API Endpoints
    enum EndPoint {

        case nowPlaying
        case image(String)

        /// Query parameters needed for authentication, in this case, the api key.
        private var authenticationQueryParameters: [String: String?]? {
            switch self {
            case .nowPlaying:
                return ["api_key": "3fc4c235756257eca55e964b82f1a1a6"]
            case .image:
                return nil
            }
        }

        /// The path for the specified endpoint.
        private var path: String {
            switch self {
            case .nowPlaying:
                return "/3/movie/now_playing"
            case .image(let url):
                return "/t/p/w300" + url
            }
        }

        /// The host for the specified endpoint. Images have a different host than fetching movies.
        private var host: String {
            switch self {
            case .image:
                return "image.tmdb.org"
            default:
                return "api.themoviedb.org"
            }
        }

        /// A fully constructed url for the given endpoint including authentication query parameters.
        var url: URL {
            var components = URLComponents()
            components.scheme = "https"
            components.host = host
            components.path = path
            components.addQueryItems(with: authenticationQueryParameters)
            let url = components.url!
            print(url)
            return url
        }
    }

    /// A shared JSON decoder to use in calls.
    private var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        // TheMovieDB API keys are in snake_case (ex: poster_path) while our models use camelCase keys.
        // Add snake_case -> camelCase conversion in the decoder.
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()


    /// Fetches movies at the specified endpoint from the TheMovieDb.org web service api.
    /// - Parameter endpoint: The endpoint to fetch from in the request.
    /// - Returns: A `Publisher` with a `MovieResponse` object or an `Error`
    func getMovies(_ endpoint: API.EndPoint) -> AnyPublisher<MovieResponse, Error> {
        URLSession.shared
        .dataTaskPublisher(for: endpoint.url)
        .map(\.data)
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
