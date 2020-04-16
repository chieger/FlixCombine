//
//  MovieDetailViewModel.swift
//  FlixCombine
//
//  Created by Charles Hieger on 4/16/20.
//  Copyright © 2020 Charles Hieger. All rights reserved.
//

import Foundation

class MovieDetailViewModel: ObservableObject {

    @Published var title: String
    @Published var overview: String

    private let posterPath: String?

    /// The url to fetch the poster image from.
    var posterURL: URL? {
        guard let posterPath = posterPath else { return nil }
        return API.EndPoint.image(posterPath).url
    }

    private let backdropPath: String?

    /// The url to fetch the backdrop image from.
    var backdropURL: URL? {
        guard let backdropPath = backdropPath else { return nil }
        return API.EndPoint.image(backdropPath).url
    }


    init(_ movie: Movie) {
        title = movie.title
        overview = movie.overview
        posterPath = movie.posterPath
        backdropPath = movie.backdropPath

    }
}
