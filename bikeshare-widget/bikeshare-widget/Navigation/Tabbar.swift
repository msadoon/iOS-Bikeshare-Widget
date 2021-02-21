//
//  Tabbar.swift
//  bikeshare-widget
//
//  Created by Kylo Xue on 2021-02-21.
//

import SwiftUI

struct Tabbar: View {
    var body: some View {
        VStack {
            TabView {
                NavigationView {
                    BikeShareMapView()
                }
                .tabItem {
                    Image(systemName: "map.fill")
                    Text("Map")
            }
                NavigationView {
                    BikeShareAppStationList()
                }
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("List")
            }
                NavigationView {
                    BikeShareMapView()
                }
                .tabItem {
                    Image(systemName: "person.circle.fill")
                    Text("Account")
            }
                NavigationView {
                    BikeShareMapView()
                }
                .tabItem {
                    Image(systemName: "ellipsis.circle.fill")
                    Text("Settings")
            }
            }
        }
    }
}

struct Tabbar_Previews: PreviewProvider {
    static var previews: some View {
        Tabbar()
    }
}
