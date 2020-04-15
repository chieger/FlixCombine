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
    let totalPages: Int // total_pages
    let totalResults: Int // total_results
}

struct Movie: Codable, Identifiable {
    let posterPath: String? // poster_path
    let overview: String
    let releaseDate: String // How to auto convert to date? release_date
    let id: Int
    let title: String
    let voteAverage: Double // vote_average
}
