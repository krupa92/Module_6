//
//  SectionHeader.swift
//  City Sights App
//
//  Created by Krupa Patel on 3/8/2022.
//

import SwiftUI

struct SectionHeader: View {
    
    var text:String
    
    var body: some View {
        
        ZStack (alignment:.leading){
            
            Rectangle()
                .foregroundColor(.white)
        Text(text)
            .font(.headline)
        }
    }
}
