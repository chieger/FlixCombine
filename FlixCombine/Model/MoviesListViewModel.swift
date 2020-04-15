//
//  MoviesListViewModel.swift
//  FlixCombine
//
//  Created by Charles Hieger on 4/14/20.
//  Copyright © 2020 Charles Hieger. All rights reserved.
//

import Foundation
import Combine

class MoviesListViewModel: ObservableObject {
    private let api = API()
    private var subscriptions = Set<AnyCancellable>()

    @Published var movies = [Movie]()
    @Published var error: API.Error? = nil

    /// Fetches movies from the specified endpoint.
    /// - Parameter endpoint: The `Endpoint` to fetch from in the request.
    func getMovies(_ endpoint: API.EndPoint) {
        api.getMovies(endpoint)
        .receive(on: DispatchQueue.main)
        .print("🐞 DEBUG")
        .sink(receiveCompletion: { completion in
            if case .failure(let error) = completion {
                print("⛔️ Error recieved from getMovies: \(error.errorDescription ?? "Unknown")")
                self.error = error
            }
        }) { movieResponse in
            self.movies = movieResponse.results
        }
        .store(in: &subscriptions)
    }
}
