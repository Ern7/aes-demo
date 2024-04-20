//
//  HomeViewModel.swift
//  AESDemo
//
//  Created by Ernest Nyumbu on 2024/04/20.
//

import Foundation

class HomeViewModel : ObservableObject {
    
    @Published var messageSent: String = ""
    @Published var encryptedMessage: String = ""
    @Published var decryptedMessage: String = ""
    @Published var errorMessage: String = ""
    @Published var isPlaneTextVisible: Bool = false
    @Published var toggleButtonText: String = "Decrypt message"
    
    private var chatSession = ChatSession()
    private var chatPlayer = ChatPlayer(audioFile: "imessagesoundeffect");
    private var encryptedMessageData: Data?
    
    func sendMessage(message: String) {
        errorMessage = ""
        isPlaneTextVisible = false;
        toggleButtonText = "Decrypt message";
        messageSent = message;
        let result = chatSession.encryptMessage(message: message)
        
        switch result {
        case .success(let _encryptedMessageData):
            encryptedMessageData = _encryptedMessageData
            encryptedMessage = _encryptedMessageData.base64EncodedString()
            chatPlayer.play()
        case .failure(let error):
            encryptedMessage = ""
            errorMessage = error.localizedDescription
        }
    }
    
    func decryptMessage() {
        guard let _encryptedMessageData = encryptedMessageData else {
            errorMessage = "Encrypted message data is nil."
            return
        }
        let result = chatSession.decryptMessage(encryptedData: _encryptedMessageData)
        
        switch result {
        case .success(let _decryptedMessage):
            decryptedMessage = _decryptedMessage
        case .failure(let error):
            decryptedMessage = ""
            errorMessage = error.localizedDescription
        }
    }
    
    func toggle(){
        if (isPlaneTextVisible) {
            toggleButtonText = "Decrypt message"
        }
        else {
            decryptMessage();
            toggleButtonText = "Hide message"
        }
        isPlaneTextVisible = !isPlaneTextVisible
    }
}
