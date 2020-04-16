//
//  ImageLoader.swift
//  FlixCombine
//
//  Created by Charles Hieger on 4/15/20.
//  Copyright © 2020 Charles Hieger. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class ImageLoader: ObservableObject {

    /// The loaded image if available, otherwise nil.
    @Published var image: UIImage?

    /// The URL to fetch the image from.
    private let url: URL

    private var subscription: AnyCancellable?

    init(url: URL) {
        self.url = url
    }

    deinit {
        subscription?.cancel()
    }

    func load() {
        subscription = URLSession.shared
            .dataTaskPublisher(for: url)
            .print("🖼🐞 DEBUG IMAGE LOAD")
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }

    func cancel() {
        subscription?.cancel()
    }
}
