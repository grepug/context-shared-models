//
//  ArrayUtils.swift
//  
//
//  Created by Kai Shao on 2024/7/6.
//

import Foundation

extension Array {
    func element(at index: Int) -> Element? {
        guard index >= 0 && index < self.count else {
            return nil
        }
        return self[index]
    }
    
    func element(at index: Int, defaultsTo: Element) -> Element {
        guard index >= 0 && index < self.count else {
            return defaultsTo
        }
        return self[index]
    }
}
