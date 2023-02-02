//
//  File 2.swift
//  
//
//  Created by Cristian Lapusan on 27.01.2023.
//

import SwiftUI

@available(iOS 14.0, *)
public extension ScenePhase {
    ///prints out scenePhase changes to the console
    var report:Void {
        switch self {
            case .active: print("scenePhase active")
            case .background: print("scenePhase background")
            case .inactive: print("scenePhase inactive")
            @unknown default : print("scenePhase unknown")
        }
        return
    }
}

@available(iOS 15.0, *)
public struct BlurryBackground:View {
    var material:Material = .ultraThinMaterial
    public var body: some View {
        Color.clear
            .background(material, in: Rectangle())
            .ignoresSafeArea()
    }
}
