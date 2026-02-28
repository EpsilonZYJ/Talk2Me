//
//  ChatView.swift
//  Talk2Me
//
//  Created by 周煜杰 on 2025/9/16.
//

// MARK: - Chat Bubble View

import SwiftUI

struct ChatBubbleView: View {
    let content: String
    let isUser: Bool

    var body: some View {
        HStack {
            if isUser {
                Spacer()
                VStack{
                    Text(content)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .frame(maxWidth: .infinity * 0.8, alignment: .trailing)
                }
            } else {
                VStack{
                    Text(content)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .foregroundColor(.primary)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .frame(maxWidth: .infinity * 0.8, alignment: .leading)
                }
                Spacer()
            }
        }
    }
}

#Preview {
    ChatBubbleView(content: "1231432412", isUser: true)
    ChatBubbleView(content: "hhh", isUser: false)
}
