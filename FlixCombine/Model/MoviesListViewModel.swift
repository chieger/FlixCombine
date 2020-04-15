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

    func getMovies(_ endpoint: API.EndPoint) {
        api.getMovies(endpoint)
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                print("🏁 Recieved finish completion from getMovies")
            case .failure(let error):
                print("⛔️ Error recieved from getMovies: \(error.errorDescription ?? "Unknown")")
                self.error = error
            }
        }) { movieResponse in
            self.movies = movieResponse.results
            for movie in movieResponse.results {
                print(movie.title)
            }
        }.store(in: &subscriptions)
    }
}
