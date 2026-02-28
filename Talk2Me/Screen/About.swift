//
//  About.swift
//  Talk2Me
//
//  Created by 周煜杰 on 2025/9/16.
//

import SwiftUI

// MARK: - About View
struct AboutView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // 应用图标和名称
                    VStack(spacing: 16) {
                        Image(systemName: "doc.text.fill")
                            .font(.system(size: 80))
                            .foregroundColor(.blue)
                        
                        Text("Talk2Me")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    .padding(.top, 40)
                    
                    // 功能介绍
                    VStack(alignment: .leading, spacing: 16) {
                        Text("主要功能")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        FeatureRow(icon: "doc.text", title: "Markdown编辑", description: "支持实时预览和语法高亮")
                        FeatureRow(icon: "message", title: "AI聊天", description: "智能对话助手，随时为你解答")
                        FeatureRow(icon: "paintbrush", title: "主题切换", description: "支持深色和浅色主题")
                        FeatureRow(icon: "square.and.arrow.up", title: "导出分享", description: "支持多种格式导出")
                    }
                    .padding(.horizontal)

                    
                    Spacer()
                }
            }
            .navigationTitle("关于")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview{
    AboutView()
}
