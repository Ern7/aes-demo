//
//  ChatSession.swift
//  AESDemo
//
//  Created by Ernest Nyumbu on 2024/04/20.
//

import Foundation
import CryptoKit

/// ChatSession is a class responsible for maintaing the session of the chat.
/// It holds session data such as the symmentric key.
/// It also contains session actions such as initiating encryption and decryption of data.
class ChatSession {

    private var symmetricKey: SymmetricKey

    init() {
        symmetricKey = Cryptography.generateSessionKey()
    }

    /// This method attempts to encrypt a message. The method makes use of the symmetricKey
    /// and IV generated during the initialization of the class.
    /// - Parameter message: The text to be encrypted
    /// - Returns: Returns a Result. If the encryption is successful,
    /// Result will contain the encrypted data as type Data. If the encryption fails, Result will contain an error.
    func encryptMessage(message: String) -> Result<Data, Error> {
        do {
            let initializationVectorData = Cryptography.generateRandomIV()
            let messageData = message.data(using: .utf8)!
            let encryptedData = try Cryptography.encryptAES256(data: messageData,
                                                               key: symmetricKey,
                                                               initializationVector: initializationVectorData)
            return .success(encryptedData)
        } catch {
            return .failure(error)
        }

    }

    /// This methods decrypts a data object. The method makes use of the symmetricKey
    /// and IV generated during the initialization of the class.
    /// - Parameter encryptedData: The encrypted data.
    /// - Returns: Returns a Result. If the decryption is successful,
    /// Result will contain the decrypted text as type String. If the decryption fails, Result will contain an error.
    func decryptMessage(encryptedData: Data) -> Result<String, Error> {
        do {
            let decryptedData = try Cryptography.decryptAES256(data: encryptedData, key: symmetricKey)
            let decryptedText = String(data: decryptedData, encoding: .utf8)!
            return .success(decryptedText)
        } catch {
            return .failure(error)
        }

    }
}
