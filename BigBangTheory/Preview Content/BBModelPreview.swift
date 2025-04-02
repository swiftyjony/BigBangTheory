//
//  BBModelPreview.swift
//  BigBangTheory
//
//  Created by Jon Gonzalez on 2/4/25.
//

import SwiftUI
import SwiftData

struct SampleData: PreviewModifier {
    static func makeSharedContext() throws -> ModelContainer {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: BBModel.self, configurations: configuration)

        let episode = BBModel(id: 2992, favorited: false, watched: true, notes: "Este episodio mola mogollón.")
        container.mainContext.insert(episode)
        return container
    }

    func body(content: Content, context: ModelContainer) -> some View {
        content
            .modelContainer(context)
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    @MainActor static var sampleData: Self = .modifier(SampleData())
}
