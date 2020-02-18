//
//  ChatHelper.swift
//  AlcedoApp
//
//  Created by Tian Tong on 2020/2/17.
//  Copyright © 2020 TTDP. All rights reserved.
//

import Combine

class ChatHelper: ObservableObject {
    
    var didChange = PassthroughSubject<Void, Never>()
    @Published var realTimeMessages = DataSource.messages
    
    func sendMessage(_ chatMessage: Message2) {
        realTimeMessages.append(chatMessage)
        didChange.send()
    }
    
}
