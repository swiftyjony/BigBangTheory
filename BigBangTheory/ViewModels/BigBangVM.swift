//
//  BigBangVM.swift
//  BigBangTheory
//
//  Created by Jon Gonzalez on 31/3/25.
//

import SwiftUI

@Observable
final class BigBangVM {
    let repository: DataRepository

    var episodes: [BigBangModel]

    init(repository: DataRepository = Repository()) {
        self.repository = repository
        do {
            self.episodes = try repository.loadBigBangTheoryJSON()
        } catch {
            self.episodes = []
            print(error)
        }
    }

    func getEpisodesAtSeason(_ season: Int) -> [BigBangModel] {
        episodes.filter { $0.season == season }
    }
}
