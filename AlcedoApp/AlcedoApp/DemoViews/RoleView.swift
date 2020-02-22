//
//  RoleView.swift
//  AlcedoApp
//
//  Created by Tian Tong on 2020/2/22.
//  Copyright © 2020 TTDP. All rights reserved.
//

import SwiftUI

struct RoleView: View {
    
    let icon: String
    
    var body: some View {
        Image(icon)
            .resizable()
            .frame(width: 37, height: 37)
    }
    
}

struct RoleView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            RoleView(icon: "role_user")
                .previewLayout(.fixed(width: 100, height: 100))
            RoleView(icon: "role_bot")
                .previewLayout(.fixed(width: 100, height: 100))
            RoleView(icon: "role_female")
                .previewLayout(.fixed(width: 100, height: 100))
            RoleView(icon: "role_male")
                .previewLayout(.fixed(width: 100, height: 100))
        }
    }
    
}
