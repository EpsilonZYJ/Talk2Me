//
//  Settings.swift
//  Talk2Me
//
//  Created by 周煜杰 on 2025/9/16.
//

import SwiftUI

// MARK: - Settings View

struct SettingsView: View {
    @StateObject var appSettings = AppSettings.shared
    
    var body: some View {
        NavigationView {
            Form {
                Section("通用设置") {
                    Toggle("推送通知", isOn: $appSettings.notificationsEnabled)
                    // TODO: 添加可选择的显示模式设置
                 }
                
                Section("编辑器设置") {
                    HStack {
                        Text("字体大小")
                        Spacer()
                        Text("\(Int(appSettings.fontSize))pt")
                            .foregroundColor(.secondary)
                    }
                    Slider(value: $appSettings.fontSize, in: 12 ... 24, step: 1)
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
            .font(.system(size: appSettings.fontSize))
        }
    }
}

#Preview {
    SettingsView()
}
