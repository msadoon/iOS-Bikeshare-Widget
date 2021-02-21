//
//  StationRow.swift
//  bikeshare-widget
//
//  Created by Kylo Xue on 2021-02-21.
//

import SwiftUI

struct StationRow: View {
    var body: some View {
        HStack{
            Image(systemName: "bicycle.circle.fill")
                .renderingMode(.template)
                .frame(width: 48.0, height: 48.0)
                .imageScale(.large)
                .foregroundColor(Color("Primary"))
                //.clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
               // .background(Color("Primary"))
            
            VStack(alignment: .leading, spacing: 4.0) {
                HStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Location Name")
                                .font(.subheadline)
                                .bold()
                            Text("Address")
                                .font(.footnote)
                        }
                        
                    }
                    Spacer()
                    Button(action: {
                        // What to perform
                        print("direction button tapped")
                    }) {
                        Text("Direction")
                    }
                }
  
                HStack {
                    Image(systemName: "location.fill")
                        .foregroundColor(Color("Primary-Dark"))
                        .imageScale(.large)
                    Text("1.6 km")
                    Image(systemName: "bicycle.circle.fill")
                        .foregroundColor(Color("Primary-Dark"))
                    Text("11")
                    Image(systemName: "cart.fill")
                        .foregroundColor(Color("Primary-Dark"))
                    Text("3")
                }
                .font(.footnote)
                .foregroundColor(Color.gray)
            }
            Spacer()
        }
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        .padding(.vertical, 8.0)
    }
}

struct StationRow_Previews: PreviewProvider {
    static var previews: some View {
        StationRow()
    }
}
