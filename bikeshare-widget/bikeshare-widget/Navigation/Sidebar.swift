//
//  Sidebar.swift
//  bikeshare-widget
//
//  Created by Kylo Xue on 2021-02-21.
//

import SwiftUI

struct Sidebar: View {
    var body: some View {
        NavigationView {
            List{
                NavigationLink(destination:ContentView()) {
                    Label("Map", systemImage: "map.fill")
                }
                NavigationLink(destination:BikeShareAppStationList()) {
                    Label("Station List", systemImage: "list.bullet")
                }
                Label("My Profile", systemImage: "person.circle.fill")
                Label("Settings", systemImage: "ellipsis.circle.fill")
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Navigation")
            .toolbar{
                ToolbarItem(placement:
                    .navigationBarTrailing){
                    Image(systemName: "person.crop.circle")
                }
            }
            
            ContentView()
        }
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar()
    }
}
