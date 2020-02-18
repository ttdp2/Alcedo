//
//  AppStore.swift
//  AlcedoApp
//
//  Created by Tian Tong on 2020/2/18.
//  Copyright © 2020 TTDP. All rights reserved.
//

import SwiftUI
import Combine

class AppStore: ObservableObject {
    
    struct AppStore {
        var currentUser: Contact?
    }
    
    @Published private(set) var state = AppStore(currentUser: nil)
    
    func setCurrentUser(_ user: Contact?) {
        state.currentUser = user
    }
    
}
