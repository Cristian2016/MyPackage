//
//  File 2.swift
//  
//
//  Created by Cristian Lapusan on 30.01.2023.
//

import Foundation

extension CGSize:Hashable {
    static func == (lhs:CGSize, rhs:CGSize) -> Bool {
        lhs.width == rhs.width && lhs.height == rhs.height
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self)
    }
}
