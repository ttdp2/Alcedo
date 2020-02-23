//
//  LandingView.swift
//  AlcedoApp
//
//  Created by Tian Tong on 2020/2/22.
//  Copyright © 2020 TTDP. All rights reserved.
//

import SwiftUI

struct LandingView: View {
    
    var body: some View {
        VStack(alignment: .center, spacing: 50) {
            NavigationLink(destination: ChatingView(role: bot)) {
                PrimaryButton(title: "Primary  机票服务")
            }
            
            NavigationLink(destination: ChatingView(role: service1)) {
                SecondaryButton(title: "Secondary  会员服务")
            }
        }
        .padding()
        .navigationBarTitle("在线客服 💁🏻‍♀️💁‍♂️")
        .onAppear {
            
            
        }
    }
    
}

struct LandingView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            LandingView()
        }
        .navigationBarTitle("在线客服 💁🏻‍♀️💁‍♂️")
        .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
    }
    
}
