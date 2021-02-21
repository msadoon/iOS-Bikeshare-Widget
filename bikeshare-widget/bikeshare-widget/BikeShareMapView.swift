//
//  BikeShareMapView.swift
//  bikeshare-widget
//
//  Created by Kylo Xue on 2021-02-21.
//

import SwiftUI

struct BikeShareMapView: View {
    var body: some View {
            ZStack {
                BikeShareAppMapView()
                BikeShareAppDetails()
            }
            .navigationTitle("BikeShare")
        }
}

struct BikeShareMapView_Previews: PreviewProvider {
    static var previews: some View {
        BikeShareMapView()
    }
}
