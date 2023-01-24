//
//  File 2.swift
//  
//
//  Created by Cristian Lapusan on 21.01.2023.
//

import SwiftUI

@available(iOS 16.0, *)
public struct SizeReader:ViewModifier {
    @Binding var size:CGSize
    public func body(content: Content) -> some View {
        content
            .background {
                GeometryReader { geo -> Color in
                    DispatchQueue.main.async { size = geo.size }
                    return .clear
                }
            }
    }
}

@available(iOS 16.0, *)
public struct FrameReader:ViewModifier {
    @Binding var frame:CGRect
    public func body(content: Content) -> some View {
        content
            .background {
                GeometryReader { geo -> Color in
                    DispatchQueue.main.async { frame = geo.frame(in: .global) }
                    return .clear
                }
            }
    }
}

@available(iOS 16.0, *)
public extension View {
    ///gets the size of the view the modifier is applied to
    func readSize(_ size:Binding<CGSize>) -> some View {
        self.modifier(SizeReader(size: size))
    }
    
    ///gets the frame of the view the modifier is applied to
    func readFrame(_ frame:Binding<CGRect>) -> some View {
        self.modifier(FrameReader(frame: frame))
    }
}
