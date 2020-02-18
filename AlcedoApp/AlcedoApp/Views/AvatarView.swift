//
//  AvatarView.swift
//  AlcedoApp
//
//  Created by Tian Tong on 2020/2/18.
//  Copyright © 2020 TTDP. All rights reserved.
//

import SwiftUI

struct AvatarView: View {
    
    let url: URL?
    let isOnline: Bool
    
    private let showsOnlineStatus: Bool
    
    init(url: URL?, isOnline: Bool) {
        self.url = url
        self.isOnline = isOnline
        showsOnlineStatus = true
    }
    
    init(url: URL?) {
        self.url = url
        isOnline = false
        showsOnlineStatus = false
    }
    
    var body: some View {
        ZStack {
            
            Image("profile0")
                .resizable()
                .frame(width: 37, height: 37)
            
            if showsOnlineStatus {
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(isOnline ? .green : .gray)
                    .padding([.leading, .top], 25)
            }
        }
    }
    
}

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView(url: nil, isOnline: true)
        .previewLayout(.fixed(width: 100, height: 100))
    }
}
