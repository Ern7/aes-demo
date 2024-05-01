//
//  DecryptActionChatBubbleShape.swift
//  AESDemo
//
//  Created by Ernest Nyumbu on 2024/04/20.
//

import SwiftUI

struct DecryptActionChatBubbleShape: Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: [.topRight, .bottomRight],
                                cornerRadii: CGSize(width: 12, height: 12))
        return Path(path.cgPath)
    }
}
