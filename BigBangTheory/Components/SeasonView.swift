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
                #if os(iOS) || os(macOS) || os(visionOS)
                LazyHStack(spacing: 20) {
                    ForEach(vm.getEpisodesAtSeason(season)) { episode in
                        #if os(iOS) || os(visionOS)
                        Button {
                            vm.selectedEpisode = episode
                        } label: {
                            EpisodeCard(episode: episode, namespace: namespace)
                                .hoverEffect(.lift)
                        }
                        #if os(visionOS)
                        .buttonStyle(.plain)
                        .buttonBorderShape(.roundedRectangle(radius: 10))
                        #endif
                        #elseif os(macOS)
                        NavigationLink(value: episode) {
                            EpisodeCard(episode: episode, namespace: namespace)
                        }
                        .buttonStyle(.plain)
                        #endif
                    }
                }
                #elseif os(tvOS)
                LazyHStack(spacing: 40) {
                    ForEach(vm.getEpisodesAtSeason(season)) { episode in
                        NavigationLink(value: episode) {
                            EpisodeCard(episode: episode, namespace: namespace)
                        }
                        .buttonStyle(.card)
                    }
                }
                .frame(height: 250)
                #endif

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
