//
//  BikeShareAppDetails.swift
//  bikeshare-widget
//
//  Created by Kylo Xue on 2021-02-21.
//

import SwiftUI

struct BikeShareAppDetails: View {
    var body: some View {
        VStack(alignment: .center, spacing: 4.0) {
            VStack {
                Capsule()
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 50, height: 5)
                    .padding(.top)
                    .padding(.bottom, 5)
            }
            VStack(alignment: .leading, spacing: 4.0) {
                Text("Station Name")
                    .font(.subheadline)
                Text("Location")
                HStack {
                    Image(systemName: "location.fill")
                    Text("Distancec")
                    Image(systemName: "figure.walk")
                    Text("Walk")
                    Image(systemName: "car.fill")
                    Text("Drive")
                }
                .font(/*@START_MENU_TOKEN@*/.caption/*@END_MENU_TOKEN@*/)
                Text("Description")
                    .font(/*@START_MENU_TOKEN@*/.caption/*@END_MENU_TOKEN@*/)
                Divider()
                HStack {
                    HStack {
                        Image(systemName: "bicycle.circle.fill")
                        Text("Bike number")
                        Image(systemName: "cart.fill")
                        Text("Emtpy number")
                        Image(systemName: "battery.100.bolt")
                        Text("Charging number")
                        
                    }
                    .font(/*@START_MENU_TOKEN@*/.caption/*@END_MENU_TOKEN@*/)
                    Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Button")/*@END_MENU_TOKEN@*/
                    }
                }
                
            }
            .padding(16.0)
        }
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("Background 4")/*@END_MENU_TOKEN@*/)
        .padding()
        .frame(width: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/)
        .shadow(color: Color/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.3), radius:20, x:0, y: 10)
        .frame(minWidth: .infinity, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
    }
}

struct BikeShareAppDetails_Previews: PreviewProvider {
    static var previews: some View {
        BikeShareAppDetails()
    }
}
