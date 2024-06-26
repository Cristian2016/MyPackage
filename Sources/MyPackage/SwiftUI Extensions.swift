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
    
    public init(material: Material) { self.material = material }
    public init() { }
    
    public var body: some View {
        Color.clear.background(material).ignoresSafeArea()
    }
}

///Background covers the entire screen, it can be a 1.material (ex. .ultraThinMaterial), 2.clear or 3.dark with opacity
@available(iOS 15.0, *)
public struct Background:View {
    let kind:Kind
    
    public init(_ kind:Kind = .material(.ultraThinMaterial)) {
        self.kind = kind
    }
    
    @ViewBuilder
    public var body: some View {
        ZStack {
            switch kind {
                case .clear:
                    Color.clear
                        .contentShape(Rectangle())
                case .dark(opacity: let opacity):
                    Color.black.opacity(opacity)
                case .material(let material):
                    Color.clear.background(material)
            }
        }
        .ignoresSafeArea()
    }
}

@available(iOS 15.0, *)
public extension Background {
    enum Kind {
        case dark(_ opacity:Double = 0.5)
        case material(Material)
        case clear
    }
}
