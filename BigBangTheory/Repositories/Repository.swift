//
//  Repository.swift
//  BigBangTheory
//
//  Created by Jon Gonzalez on 31/3/25.
//

import Foundation

protocol DataRepository: JSONLoader, Sendable {
    func loadBigBangTheoryJSON() throws -> [BigBangModel]
}

extension DataRepository {
    var url: URL {
        Bundle.main.url(forResource: "BigBang", withExtension: "json")!
    }

    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        return decoder
    }
}

struct Repository: DataRepository {
    func loadBigBangTheoryJSON() throws -> [BigBangModel] {
        try load(url: url, type: [BigBangModel].self, decoder: decoder)
    }
}


// USAR COMPOKIT: SUBIR A GITHUB Y CREAR RELEASE PARA PODER AÑADIRLO AL PROYECTO
protocol JSONLoader {}

extension JSONLoader {
    func load<T>(url: URL, type: T.Type, decoder: JSONDecoder = JSONDecoder()) throws -> T where T: Codable {
        let data = try Data(contentsOf: url)
        return try decoder.decode(type, from: data)
    }

    func save<T>(url: URL, data: T, encoder: JSONEncoder = JSONEncoder()) throws where T: Codable {
        let jsonData = try encoder.encode(data)
        try jsonData.write(to: url, options: [.atomic, .completeFileProtection])
    }
}
