//
//  LandingView.swift
//  AlcedoApp
//
//  Created by Tian Tong on 2020/2/22.
//  Copyright © 2020 TTDP. All rights reserved.
//

import SwiftUI

struct LandingView: View {
    
    @ObservedObject var model = AppStore()
    
    var body: some View {
        VStack(alignment: .center, spacing: 50) {
            NavigationLink(destination: ChatingView(role: bot)) {
                PrimaryButton(title: "Primary  机票服务")
            }

            NavigationLink(destination: ChatingView(role: service1)) {
                SecondaryButton(title: "Secondary  会员服务")
            }
            
            /*
            ForEach(model.categories, id: \.self) { category in
                NavigationLink(destination: ChatingView(role: bot)) {
                    PrimaryButton(title: category.title)
                }
            }
            */
        }
        .padding()
        .navigationBarTitle("在线客服 💁🏻‍♀️💁‍♂️")
        /*
        .onAppear {
            self.model.loadLanding()
        }
        */
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
