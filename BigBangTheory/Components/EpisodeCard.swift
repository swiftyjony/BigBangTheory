//
//  EpisodeCard.swift
//  BigBangTheory
//
//  Created by Jon Gonzalez on 31/3/25.
//

import SwiftUI

struct EpisodeCard: View {
    let episode: BigBangModel
    let namespace: Namespace.ID

    var body: some View {
        Image(episode.image)
            .resizable()
            .scaledToFill()
            .matchedTransitionSource(id: "cover\(episode.id)", in: namespace) // Solo funciona a partir de iOS 18 y con transiciones completas, es decir, o un push o un fullScreenCover...
//            .matchedGeometryEffect(id: "cover\(episode.id)", in: namespace, isSource: true)
            .frame(width: isiPad ? 350 : 250,
                   height: isiPad ? 200 : 150)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: .primary.opacity(0.4), radius: 5, x: 0, y: 5)
            .overlay(alignment: .bottom) {
                VStack(alignment: .leading) {
                    Text(episode.name)
                        .font(.bbBody)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .matchedTransitionSource(id: "title\(episode.id)", in: namespace)
//                        .matchedGeometryEffect(id: "title\(episode.id)", in: namespace, isSource: true)
                    Text(episode.episodeInfo)
                        .font(.bbSubheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .matchedTransitionSource(id: "info\(episode.id)", in: namespace)
//                        .matchedGeometryEffect(id: "info\(episode.id)", in: namespace, isSource: true)
                }
                .multilineTextAlignment(.leading)
                .foregroundStyle(.background)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(10)
                .background {
                    SemiRoundedRectangle(cornerRadius: 10)
                        .fill(Color.black.opacity(0.2))
                }
            }
            .padding(.bottom)
    }
}

#Preview {
    @Previewable @Namespace var namespace
    EpisodeCard(episode: .test, namespace: namespace)
}
