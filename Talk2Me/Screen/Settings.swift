//
//  Settings.swift
//  Talk2Me
//
//  Created by 周煜杰 on 2025/9/16.
//

import SwiftUI

// MARK: - Settings View

struct SettingsView: View {
    @State private var notificationsEnabled = true
    @State private var darkModeEnabled = false
    @State private var fontSize: Double = 16
    
    var body: some View {
        NavigationView {
            Form {
                Section("通用设置") {
                    Toggle("推送通知", isOn: $notificationsEnabled)
                    Toggle("深色模式", isOn: $darkModeEnabled)
                }
                
                Section("编辑器设置") {
                    HStack {
                        Text("字体大小")
                            .font(.system(size:fontSize))
                        Spacer()
                        Text("\(Int(fontSize))pt")
                            .foregroundColor(.secondary)
                    }
                    Slider(value: $fontSize, in: 12 ... 24, step: 1)
                }
                
                Section("关于应用") {
                    HStack {
                        Text("版本")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("构建号")
                        Spacer()
                        Text("1")
                            .foregroundColor(.secondary)
                    }
                }
                
                Section("支持") {
                    Button("反馈问题") {
                        // 处理反馈
                    }
                    
                    Button("评价应用") {
                        // 跳转到App Store评价
                    }
                    
                    Button("隐私政策") {
                        // 显示隐私政策
                    }
                }
            }
            .navigationTitle("设置")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    SettingsView()
}
