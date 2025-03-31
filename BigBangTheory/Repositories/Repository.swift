//
//  Repository.swift
//  BigBangTheory
//
//  Created by Jon Gonzalez on 31/3/25.
//

import CompoKit
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
