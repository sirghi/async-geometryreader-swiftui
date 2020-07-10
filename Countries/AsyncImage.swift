//
//  AsyncImage.swift
//  Countries
//
//  Created by Sergiu Todirascu on 7/6/20.
//  Copyright © 2020 Sergiu Todirascu. All rights reserved.
//

import SwiftUI

struct AsyncImage: View {
    @ObservedObject var loader: ImageLoader
    private let placeholder: Image

    init(url: URL, placeholder: Image) {
        self.loader = ImageLoader(url: url)
        self.placeholder = placeholder
    }

    var body: some View {
        Group {
            // if-let daca folosim, da eroare
            if loader.image != nil {
                Image(uiImage: loader.image!).resizable()
            } else {
                placeholder.resizable()
            }
        }
        .onAppear(perform: loader.load)
        .onDisappear(perform: loader.cancel)
    }
}

struct AsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImage(url: URL(string: "asd")!, placeholder: Image("flag"))
            .aspectRatio(contentMode: .fit)
            .previewLayout(.fixed(width: 110, height: 50))
    }
}
