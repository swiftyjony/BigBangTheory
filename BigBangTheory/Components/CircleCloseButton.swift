//
//  CircleCloseButton.swift
//  BigBangTheory
//
//  Created by Jon Gonzalez on 1/4/25.
//

import SwiftUI

fileprivate struct CircleCloseButton: ViewModifier {
    let action: () -> Void

    func body(content: Content) -> some View {
        content
            .overlay(alignment: .topTrailing) {
                Button {
                    action()
                } label: {
                    Image(systemName: "xmark")
                        .symbolVariant(.circle.fill)
                }
                .buttonBorderShape(.circle)
                .font(.title)
                .foregroundStyle(.white.opacity(0.5))
                .padding(.trailing)
                #if os(iOS)
                .hoverEffect(.highlight)
                #endif
            }
    }
}

extension View {
    func circleCloseButton(action: @escaping () -> Void) -> some View {
        modifier(CircleCloseButton(action: action))
    }
}
