//
//  StationRow.swift
//  bikeshare-widget
//
//  Created by Kylo Xue on 2021-02-21.
//

import SwiftUI

struct StationRow: View {
    var body: some View {
        HStack {
            Image(systemName: "location.fill")
                .renderingMode(.original)
                .frame(width: 48.0, height: 48.0)
                .imageScale(.medium)
               // .background()
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            VStack(alignment: .leading, spacing: 4.0) {
                Text("Location Name")
                    .font(.subheadline)
                    .bold()
                HStack {
                    Image(systemName: "location.fill")
                    Text("Distance")
                    Image(systemName: "bicycle.circle.fill")
                    Text("Bike number")
                    Image(systemName: "cart.fill")
                    Text("Charge number")
                }
                .font(.footnote)
            }
            Spacer()
        }
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("Background 4")/*@END_MENU_TOKEN@*/)
    }
}

struct StationRow_Previews: PreviewProvider {
    static var previews: some View {
        StationRow()
    }
}
