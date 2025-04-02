//
//  EpisodeView.swift
//  BigBangTheory
//
//  Created by Jon Gonzalez on 1/4/25.
//

import SwiftUI
import SwiftData

struct EpisodeView: View {
    @Environment(\.modelContext) private var context
    @Environment(OrientationVM.self) private var orientationVM
    let episode: BigBangModel
    let namespace: Namespace.ID

    @Query private var metaEpisodes: [BBModel]
    @State private var editedNotes = ""

    init(episode: BigBangModel, namespace: Namespace.ID) {
        self.episode = episode
        self.namespace = namespace
        _metaEpisodes = Query(filter: #Predicate { $0.id == episode.id })
    }

    var body: some View {
        ScrollView {
            VStack {
                Image(episode.image)
                    .resizable()
                    .aspectRatio(contentMode: isiPad && orientationVM.isLandscape ? .fill : .fit)
                #if os(iOS) || os(tvOS)
                    .navigationTransition(.zoom(sourceID: "cover\(episode.id)", in: namespace))
                #endif
//                    .matchedGeometryEffect(id: "cover\(episode.id)", in: namespace)
                    .frame(maxHeight: isiPad && orientationVM.isLandscape ? 350 : .infinity)
                    .clipped()
                    .overlay(alignment: .bottom) {
                        VStack(alignment: .leading) {
                            Text(episode.name)
                                .font(.bbTitle)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            #if os(iOS) || os(tvOS)
                                .navigationTransition(.zoom(sourceID: "title\(episode.id)", in: namespace))
                            #endif
//                                .matchedGeometryEffect(id: "title\(episode.id)", in: namespace)
                            Text(episode.episodeInfo)
                                .font(.bbBody)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                #if os(iOS) || os(tvOS)
                                .navigationTransition(.zoom(sourceID: "info\(episode.id)", in: namespace))
                                #endif
//                                .matchedGeometryEffect(id: "info\(episode.id)", in: namespace)
                        }
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(10)
                        .background {
                            SemiRoundedRectangle(cornerRadius: 10)
                                .fill(Color.black.opacity(0.2))
                        }
                    }
                VStack(alignment: .leading) {
                    Text(episode.summary)
                        .font(.bbBody)
                    HStack {
                        Text(episode.airdateString)
                        Spacer()
                        Text("\(episode.runtime) min.")
                    }
                    HStack(alignment: .top) {
                        if let meta = metaEpisodes.first {
                            VStack(alignment: .leading) {
                                Button {
                                    meta.watched.toggle()
                                } label: {
                                    Label(meta.watched ? "Watched" : "Not Watched", systemImage: "eye")
                                        .symbolVariant(meta.watched ? .fill : .fill.slash)
//                                        .foregroundStyle(meta.watched ? .green : .black)
                                }
                                .tint(meta.watched ? .green : .gray)
//                                .frame(height: 30, alignment: .bottom)
                                Button {
                                    meta.favorited.toggle()
                                } label: {
                                    Label(meta.favorited ? "Favorited" : "Not Favorited", systemImage: "star")
                                        .symbolVariant(meta.favorited ? .fill : .fill.slash)
//                                        .foregroundStyle(meta.favorited ? .green : .black)
                                }
                                .tint(meta.favorited ? .green : .gray)
//                                .frame(height: 15, alignment: .bottom)
                            }
                            .buttonStyle(.borderedProminent)
                            .contentTransition(.symbolEffect(.replace))
                            .animation(.default, value: meta.favorited)
                            .animation(.default, value: meta.watched)
                        }
                        Spacer()
                        Link(destination: episode.url) {
                            VStack {
                                Image(.tvmazeIcon)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 75)
                                Text("More info")
                                    .font(.bbSubheadline)
                            }
                        }
                    }
                    .padding(.top, 20)

                    Text("Notes:")
                        .padding(.top, 10)
                    TextField("Insert notes for the episode",
                              text: $editedNotes,
                              axis: .vertical)
                    .font(.bbSubheadline)
                    .lineLimit(3, reservesSpace: true)
                    .padding()
                    .background {
                        Color.gray.opacity(0.2)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    HStack {
                        Button {
                            if let episode = metaEpisodes.first {
                                episode.notes = editedNotes
                            }
                        } label: {
                            Text("Update note")
                        }
                        .font(.bbSubheadline)
                        .buttonStyle(.borderedProminent)

                        if let episode = metaEpisodes.first {
                            if episode.notes == editedNotes {
                                Image(systemName: "checkmark")
                                    .foregroundStyle(.green)
                                    .symbolVariant(.fill.circle)
                            } else {
                                Image(systemName: "xmark")
                                    .foregroundStyle(.red)
                                    .symbolVariant(.fill.circle)
                            }
                        }
                    }

                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.bbBody)
                .safeAreaPadding()
            }
        }
        .ignoresSafeArea()
        .onAppear {
            if metaEpisodes.count == 0 {
                let newBB = BBModel(id: episode.id, favorited: false, watched: false, notes: "")
                context.insert(newBB)
            }
            if let episode = metaEpisodes.first {
                editedNotes = episode.notes
            }
        }

    }
}

#Preview(traits: .sampleData) {
    @Previewable @Namespace var namespace
    EpisodeView(episode: .test, namespace: namespace)
        .environment(OrientationVM())
}
