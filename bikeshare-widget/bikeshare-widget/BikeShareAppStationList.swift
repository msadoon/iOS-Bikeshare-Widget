//
//  BikeShareAppStationList.swift
//  bikeshare-widget
//
//  Created by Kylo Xue on 2021-02-21.
//

import SwiftUI

struct BikeShareAppStationList: View {
    var body: some View {
            List(0 ..< 20) { item in
                StationRow()
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Nearby Stations")
        }
}

struct BikeShareAppStationList_Previews: PreviewProvider {
    static var previews: some View {
        BikeShareAppStationList()
    }
}
