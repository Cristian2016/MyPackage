//
//  File 2.swift
//  
//
//  Created by Cristian Lapusan on 30.01.2023.
//

import Foundation

public extension CGSize:Hashable {
    static func == (lhs:CGSize, rhs:CGSize) -> Bool {
        lhs.width == rhs.width && lhs.height == rhs.height
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self)
    }
}


public extension CGFloat {
    static let minFontSize = CGFloat(18)
    static let largeTitle = CGFloat(40)
}
