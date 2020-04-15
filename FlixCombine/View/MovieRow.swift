//
//  MovieRow.swift
//  FlixCombine
//
//  Created by Charles Hieger on 4/15/20.
//  Copyright © 2020 Charles Hieger. All rights reserved.
//

import SwiftUI

struct MovieRow: View {
    let title: String
    let overview: String

    init(title: String, overview: String) {
        self.title = title
        self.overview = overview
    }

    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: "film")
                .resizable()
                .frame(width: 80, height: 80)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title)
                .lineLimit(2)
                    .minimumScaleFactor(0.6)
                Text(overview)
                    .font(.caption)
                .lineLimit(4)
            }
        }
    }
}

#if DEBUG
struct MovieRow_Previews: PreviewProvider {
    static var previews: some View {
        MovieRow(title: "Kamen Rider Reiwa: The First Generation",
                 overview: "Queen Poppy and Branch make a surprising discovery — there are other Troll worlds beyond their own, and their distinct differences create big clashes between these various tribes. When a mysterious threat puts all of the Trolls across the land in danger, Poppy, Branch, and their band of friends must embark on an epic quest to create harmony among the feuding Trolls to unite them against certain doom.")
    }
}
#endif
