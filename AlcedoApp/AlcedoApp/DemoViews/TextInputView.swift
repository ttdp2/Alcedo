//
//  TextInputView.swift
//  AlcedoApp
//
//  Created by Tian Tong on 2020/2/22.
//  Copyright © 2020 TTDP. All rights reserved.
//

import SwiftUI

struct TextInputView: View {
    
    @Binding var text: String
    
    let sendAction: (String) -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.white)
                .shadow(color: .shadow, radius: 3, x: 0, y: -2)

            HStack {
                TextField("Type somthing", text: $text)
                    .frame(height: 60)
                
                Button(action: sendTapped) {
                    Image("send_message")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding(.leading, 16)
                }
            }
            .padding([.leading, .trailing])
        }
        .frame(height: 60)
    }
    
    private func sendTapped() {
        
    }
    
}

struct TextInputView_Previews: PreviewProvider {
    
    @State static var text = ""
    
    static var previews: some View {
        VStack {
            Spacer()
            TextInputView(text: $text) { _ in }
        }
        .previewLayout(.fixed(width: 300, height: 80))
    }
    
}
