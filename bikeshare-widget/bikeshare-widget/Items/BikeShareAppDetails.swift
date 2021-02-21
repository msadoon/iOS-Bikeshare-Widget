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
                HStack {
                    Image(systemName: "flag.fill")
                    Text("Station Name")
                        .font(.body)
                }
                Text("Location")
                    .font(.footnote)
                    .padding(.bottom, 16.0)
                HStack {
                    Image(systemName: "location.fill")
                    Text("Distancec")
                    HStack (alignment: .lastTextBaseline, spacing: 4.0){
                        Image(systemName: "figure.walk")
                        Text("Walk")
                        Image(systemName: "car.fill")
                        Text("Drive")
                    }
                    .frame(alignment: .bottomTrailing)
                }
                .font(.footnote)
                Text("Description")
                    .font(/*@START_MENU_TOKEN@*/.caption/*@END_MENU_TOKEN@*/)
                    .padding(.bottom, 16.0)
                Divider()
                HStack {
                    HStack {
                        Image(systemName: "bicycle.circle.fill")
                            .renderingMode(.template)
                            .foregroundColor(Color("Secondary"))
                        Text("3")
                        Image(systemName: "cart.fill")
                        Text("3")
                        Image(systemName: "battery.100.bolt")
                        Text("9")
                        
                    }
                    .font(/*@START_MENU_TOKEN@*/.caption/*@END_MENU_TOKEN@*/)
                    Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Button")/*@END_MENU_TOKEN@*/
                    }
                }
                
            }
            .padding(16.0)
        }
        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.white/*@END_MENU_TOKEN@*/)
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 300)
        .shadow(color: Color("Primary").opacity(0.3), radius:20, x:0, y: 10)
    }
}

struct BikeShareAppDetails_Previews: PreviewProvider {
    static var previews: some View {
        BikeShareAppDetails()
    }
}
