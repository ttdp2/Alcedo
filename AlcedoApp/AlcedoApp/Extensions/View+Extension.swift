//
//  View+Extension.swift
//  AlcedoApp
//
//  Created by Tian Tong on 2020/2/18.
//  Copyright © 2020 TTDP. All rights reserved.
//

import SwiftUI

extension View {
    
    func endEditing(_ force: Bool = true) {
        UIApplication.shared.windows.forEach { $0.endEditing(force)}
    }
    
}
