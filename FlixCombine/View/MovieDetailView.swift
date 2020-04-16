//
//  MovieDetailView.swift
//  FlixCombine
//
//  Created by Charles Hieger on 4/16/20.
//  Copyright © 2020 Charles Hieger. All rights reserved.
//

import SwiftUI

struct MovieDetailView: View {

    @ObservedObject var model: MovieDetailViewModel

    init(_ model: MovieDetailViewModel) {
        self.model = model
    }

    var body: some View {
        VStack(alignment: .leading) {
            Group {
                if model.backdropURL != nil {
                    AsyncImage(
                        url: model.backdropURL!,
                        placeholder: EmptyView()
                    )
                } else {
                    Text("No backdrop")
                }
            }
            .aspectRatio(contentMode: .fit)
            Text(model.title)
                .font(.largeTitle)
                .bold()
            Text(model.overview)
                .font(.body)
            Spacer()
        }
        .padding()
    }
}

//#if DEBUG
//struct MovieDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetailView()
//    }
//}
//#endif
