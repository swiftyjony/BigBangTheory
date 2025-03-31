//
//  ContentView.swift
//  BigBangTheory
//
//  Created by Jon Gonzalez on 1/4/25.
//

import SwiftUI

struct ContentView: View {
    @State var vm = BigBangVM()

    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(1..<13) { season in
                    Section {
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 20) {
                                ForEach(vm.getEpisodesAtSeason(season)) { episode in
                                    EpisodeCard(episode: episode)
                                }
                            }
                        }
                    } header: {
                        HStack {
                            Text("Season \(season)")
                                .font(.bbTitle)
//                                .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                            Image("season\(season)")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 50)
                        }
                    }
                }
            }
            .safeAreaPadding()
        }
    }
}

#Preview {
    ContentView(vm: BigBangVM(repository: RepositoryTest()))
}
