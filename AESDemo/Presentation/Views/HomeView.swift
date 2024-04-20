//
//  HomeView.swift
//  AESDemo
//
//  Created by Ernest Nyumbu on 2024/04/20.
//

import SwiftUI

struct HomeView: View {
    
    @State private var senderMessage = ""
    @State private var encryptedMessage = ""
    @State private var decryptedMessage = ""
    
    @StateObject private var viewModel = HomeViewModel()
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.init(hex: "#F6F6F6")
    
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        NavigationView {
            
     VStack {
         // Top Half
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
                     
                     TextField("Enter message...", text: $senderMessage)
                         .frame(height: 45)
                         .textFieldStyle(PlainTextFieldStyle())
                         .padding([.horizontal], 4)
                         .cornerRadius(8)
                         .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.init(hex: "#999999")))
                         .padding([.horizontal], 0)
                         

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
                 }
             }
             .frame(maxHeight: .infinity)
             .padding()
         }
         .frame(maxHeight: .infinity)
         .background(Color.init(hex: "#FFFFFF"))
         
         Divider()
             .background(Color.init(hex: "#999999"))
         
         ReceiverView(buttonTapAction: handlebuttonTapAction, viewModel: viewModel)
     }
     .background(Color.init(hex: "#F6F6F6"))
     .navigationBarTitle("Bob", displayMode: .inline)
    }
}
    
    func handleSendMessageAction() {
        withAnimation {
            viewModel.sendMessage(message: senderMessage)
            senderMessage = "";
        }
    }
    
    func handlebuttonTapAction() {
        withAnimation {
            viewModel.toggle()
        }
    }
}

#Preview {
    HomeView()
}
