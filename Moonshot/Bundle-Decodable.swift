//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Rodrigo Cavalcanti on 04/02/21.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()
        
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "y-MM-dd" //y: ano, MM mês sempre com dois dígitos(ex:01), dia sempre com dois dígito(ex:01). OBS: MM = mês, mm = minuto
        decoder.dateDecodingStrategy = .formatted(formatter)
        //Isso diz ao decodificador para analisar as datas no formato exato que esperamos.

        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }

        return loaded
    }
}
