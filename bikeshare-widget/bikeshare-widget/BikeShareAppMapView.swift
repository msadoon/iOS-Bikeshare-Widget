//
//  BikeShare-app-Map.swift
//  bikeshare-widget
//
//  Created by Kylo Xue on 2021-02-20.
//
import MapKit
import SwiftUI

struct BikeShareAppMapView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region)
                .frame(minWidth: 256,
                       idealWidth: .infinity,
                       maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                       minHeight: 512,
                       idealHeight: .infinity,
                       maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                   alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
    }
}

struct BikeShareAppMapPreviews: PreviewProvider {
    static var previews: some View {
        BikeShareAppMapView()
    }
}
