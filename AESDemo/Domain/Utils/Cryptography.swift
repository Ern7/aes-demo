//
//  Cryptography.swift
//  AESDemo
//
//  Created by Ernest Nyumbu on 2024/04/20.
//

import CryptoKit
import Foundation

class Cryptography {
    
    static func encryptAES256(data: Data, key: SymmetricKey, iv: Data) throws -> Data {
        guard let nonce = try? AES.GCM.Nonce(data: iv) else {
            throw CryptographyError.invalidInitializationVector
        }
        let sealedBox = try AES.GCM.seal(data, using: key, nonce: nonce)
        return sealedBox.combined!
    }

    static func decryptAES256(data: Data, key: SymmetricKey) throws -> Data {
        let sealedBox = try AES.GCM.SealedBox(combined: data)
        return try AES.GCM.open(sealedBox, using: key)
    }

    static func generateRandomIV() -> Data{
        var ivData = Data(count: 12)
        _ = ivData.withUnsafeMutableBytes { mutableBytes in
            SecRandomCopyBytes(kSecRandomDefault, 12, mutableBytes.baseAddress!)
        }
        return ivData;
    }
    
    static func generateSessionKey() -> SymmetricKey {
        return SymmetricKey(size: .bits256);
    }
    
}

