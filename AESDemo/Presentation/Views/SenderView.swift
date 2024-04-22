//
//  SenderView.swift
//  AESDemo
//
//  Created by Ernest Nyumbu on 2024/04/22.
//

import SwiftUI

struct SenderView: View {
    @State private var senderMessage = ""
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack {
            VStack {
                HStack(spacing: 10) {
                    AvatarView(imageName: "bob")
                    SpeechBubbleView(text: "Hey Alice!", isOutgoing: false)
                    Spacer()
                }
                .transition(.opacity)
                
                if !viewModel.messageSent.isEmpty {
                    HStack(spacing: 10) {
                        Spacer()
                        SpeechBubbleView(text: viewModel.messageSent, isOutgoing: true)
                        AvatarView(imageName: "alice")
                    }
                    .transition(.opacity)
                }
                
                Spacer()
                HStack(spacing: 0) {
                    TextField("", text: $senderMessage,  onCommit: handleSendMessageAction)
                        .placeholder(when: senderMessage.isEmpty) {
                            Text("Enter message...").foregroundColor(.gray)
                        }
                        .frame(height: 45)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding([.horizontal], 10)
                        .cornerRadius(8)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.init(hex: "#999999")))
                        .padding([.horizontal], 0)
                        .keyboardType(.default)
                    
                    Spacer()
                    Button(action: handleSendMessageAction) {
                        Image(systemName: "paperplane.fill")
                            .resizable()
                            .frame(width: 20, height: 20) // Set the size of the icon
                            .padding(11)
                            .foregroundColor(.white)
                            .background(senderMessage.count > 0 ? Color.blue : Color.init(hex: "#438AFE"))
                            .clipShape(Circle())
                            .frame(width: 50, height: 50) // Set the size of the background frame
                        
                    }
                    .disabled(senderMessage.isEmpty)
                }
            }
            .frame(maxHeight: .infinity)
            .padding()
        }
        .frame(maxHeight: .infinity)
        .background(Color.init(hex: "#FFFFFF"))
    }
    
    private func handleSendMessageAction() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        
        withAnimation {
            viewModel.sendMessage(message: senderMessage)
            DispatchQueue.main.async {
                senderMessage = "";
            }
        }
    }
}
#Preview {
    SenderView(viewModel: HomeViewModel())
}
