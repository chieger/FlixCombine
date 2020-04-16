//
//  MovieRowViewModel.swift
//  FlixCombine
//
//  Created by Charles Hieger on 4/15/20.
//  Copyright © 2020 Charles Hieger. All rights reserved.
//

import Foundation

class MovieRowViewModel: ObservableObject {

    @Published var title: String
    @Published var overview: String

    private let posterPath: String?
    var posterURL: URL? {
        guard let posterPath = posterPath else { return nil }
        return API.EndPoint.image(posterPath).url
    }

    init(_ movie: Movie) {
        title = movie.title
        overview = movie.overview
        posterPath = movie.posterPath
    }
}
