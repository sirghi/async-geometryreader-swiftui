//
//  Country.swift
//  Countries
//
//  Created by Sergiu Todirascu on 7/4/20.
//  Copyright © 2020 Sergiu Todirascu. All rights reserved.
//

import Foundation

struct Country: Decodable, Hashable {
    let name: String
    let capital: String
    let currency: String
    let flagCode: String

    enum CodingKeys: String, CodingKey {
        case name, capital, currencies, alpha2Code
    }

    enum CurrencyKeys: String, CodingKey {
        case name
    }

    init(name: String, capital: String, currency: String, flagCode: String) {
        self.name = name
        self.capital = capital
        self.currency = currency
        self.flagCode = flagCode
    }

    init(from decoder: Decoder) throws {
        let topLevel = try decoder.container(keyedBy: CodingKeys.self)
        name = try topLevel.decode(String.self, forKey: .name)
        capital = try topLevel.decode(String.self, forKey: .capital)
        flagCode = try topLevel.decode(String.self, forKey: .alpha2Code).lowercased()

        if let currency = try? topLevel.decode(String.self, forKey: .currencies) {
            // from the cache
            self.currency = currency
        } else {
            // from the server
            var innerLevel = try topLevel.nestedUnkeyedContainer(forKey: .currencies)
            let currencyLevel = try innerLevel.nestedContainer(keyedBy: CurrencyKeys.self)
            self.currency = try currencyLevel.decode(String.self, forKey: .name)
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(capital, forKey: .capital)
        try container.encode(currency, forKey: .currencies)
        try container.encode(flagCode, forKey: .alpha2Code)
    }
}
