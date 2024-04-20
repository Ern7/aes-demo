//
//  ReceiverView.swift
//  AESDemo
//
//  Created by Ernest Nyumbu on 2024/04/20.
//

import SwiftUI

struct ReceiverView: View {
    var buttonTapAction: (() -> Void)?
    var viewModel: HomeViewModel
    
    var body: some View {
        HStack {
            Text("Alice")
                .fontWeight(.bold)
        }
        .frame(maxWidth: .infinity)
        .padding(0)
        
        // Bottom Half
        VStack {
            
            VStack() {
                
                HStack(spacing: 10) {
                    Spacer()
                    SpeechBubbleView(text: "Hey Alice!", isOutgoing: true)
                    AvatarView(imageName: "bob")
                }
                
                if !viewModel.messageSent.isEmpty {
                    
                    if(viewModel.isPlaneTextVisible) {
                        
                        HStack(spacing: 10) {
                            AvatarView(imageName: "alice")
                            
                            SpeechBubbleView(text: viewModel.decryptedMessage, isOutgoing: false, buttonTapAction: buttonTapAction, buttonText: viewModel.toggleButtonText)
                            Spacer()
                        }
                        .transition(.opacity)
                        
                    }
                    else {
                        HStack(spacing: 10) {
                            AvatarView(imageName: "alice")
                            
                            SpeechBubbleView(text: viewModel.encryptedMessage, isOutgoing: false, buttonTapAction: buttonTapAction, buttonText: viewModel.toggleButtonText)
                            Spacer()
                        }
                        .transition(.opacity)
                    }
                }
                Spacer()
            }
            .padding()
        }
        .frame(maxHeight: .infinity)
        .background(Color.init(hex: "#FFFFFF"))
    }
}

#Preview {
    ReceiverView(viewModel: HomeViewModel())
}
