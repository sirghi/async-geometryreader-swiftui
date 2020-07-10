//
//  CountryMock.swift
//  Countries
//
//  Created by Sergiu Todirascu on 7/4/20.
//  Copyright © 2020 Sergiu Todirascu. All rights reserved.
//

import UIKit
import Combine

class CountryMock: CountryService {
    override var countries: [Country] {
        get {
            let path = Bundle.main.path(forResource: "Countries", ofType: "json")!
            let data = try! Data(contentsOf: URL(fileURLWithPath: path))
            return try! JSONDecoder().decode([Country].self, from: data)
        }
        set { }
    }

    override func fetchCountries() { }

//    override func flagPublisher(code: String) -> AnyPublisher<UIImage, Never> {
//        return Just(UIImage(named: "Moldova")!).eraseToAnyPublisher()
//    }
}
