//
//  PusherView.swift
//  Timers
//
//  Created by Cristian Lapusan on 02.05.2022.
//

import SwiftUI

@available(iOS 13.0, *)
public struct Push<Content:View>: View {
    let position:Position
    let content:Content
    
    init(_ position: Position, @ViewBuilder _ content: () -> Content) {
        self.content = content()
        self.position = position
    }
    
    public var body: some View { makePusher }
    
    enum Position {
        case topLeft
        case topRight
        case topMiddle
        
        case bottomLeft
        case bottomRight
        case bottomMiddle
        
        case middle
        case leading
        case trailing
    }
    
    @ViewBuilder
    private var makePusher:some View {
        switch position {
            case .topLeft:
                VStack { HStack { content; Spacer() } ;Spacer() }
            case .topRight:
                VStack { HStack { Spacer() ;content } ; Spacer() }
            case .bottomRight:
                VStack { Spacer(); HStack { Spacer() ;content } }
            case .bottomLeft:
                VStack {  Spacer(); HStack { content ; Spacer() } }
            case .topMiddle:
                VStack { content; Spacer() }
            case .bottomMiddle:
                VStack { Spacer(); content }
                
            case .middle:
                HStack {
                    Spacer(); content; Spacer()
                }
            case .leading:
                HStack { content; Spacer() }
            case .trailing:
                HStack { Spacer(); content }
        }
    }
}
