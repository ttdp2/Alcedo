//
//  TextRow.swift
//  AlcedoApp
//
//  Created by Tian Tong on 2020/2/22.
//  Copyright © 2020 TTDP. All rights reserved.
//

import SwiftUI

struct TextRow: View {
    
    let tweet: Tweet
    let isIncoming: Bool
    let isLast: Bool
    
    private var chatBubble: some View {
        RoundedRectangle(cornerRadius: 6)
            .foregroundColor(isIncoming ? .white : .accentColor)
            .shadow(color: .shadow, radius: 2, x: 0, y: 1)
    }
    
    private var text: some View {
        Text(tweet.text)
            .padding(10)
            .foregroundColor(isIncoming ? .body : .white)
            .modifier(BodyText())
            .background(chatBubble)
    }
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            if isIncoming {
                if isLast {
                    RoleView(icon: tweet.role.icon)
                    chatBubbleTriange(width: 15, height: 14, isIncoming: true)
                } else {
                    Spacer().frame(width: 61)
                }
                
                text
                
                Spacer()
            } else {
                
                Spacer()
                
                text
                
                if isLast {
                    chatBubbleTriange(width: 15, height: 14, isIncoming: false)
                    RoleView(icon: tweet.role.icon)
                } else {
                    Spacer().frame(width: 61)
                }
            }
        }
        .onTapGesture(perform: tapEvent)
    }
    
    private func tapEvent() {
        print("Here")
    }
    
    private func chatBubbleTriange(width: CGFloat, height: CGFloat, isIncoming: Bool) -> some View {
        Path { path in
            path.move(to: CGPoint(x: isIncoming ? 0 : width, y: height * 0.5))
            path.addLine(to: CGPoint(x: isIncoming ? width : 0, y: height))
            path.addLine(to: CGPoint(x: isIncoming ? width : 0, y: 0))
            path.closeSubpath()
        }
        .fill(isIncoming ? Color.white : Color.accentColor)
        .frame(width: width, height: height)
        .shadow(color: .shadow, radius: 2, x: 0, y: 1)
        .zIndex(10)
        .clipped()
        .padding(.trailing, isIncoming ? -1 : 10)
        .padding(.leading, isIncoming ? 10: -1)
        .padding(.bottom, 12)
    }
    
}

struct TweetRow_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            TextRow(tweet: Tweet(text: "This is a tweet from user role.", role: Role(name: "User", icon: "profile0")), isIncoming: false, isLast: true)
            .previewLayout(.fixed(width: 300, height: 200))
            
            TextRow(tweet: Tweet(text: "This is a tweet from bot role.", role: Role(name: "Bot", icon: "role_bot")), isIncoming: true, isLast: true)
            .previewLayout(.fixed(width: 300, height: 200))
            
            TextRow(tweet: Tweet(text: "This is a tweet from female role.", role: Role(name: "Female", icon: "role_female")), isIncoming: true, isLast: true)
            .previewLayout(.fixed(width: 300, height: 200))
            
            TextRow(tweet: Tweet(text: "This is a tweet from male role.", role: Role(name: "Male", icon: "role_male")), isIncoming: true, isLast: true)
            .previewLayout(.fixed(width: 300, height: 200))
        }
    }
    
}
