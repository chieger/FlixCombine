//
//  MovieRow.swift
//  FlixCombine
//
//  Created by Charles Hieger on 4/15/20.
//  Copyright © 2020 Charles Hieger. All rights reserved.
//

import SwiftUI

struct MovieRow: View {

    @ObservedObject var model: MovieRowViewModel

    init(_ model: MovieRowViewModel) {
        self.model = model
    }

    var body: some View {
        HStack(alignment: .top) {
            Group {
                if model.posterURL != nil {
                    AsyncImage(
                        url: model.posterURL!,
                        placeholder: Image(systemName: "film")
                            .resizable()
                    )
                    .aspectRatio(contentMode: .fill)
                } else {
                    // Default image if unable to fetch poster url.
                    Image(systemName: "film")
                    .resizable()
                }
            }
            .frame(width: 100, height: 150)
            .clipped(antialiased: true)
            VStack(alignment: .leading) {
                Text(model.title)
                    .font(.title)
                    .lineLimit(2)
                    .minimumScaleFactor(0.6)
                Text(model.overview)
                    .font(.caption)
                    .lineLimit(5)
            }
        }
    }
}

//#if DEBUG
//struct MovieRow_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieRow(title: "Kamen Rider Reiwa: The First Generation",
//                 overview: "Queen Poppy and Branch make a surprising discovery — there are other Troll worlds beyond their own, and their distinct differences create big clashes between these various tribes. When a mysterious threat puts all of the Trolls across the land in danger, Poppy, Branch, and their band of friends must embark on an epic quest to create harmony among the feuding Trolls to unite them against certain doom.",
//                 posterURL: URL(string: "https://image.tmdb.org/t/p/w500/8uO0gUM8aNqYLs1OsTBQiXu0fEv.jpg")!)
//    }
//}
//#endif
