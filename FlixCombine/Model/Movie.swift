//
//  Movie.swift
//  FlixCombine
//
//  Created by Charles Hieger on 4/14/20.
//  Copyright © 2020 Charles Hieger. All rights reserved.
//

import Foundation

struct MovieResponse: Codable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
}

struct Movie: Codable, Identifiable {
    let posterPath: String?
    let overview: String
    let releaseDate: String
    let id: Int
    let title: String
    let voteAverage: Double
    let backdropPath: String?
}
