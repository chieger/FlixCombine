//
//  AsyncImage.swift
//  FlixCombine
//
//  Created by Charles Hieger on 4/15/20.
//  Copyright © 2020 Charles Hieger. All rights reserved.
//

import SwiftUI

struct AsyncImage<Placeholder: View>: View {

    @ObservedObject private var loader: ImageLoader

    /// The optional placeholder view to show when image is nil.
    private let placeholder: Placeholder?

    init(url: URL, placeholder: Placeholder? = nil) {
        loader = ImageLoader(url: url)
        self.placeholder = placeholder

        // Kick off image loading.
        loader.load()
    }

    /// The fetched image to show if available, otherwise show placeholder.
    var body: some View {
        Group {
            if loader.image != nil {
                Image(uiImage: loader.image!)
                    .resizable()
            } else {
                placeholder
            }
        }
    }
}

#if DEBUG
struct AsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImage(
            url: URL(string: "https://image.tmdb.org/t/p/w500/kqjL17yufvn9OVLyXYpvtyrFfak.jpg")!,
            placeholder: Image(systemName: "film")
                .resizable()
                .frame(width: 80, height: 80)
        )
    }
}
#endif
