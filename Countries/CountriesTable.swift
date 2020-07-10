//
//  CountriesTable.swift
//  Countries
//
//  Created by Sergiu Todirascu on 7/4/20.
//  Copyright © 2020 Sergiu Todirascu. All rights reserved.
//

import SwiftUI

struct CountriesTable: View {
    @ObservedObject var networkService = CountryService()
    
    var body: some View {
        List(self.networkService.countries, id: \.self) { country in
            CountryCell(country: country)
        }.onAppear {
            self.networkService.fetchCountries()
        }.alert(isPresented: Binding<Bool>(get: {self.networkService.error != nil}, set: {_ in})) {
            Alert(title: Text("Oh-oh, no countries"))
        }
    }
}

struct CountriesTable_Previews: PreviewProvider {
    static var previews: some View {
        CountriesTable(networkService: CountryMock())
    }
}
