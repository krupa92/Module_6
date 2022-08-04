//
//  BusinessDetail.swift
//  City Sights App
//
//  Created by Krupa Patel on 3/8/2022.
//

import SwiftUI

struct BusinessDetail: View {
    
    var business:Business
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            VStack(alignment: .leading, spacing: 0){
                
                
                GeometryReader() {geo in
                    
                    let uiImage = UIImage(data: business.imageData ?? Data())
                    Image(uiImage: uiImage ?? UIImage())
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height)
                        .clipped()
                }.ignoresSafeArea()
                
                
                ZStack(alignment: .leading) {
                    
                    Rectangle()
                        .frame(height:36)
                        .foregroundColor(business.isClosed! ? .gray : .blue)
                    
                    Text(business.isClosed! ? "Closed" : "Open").foregroundColor(.white).bold().padding(.leading)
                }
            }
          
            
            Group {
                
                //Business Name
                Text(business.name!)
                    .font(.largeTitle)
                    .padding()
                    
                //Adress
//                if business.location?.displayAddress != nil {
//
//                    ForEach(business.location!.displayAddress!, id:\.self) { displayLine in
//
//                        Text(displayLine).font(.caption)
//                    }
//                }
                
                Text(business.location?.address1 ?? "").padding()
                //Rating
                
                Image("regular_\(business.rating ?? 0)").padding()
                
                Divider()
                
                //phone
                HStack {
                    
                    Text("Phone")
                        .bold()
                    Text(business.displayPhone ?? "")
                    Spacer()
                    Link("Call", destination: URL(string: "tel:\(business.phone ?? "")")!)
                }.padding()
               
                Divider()
                
                //Reviews
                HStack {
                    
                    Text("Review")
                        .bold()
                    
                    Text(String(business.reviewCount ?? 0))
                    
                    Spacer()
                    Link("Read", destination: URL(string: "\(business.url ?? "")")!)
                }.padding()
                
                Divider()
                
                //Website
                HStack {
                    
                    Text("Website")
                        .bold()
                    Text(business.url ?? "").lineLimit(1)
                    Spacer()
                    Link("Visit", destination: URL(string: "\(business.url ?? "")")!)
                }.padding()
                
                Divider()
            }
            
            Button {
                
            } label: {
                
                ZStack {
                    
                    Rectangle()
                        .frame(height: 48)
                        .foregroundColor(.blue)
                        .cornerRadius(10)
                    
                    Text("Get Directions")
                        .foregroundColor(.white)
                        .bold()
                }
            }.padding()

        }
    }
}

