//
//  MoviesListView.swift
//  FlixCombine
//
//  Created by Charles Hieger on 4/14/20.
//  Copyright © 2020 Charles Hieger. All rights reserved.
//

import SwiftUI

struct MoviesListView: View {
    @ObservedObject var model: MoviesListViewModel

    init(model: MoviesListViewModel) {
        self.model = model
    }

    var body: some View {

        NavigationView {
            List {
                Section(header: Text("Now Playing")) {
                    ForEach(self.model.movies) { movie in
                        Text(movie.title)
                    }
                }
            }
            .navigationBarTitle("Movies")
        }
    }
}

#if DEBUG
struct MoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView(model: MoviesListViewModel())
    }
}
#endif
