//
//  BigBangNavigation.swift
//  BigBangTheory
//
//  Created by Jon Gonzalez on 1/4/25.
//

import SwiftUI

fileprivate struct BigBangNavigation: ViewModifier {
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("The Big Bang Theory")
                        .font(.bbLargeTitle)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .toolbarTitleDisplayMode(.inline)
    }
}

extension View {
    var bigBangNavigation: some View {
        modifier(BigBangNavigation())
    }
}
