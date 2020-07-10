//
//  CountryService.swift
//  Countries
//
//  Created by Sergiu Todirascu on 7/4/20.
//  Copyright © 2020 Sergiu Todirascu. All rights reserved.
//

import Foundation
import Combine

class CountryService: ObservableObject {

    @Published var countries: [Country] = []
    @Published var error: Error? = nil
    private var publisher: AnyCancellable?

    func fetchCountries() {
        publisher = URLSession.shared.dataTaskPublisher(for: Endpoints.countries.url)
            .map(\.data)
            .decode(type: [Country].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion) in
                if case let .failure(err) = completion {
                    self.error = err
                }
            }) { (countries) in
                self.countries = countries
        }
    }
}
