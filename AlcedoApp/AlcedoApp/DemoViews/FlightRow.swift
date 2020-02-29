//
//  FlightRow.swift
//  AlcedoApp
//
//  Created by Tian Tong on 2020/2/26.
//  Copyright © 2020 TTDP. All rights reserved.
//

import SwiftUI

struct FlightRow: View {
    
    
    let tweet: FlightTweet
    let isIncoming: Bool
    let isLast: Bool
    
    let store: TweetStore
    
    private var chatBubble: some View {
        RoundedRectangle(cornerRadius: 6)
            .foregroundColor(isIncoming ? .white : .accentColor)
            .shadow(color: .shadow, radius: 2, x: 0, y: 1)
    }
    
    private var ticket: some View {
        VStack {
            
            HStack {
                Text(tweet.flightDate)
                    .font(Font.subheadline)
                Spacer()
                Image("mu")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16)
                Text(tweet.flightNo)
                    .font(Font.footnote.weight(.bold))
            }
            .padding(.bottom, -5)
            
            Divider()
            
            HStack {
                Text(tweet.depCity)
                    .font(Font.headline)
                Spacer()
                Image("departure")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16)
                Spacer()
                Text(tweet.arrCity)
                    .font(Font.headline)
            }
            
            HStack {
                Text(tweet.depTime)
                    .font(Font.headline)
                    .foregroundColor(.deepBlue)
                Spacer()
                Text(tweet.arrTime)
                    .font(Font.headline)
                    .foregroundColor(.deepBlue)
            }
        }
        .padding(10)
        .foregroundColor(isIncoming ? .body : .white)
        .modifier(BodyText())
        .background(chatBubble)
        .frame(maxWidth: 230)
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
                
                ticket
                
                Spacer()
            } else {
                
                Spacer()
                
                ticket
                
                if isLast {
                    chatBubbleTriange(width: 15, height: 14, isIncoming: false)
                    RoleView(icon: tweet.role.icon)
                } else {
                    Spacer().frame(width: 61)
                }
            }
        }.onTapGesture(perform: tapEvent)
    }
    
    private func tapEvent() {
        store.send(tweet.flightNo)
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
