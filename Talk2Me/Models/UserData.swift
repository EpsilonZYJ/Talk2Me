//
//  UserData.swift
//  Talk2Me
//
//  Created by 周煜杰 on 2025/9/16.
//
import SwiftUI

enum DisplayMode: String, Codable, CaseIterable{
    case dark
    case light
    case auto
}

enum AppSettingsKeys {
    static let displayMode = "displayMode"
    static let fontSize = "fontSize"
    static let notificationsEnabled = "notificationsEnabled"
}

class AppSettings: ObservableObject {
    @Published var notificationsEnabled: Bool {
        didSet {
            UserDefaults.standard.set(notificationsEnabled, forKey: AppSettingsKeys.notificationsEnabled)
        }
    }

    @Published var darkModeEnabled: DisplayMode {
        didSet {
            UserDefaults.standard.set(darkModeEnabled.rawValue, forKey: AppSettingsKeys.displayMode)
        }
    }

    @Published var fontSize: Double {
        didSet {
            UserDefaults.standard.set(fontSize, forKey: AppSettingsKeys.fontSize)
        }
    }

    init() {
        self.notificationsEnabled = UserDefaults.standard.bool(forKey: AppSettingsKeys.notificationsEnabled)
        self.darkModeEnabled = DisplayMode(rawValue: UserDefaults.standard.string(forKey: AppSettingsKeys.displayMode) ?? "auto") ?? .auto
        self.fontSize = UserDefaults.standard.double(forKey: AppSettingsKeys.fontSize) <= 0 ? 16 : UserDefaults.standard.double(forKey: AppSettingsKeys.fontSize)
    }

    static let shared = AppSettings()
}
