//
//  CountryCell.swift
//  Countries
//
//  Created by Sergiu Todirascu on 7/4/20.
//  Copyright © 2020 Sergiu Todirascu. All rights reserved.
//

import SwiftUI
import Combine

struct CountryCell: View {
    let country: Country

    @State var childSize: CGSize = .init(width: 0, height: 50)

    var body: some View {
        HStack {
            AsyncImage(url: Endpoints.flag(countryCode: country.flagCode).url, placeholder: Image("flag"))
                .aspectRatio(contentMode: .fit)
                .frame(width: DeviceMetrics.size.width * 0.25, height: self.childSize.height)
            VStack(alignment: .leading, spacing: 5) {
                Text("Country: ").bold() + Text(self.country.name)
                Text("Capital: ").bold() + Text(self.country.capital)
                Text("Currency: ").bold() + Text(self.country.currency)
            }
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .background(
                GeometryReader { proxy -> AnyView in
                    DispatchQueue.main.async {
                        self.childSize = proxy.size
                    }
                    return AnyView(Color.clear)
            })
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let country = Country(name: "Moldova", capital: "Chișinău", currency: "Leu", flagCode: "md")

        let cell = CountryCell(country: country)
            .previewLayout(.sizeThatFits)

        return Group {
            cell
                .previewDevice("iPhone 11")
//            cell
//                .previewDevice("iPhone SE (1st generation)")
//                .background(Color(.systemBackground))
//                .colorScheme(.dark)
//                .environment(\.sizeCategory, .extraExtraExtraLarge)
        }
    }
}
#endif

extension View {
    func Print(_ vars: Any...) -> some View {
        for v in vars { print(v) }
        return EmptyView()
    }
}
