//
//  EpisodeCard.swift
//  BigBangTheory
//
//  Created by Jon Gonzalez on 31/3/25.
//

import SwiftUI

struct EpisodeCard: View {
    let episode: BigBangModel

    var body: some View {
        Image(episode.image)
            .resizable()
            .scaledToFill()
            .frame(width: 250, height: 150)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: .primary.opacity(0.4), radius: 5, x: 0, y: 5)
            .overlay(alignment: .bottom) {
                VStack(alignment: .leading) {
                    Text(episode.name)
                        .font(.bbBody)
                    Text(episode.episodeInfo)
                        .font(.bbSubheadline)
                }
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
    EpisodeCard(episode: .test)
}
