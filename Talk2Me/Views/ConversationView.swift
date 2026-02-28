//
//  ConversationView.swift
//  Talk2Me
//
//  Created by 周煜杰 on 2026/2/28.
//

import SwiftUI

struct ConversationView: View {
    var title: String = "默认话题"
    var lastContent: String = ""

    var body: some View {
        HStack {
            VStack {
                Text(title)
            }
        }
    }
}

#Preview {
    ConversationView()
}
