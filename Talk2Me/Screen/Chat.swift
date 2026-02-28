//
//  Chat.swift
//  Talk2Me
//
//  Created by 周煜杰 on 2025/9/16.
//

// MARK: - Chat View

import SwiftUI

struct ChatView: View {
    @State private var messages: [ChatMessage] = [
        ChatMessage(content: "你好！我是AI助手，有什么可以帮助你的吗？", isUser: false, replyName: "DeepSeek-R1"),
        ChatMessage(content: "你好，请帮我写一个Swift函数", isUser: true, replyName: "You"),
        ChatMessage(content: "当然可以！请告诉我你需要什么样的函数功能。", isUser: false, replyName: "DeepSeek-R1")
    ]
    @State private var inputText = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                // 消息列表
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(messages) { message in
                            ChatBubbleView(content: message.content, isUser: message.isUser)
                        }
                    }
                    .padding()
                }
                
                // 输入框
                HStack {
                    TextField("输入消息...", text: $inputText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: sendMessage) {
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(.white)
                            .padding(8)
                            .background(inputText.isEmpty ? Color.gray : Color.blue)
                            .clipShape(Circle())
                    }
                    .disabled(inputText.isEmpty)
                }
                .padding()
            }
            .navigationTitle("AI聊天")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    private func sendMessage() {
        guard !inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        
        // 添加用户消息
        let userMessage = ChatMessage(content: inputText, isUser: true, replyName: "You")
        messages.append(userMessage)
        
        // 清空输入框
        let messageToSend = inputText
        inputText = ""
        
        // 模拟AI回复
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let aiResponse = generateAIResponse(for: messageToSend)
            let aiMessage = ChatMessage(content: aiResponse, isUser: false, replyName: "DeepSeek-R1")
            messages.append(aiMessage)
        }
    }
    
    private func generateAIResponse(for input: String) -> String {
        // 简单的模拟回复逻辑
        let responses = [
            "这是一个很有趣的问题！",
            "让我来帮你解决这个问题。",
            "我理解你的需求，这里是我的建议：",
            "根据你的描述，我认为可以这样做：",
            "这个问题很常见，通常的解决方案是："
        ]
        return responses.randomElement() ?? "我正在思考中..."
    }
}

#Preview {
    var messages: [ChatMessage] = [
        ChatMessage(content: "你好！我是AI助手，有什么可以帮助你的吗？", isUser: false, replyName: "DeepSeek-R1"),
        ChatMessage(content: "你好，请帮我写一个Swift函数", isUser: true, replyName: "You"),
        ChatMessage(content: "当然可以！请告诉我你需要什么样的函数功能。", isUser: false, replyName: "DeepSeek-R1")
    ]
    ChatView()
}
