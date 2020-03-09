//
//  LandingView.swift
//  AlcedoApp
//
//  Created by Tian Tong on 2020/2/22.
//  Copyright © 2020 TTDP. All rights reserved.
//

import SwiftUI

struct MyView: View {
    @State var count = 0
    
    var body: some View {
        Button (action: {
            self.count += 1
        }, label: { Text("Tap me!") })
    }
}

struct LandingView: View {
    
    @ObservedObject var model = AppStore()
    
    var body: some View {
        VStack(alignment: .center, spacing: 50) {
            NavigationLink(destination: ChatingView(service: .ticket(URL(string: "ws://127.0.0.1:8080/flightChange")!))) {
                PrimaryButton(title: "TICKET  机票服务")
            }

            NavigationLink(destination: ChatingView(service: .member(URL(string: "ws://127.0.0.1:8080/member")!))) {
                SecondaryButton(title: "MEMBER  会员服务")
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
        .navigationBarTitle("在线智能客服 💁🏻‍♀️💁‍♂️")
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
        .navigationBarTitle("在线智能客服 💁🏻‍♀️💁‍♂️")
        .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
    }
    
}
