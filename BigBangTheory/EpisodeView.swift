//
//  EpisodeView.swift
//  BigBangTheory
//
//  Created by Jon Gonzalez on 1/4/25.
//

import SwiftUI

struct EpisodeView: View {
    @Environment(OrientationVM.self) private var orientationVM
    let episode: BigBangModel
    let namespace: Namespace.ID

    var body: some View {
        ScrollView {
            VStack {
                Image(episode.image)
                    .resizable()
                    .aspectRatio(contentMode: isiPad && orientationVM.isLandscape ? .fill : .fit)
                    .navigationTransition(.zoom(sourceID: "cover\(episode.id)", in: namespace)) 
//                    .matchedGeometryEffect(id: "cover\(episode.id)", in: namespace)
                    .frame(maxHeight: isiPad && orientationVM.isLandscape ? 350 : .infinity)
                    .clipped()
                    .overlay(alignment: .bottom) {
                        VStack(alignment: .leading) {
                            Text(episode.name)
                                .font(.bbTitle)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .navigationTransition(.zoom(sourceID: "title\(episode.id)", in: namespace))
//                                .matchedGeometryEffect(id: "title\(episode.id)", in: namespace)
                            Text(episode.episodeInfo)
                                .font(.bbBody)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .navigationTransition(.zoom(sourceID: "info\(episode.id)", in: namespace))
//                                .matchedGeometryEffect(id: "info\(episode.id)", in: namespace)
                        }
                        .foregroundStyle(.background)
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
                    HStack {
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
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.bbBody)
                .safeAreaPadding()
            }
        }
        .ignoresSafeArea()
        
    }
}

#Preview {
    @Previewable @Namespace var namespace
    EpisodeView(episode: .test, namespace: namespace)
}
