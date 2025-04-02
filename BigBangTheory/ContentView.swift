//
//  ContentView.swift
//  BigBangTheory
//
//  Created by Jon Gonzalez on 1/4/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(BigBangVM.self) private var vm
    @Namespace private var namespace

    var body: some View {
        @Bindable var vm = vm
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(1..<13) { season in
                        SeasonView(season: season, namespace: namespace)
                    }
                }
            }
            .safeAreaPadding()
            #if os(iOS)
            .bigBangNavigation
            #endif
            .navigationDestination(for: BigBangModel.self) { episode in
                EpisodeView(episode: episode, namespace: namespace)
            }
        }
        #if os(iOS)
        .fullScreenCover(item: $vm.selectedEpisode) { episode in
            EpisodeView(episode: episode, namespace: namespace)
                .circleCloseButton {
                    vm.selectedEpisode = nil
                }
        }
//        #elseif os(macOS)
//        .sheet(item: $vm.selectedEpisode) { episode in
//            EpisodeView(episode: episode, namespace: namespace)
//                .circleCloseButton {
//                    vm.selectedEpisode = nil
//                }
//        }
        #endif
    }
}

#Preview {
    ContentView()
        .environment(BigBangVM(repository: RepositoryTest()))
        .environment(OrientationVM())
}
