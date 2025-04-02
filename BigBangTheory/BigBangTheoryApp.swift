//
//  BigBangTheoryApp.swift
//  BigBangTheory
//
//  Created by Jon Gonzalez on 1/4/25.
//

import SwiftUI
import SwiftData

#if os(iOS)
@MainActor let isiPad = UIDevice.current.userInterfaceIdiom == .pad
#elseif os(macOS) || os(tvOS) || os(visionOS)
@MainActor let isiPad = true
#endif

@main
struct BigBangTheoryApp: App {
    @State private var vm = BigBangVM()
    @State private var orientation = OrientationVM()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(vm)
                .environment(orientation)
        }
        .modelContainer(for: BBModel.self)
    }
}
