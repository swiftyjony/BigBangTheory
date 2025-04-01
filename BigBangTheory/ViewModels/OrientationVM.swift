//
//  OrientationVM.swift
//  BigBangTheory
//
//  Created by Jon Gonzalez on 1/4/25.
//

import SwiftUI

@Observable @MainActor
final class OrientationVM {
    private(set) var isLandscape: Bool

    init() {
        isLandscape = UIDevice.current.orientation.isLandscape

        NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification,
                                               object: nil,
                                               queue: .main) { _ in
            Task { @MainActor in
                self.refresh()
            }
        }
    }

    private func refresh() {
        let orientation = UIDevice.current.orientation.isLandscape
        if orientation != isLandscape {
            isLandscape = orientation
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }

}
