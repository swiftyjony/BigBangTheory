//
//  RepositoryTest.swift
//  BigBangTheory
//
//  Created by Jon Gonzalez on 31/3/25.
//

import Foundation

struct RepositoryTest: DataRepository {
    var url: URL {
        Bundle.main.url(forResource: "BigBangTest", withExtension: "json")!
    }
    func loadBigBangTheoryJSON() throws -> [BigBangModel] {
        try load(url: url, type: [BigBangModel].self, decoder: decoder)
    }
}

extension BigBangModel {
    static let test = BigBangModel(id: 2992,
                                   name: "The Toast Derivation",
                                   season: 4,
                                   number: 17,
                                   summary: "Sheldon struggles to cope when he realizes it's actually Leonard who is the center of their social group.\n",
                                   runtime: 30,
                                   airdate: Date(),
                                   image: "12337",
                                   url: URL(string: "https://www.tvmaze.com/episodes/2992/the-big-bang-theory-4x17-the-toast-derivation")!)
}

extension ContentView {
//    static ver preview: some View {
//        
//    }
}
