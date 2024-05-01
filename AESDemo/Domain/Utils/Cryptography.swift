//
//  Cryptography.swift
//  AESDemo
//
//  Created by Ernest Nyumbu on 2024/04/20.
//

import CryptoKit
import Foundation

/// This class is responsible for performing any Cryptographic tasks such as encryption,
/// decryption, generating random keys and generating randomg Initialization Vector.
class Cryptography {

    /// Performs data encryption using the Advanced Encryption Standard.
    /// - Parameters:
    ///   - data: The data to be encrypted.
    ///   - key: The symmetric key for encryption.
    ///   - iv: The  Initialization Vector. The IV ensures that even if the same plaintext
    ///   is encrypted multiple times with the same key, the resulting ciphertext will be different
    /// - Returns: Returns the Encrypted Data
    static func encryptAES256(data: Data, key: SymmetricKey, initializationVector: Data) throws -> Data {
        guard let nonce = try? AES.GCM.Nonce(data: initializationVector) else {
            throw CryptographyError.invalidInitializationVector
        }
        let sealedBox = try AES.GCM.seal(data, using: key, nonce: nonce)
        return sealedBox.combined!
    }

    /// Performs the decryption of data using the Advanced Encryption Standard
    /// - Parameters:
    ///   - data: The data to be decrypted.
    ///   - key: The symmetric key used for decryption.
    /// - Returns: Returns the decrypted data as type Data
    static func decryptAES256(data: Data, key: SymmetricKey) throws -> Data {
        let sealedBox = try AES.GCM.SealedBox(combined: data)
        return try AES.GCM.open(sealedBox, using: key)
    }

    static func generateRandomIV() -> Data {
        var ivData = Data(count: 12)
        _ = ivData.withUnsafeMutableBytes { mutableBytes in
            SecRandomCopyBytes(kSecRandomDefault, 12, mutableBytes.baseAddress!)
        }
        return ivData
    }

    /// Generates an encryption key to be used for both encryption and decryption.
    /// - Returns: Returns a SymmetricKey
    static func generateSessionKey() -> SymmetricKey {
        return SymmetricKey(size: .bits256)
    }

}
