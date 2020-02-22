//
//  WebSocket.swift
//  AlcedoApp
//
//  Created by Tian Tong on 2020/2/22.
//  Copyright © 2020 TTDP. All rights reserved.
//

import Foundation

protocol WebSocketDelegate {
    func webSocket(ws: WebSocket, didReceive text: String)
    func webSocket(ws: WebSocket, didReceive data: Data)
}

class WebSocket: NSObject, URLSessionWebSocketDelegate {
    
    var webSocketTask: URLSessionWebSocketTask!
    
    var delegate: WebSocketDelegate?
    
    init(url: URL) {
        super.init()
//        webSocketTask = URLSession.shared.webSocketTask(with: url)
//        webSocketTask.resume()
//        listen()
        print("WebSocket init")
    }
    
    deinit {
        print("WebSocket deinit")
    }
    
    func send(text: String) {
        let message = URLSessionWebSocketTask.Message.string(text)
        webSocketTask.send(message) { error in
            if let error = error {
                print("WebSocket send message error: \(error.localizedDescription)")
            }
        }
    }
    
    func send(data: Data) {
        let message = URLSessionWebSocketTask.Message.data(data)
        webSocketTask.send(message) { error in
            if let error = error {
                print("WebSocket send message error: \(error.localizedDescription)")
            }
        }
    }
    
    private func listen() {
        webSocketTask.receive { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                print("WebSocket lisen error: \(error.localizedDescription)")
            case .success(let message):
                switch message {
                case .string(let text):
                    self.delegate?.webSocket(ws: self, didReceive: text)
                case .data(let data):
                    self.delegate?.webSocket(ws: self, didReceive: data)
                @unknown default:
                    print("Unknow mesasge type...")
                }
                
            }
            self.listen()
        }
    }
    
    func close() {
        webSocketTask.cancel()
    }
    
}
