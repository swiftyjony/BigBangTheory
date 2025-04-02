//
//  BBModel.swift
//  BigBangTheory
//
//  Created by Jon Gonzalez on 2/4/25.
//

import Foundation
import SwiftData

@Model
final class BBModel {
    @Attribute(.unique) var id: Int
    var favorited: Bool
    var watched: Bool
    var notes: String

    init(id: Int, favorited: Bool, watched: Bool, notes: String) {
        self.id = id
        self.favorited = favorited
        self.watched = watched
        self.notes = notes
    }
}
