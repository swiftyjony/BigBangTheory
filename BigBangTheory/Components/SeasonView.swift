//
//  SeasonView.swift
//  BigBangTheory
//
//  Created by Jon Gonzalez on 1/4/25.
//

import SwiftUI

struct SeasonView: View {
    @Environment(BigBangVM.self) private var vm
    let season: Int
    let namespace: Namespace.ID

    var body: some View {
        Section {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 20) {
                    ForEach(vm.getEpisodesAtSeason(season)) { episode in
                        Button {
                            vm.selectedEpisode = episode
                        } label: {
                            EpisodeCard(episode: episode, namespace: namespace)
                                .hoverEffect(.lift)
                        }
                    }
                }
            }
        } header: {
            HStack {
                Text("Season \(season)")
                    .font(.bbTitle)
                Spacer()
                Image("season\(season)")
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .frame(height: isiPad ? 100 : 50)
            }
            .padding(.top)
        }
    }
}

#Preview(traits: .fixedLayout(width: 390, height: 200)) {
    @Previewable @Namespace var namespace
    SeasonView(season: 1, namespace: namespace)
        .environment(BigBangVM(repository: RepositoryTest()))
}
