//
//  ImageLoader.swift
//  Countries
//
//  Created by Sergiu Todirascu on 7/6/20.
//  Copyright © 2020 Sergiu Todirascu. All rights reserved.
//

import Foundation
import UIKit
import Combine

protocol ImageProvider {
    var image: UIImage? { get }
}

class ImageLoader: ImageProvider, ObservableObject {
    @Published var image: UIImage? {
        didSet {
            print("Did set image")
        }
    }


    private var publisher: AnyCancellable?
    let url: URL

    init(url: URL) {
        self.url = url
    }

    func load() {
        publisher = URLSession.shared.dataTaskPublisher(for: url)
            .compactMap { UIImage(data: $0.data)?.resizeImage(200) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }

    func cancel() {
        publisher?.cancel()
    }

    deinit {
        publisher?.cancel()
    }
}

class ImageMock: ImageProvider {
    let image: UIImage? = UIImage(named: "flag")
}
