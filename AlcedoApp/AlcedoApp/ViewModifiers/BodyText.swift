//
//  BodyText.swift
//  AlcedoApp
//
//  Created by Tian Tong on 2020/2/17.
//  Copyright © 2020 TTDP. All rights reserved.
//

import SwiftUI

struct BodyText: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(.body)
    }
    
}

