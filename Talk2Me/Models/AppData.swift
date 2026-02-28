//
//  AppData.swift
//  Talk2Me
//
//  Created by 周煜杰 on 2025/9/16.
//
import SwiftUI
import CoreData

// MARK: - Chat Message Model

struct ChatMessage: Identifiable {
    let id = UUID()
    let content: String
    let isUser: Bool
    let timestamp = Date()
    let replyName: String
}


