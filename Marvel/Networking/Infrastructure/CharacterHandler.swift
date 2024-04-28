//  CharacterHandler.swift
//  Marvel
//
//  Created by Nico on 28.04.24.
//  
//

import Foundation
import CommonCrypto

extension String {
    var md5: String {
        let data = Data(self.utf8)
        let hash = data.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) -> [UInt8] in
            var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
            CC_MD5(bytes.baseAddress, CC_LONG(data.count), &hash)
            return hash
        }
        return hash.map { String(format: "%02x", $0) }.joined()
    }
}

class CharacterHandler: CharacterHandlerIntf {
    
    func fetchCharacters(offset: Int, completion: @escaping (CharactersDTO) -> ()) {
        let publicKey = "938880b372ef524e77ed0667b7d46dd2"
        let privateKey = "84f5b7e88605a57241b4a352aed2e252d950a187"
        let baseURL = "https://gateway.marvel.com/v1/public/characters"
        
        // Erstelle einen Zeitstempel für die Anfrage
        let ts = String(Date().timeIntervalSince1970)
        
        // Erstelle einen Hash-Wert für die Anfrage
        let hash = "\(ts)\(privateKey)\(publicKey)".md5
        
        // Erstelle die URL für die Anfrage
        guard var components = URLComponents(string: baseURL) else {
            print("Ungültige URL")
            return
        }
        components.queryItems = [
            URLQueryItem(name: "apikey", value: publicKey),
            URLQueryItem(name: "ts", value: ts),
            URLQueryItem(name: "hash", value: hash)
        ]
        
        guard let url = components.url else {
            print("Fehler beim Erstellen der URL")
            return
        }
        
        // Führe die Anfrage aus
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("Keine Daten erhalten: \(error?.localizedDescription ?? "Unbekannter Fehler")")
                return
            }
            
            let charactersDTO = try! JSONDecoder().decode(CharactersDTO.self, from: data)
            /*guard let charactersDTO = charactersDTO else {
                print("Fehler beim Umwandeln")
                return
            }*/
            
            DispatchQueue.main.async {
                completion(charactersDTO)
            }
        }.resume()
    }
}
