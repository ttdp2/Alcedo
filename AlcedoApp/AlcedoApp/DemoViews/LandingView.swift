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
            PrimaryButton(title: "Primary  机票服务")
            SecondaryButton(title: "Secondary  会员服务")
        }
        .padding()
    }
    
}

struct LandingView_Previews: PreviewProvider {
    
    static var previews: some View {
        LandingView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
    }
    
}
