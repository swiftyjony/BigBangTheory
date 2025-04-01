//
//  BigBangModel.swift
//  BigBangTheory
//
//  Created by Jon Gonzalez on 31/3/25.
//

import Foundation

struct BigBangModel: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let season: Int
    let number: Int
    let summary: String
    let runtime: Int
    let airdate: Date
    let image: String
    let url: URL
}

extension BigBangModel {
    var episodeInfo: String {
        "S\(season.formatted(.number.precision(.integerLength(2))))E\(number.formatted(.number.precision(.integerLength(2))))"
    }

    var airdateString: String {
        airdate.formatted(.dateTime.day(.twoDigits).month(.wide).year(.defaultDigits))
    }
}
