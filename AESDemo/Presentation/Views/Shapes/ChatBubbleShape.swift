//
//  ChatBubbleShape.swift
//  AESDemo
//
//  Created by Ernest Nyumbu on 2024/04/20.
//

import SwiftUI

struct ChatBubbleShape: Shape {
    var isOutgoing: Bool
    func path(in rect: CGRect) -> Path {
        if isOutgoing {
            let path = UIBezierPath(roundedRect: rect,
                                    byRoundingCorners: [.topLeft, .topRight, .bottomLeft],
                                    cornerRadii: CGSize(width: 12, height: 12))
            return Path(path.cgPath)
        } else {
            let path = UIBezierPath(roundedRect: rect,
                                    byRoundingCorners: [.topLeft, .topRight, .bottomRight],
                                    cornerRadii: CGSize(width: 12, height: 12))
            return Path(path.cgPath)
        }
    }
}
