//
//  ChatSpeechBubbleView.swift
//  AESDemo
//
//  Created by Ernest Nyumbu on 2024/04/20.
//

import SwiftUI

struct SpeechBubbleView: View {
    var text: String
    var isOutgoing: Bool
    var buttonTapAction: (() -> Void)?
    var buttonText: String = ""

    @State private var incomingTextWidth: CGFloat = 0

    var body: some View {
        Group {
            if isOutgoing {
                outgoingBubble
            } else {
                incomingBubble
            }
        }
    }

    var incomingBubble: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(text)
                .padding(10)
                .foregroundColor(Color.init(hex: "#2D2D2D"))
                .background(Color.init(hex: "#EEEEEE"))
                .clipShape(ChatBubbleShape(isOutgoing: false))

            if let custombuttonTapAction = buttonTapAction {
                HStack(alignment: .center) {
                    Spacer()
                    Button(action: custombuttonTapAction) {
                        Text(buttonText)
                    }
                    .frame(height: 20)
                    Spacer()
                }
                .padding(10)
                .background(Color.init(hex: "#EEEEEE"))
                    .clipShape(DecryptActionChatBubbleShape())
                .frame(width: self.incomingTextWidth)
                .frame(minWidth: 200)
            }
        }
        .background(GeometryReader { geometry in
            Color.clear.onAppear {
                self.incomingTextWidth = geometry.size.width
            }
        })
    }

    var outgoingBubble: some View {
        VStack(alignment: .trailing, spacing: 8) {
            Text(text)
                .padding(10)
                .foregroundColor(.white)
                .background(Color.init(hex: "#438AFE"))
                .clipShape(ChatBubbleShape(isOutgoing: true))
        }
    }
}

#Preview {
    SpeechBubbleView(text: "Hey Jane, whats up!", isOutgoing: true, buttonText: "Decrypt text")
}
