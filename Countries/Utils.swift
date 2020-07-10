//
//  Utils.swift
//  Countries
//
//  Created by Sergiu Todirascu on 7/6/20.
//  Copyright © 2020 Sergiu Todirascu. All rights reserved.
//

import Foundation
import UIKit
import AVKit

enum Endpoints {
    case countries
    case flag(countryCode: String)

    var url: URL {
        switch self {
            case .countries:
                return URL(string: "https://restcountries.eu/rest/v2/all")!
            case .flag(let countryCode):
                return URL(string: "https://flagpedia.net/data/flags/w2560/\(countryCode).png")!
        }
    }
}

extension UIImage {
    func resizeImage(_ dimension: CGFloat) -> UIImage {
        var newImage: UIImage
        let newRect = AVMakeRect(aspectRatio: self.size, insideRect: CGRect(x: 0, y: 0, width: dimension, height: dimension))

        let renderFormat = UIGraphicsImageRendererFormat.default()
        renderFormat.opaque = true
        let renderer = UIGraphicsImageRenderer(size: newRect.size, format: renderFormat)
        newImage = renderer.image {
            (context) in
            self.draw(in: CGRect(origin: .zero, size: newRect.size))
        }

        return newImage
    }
}
