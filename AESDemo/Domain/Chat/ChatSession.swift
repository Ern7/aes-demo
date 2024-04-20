//
//  ChatSession.swift
//  AESDemo
//
//  Created by Ernest Nyumbu on 2024/04/20.
//

import Foundation
import CryptoKit

class ChatSession {
    
    private var symmetricKey : SymmetricKey
    private var initializationVectorData : Data
    
    init(){
        symmetricKey = Cryptography.generateSessionKey();
        initializationVectorData = Cryptography.generateRandomIV();
    }
    
    func encryptMessage(message: String) -> Result<Data, Error> {
        do {
            let messageData = message.data(using: .utf8)!
            let encryptedData = try Cryptography.encryptAES256(data: messageData, key: symmetricKey, iv: initializationVectorData)
            return .success(encryptedData);
        } catch {
            return .failure(error)
        }
        
    }
    
    func decryptMessage(encryptedData: Data) -> Result<String, Error> {
        do {
            let decryptedData = try Cryptography.decryptAES256(data: encryptedData, key: symmetricKey)
            let decryptedText = String(data: decryptedData, encoding: .utf8)!
            return .success(decryptedText);
        } catch {
            return .failure(error)
        }
        
    }
}
