//
//  Extensions.swift
//  Concentration
//
//  Created by Braver Chiang on 12/16/18.
//  Copyright © 2018 Lixin. All rights reserved.
//

import Foundation


//🍎🍎🍎扩展数组功能:重新洗牌
extension Array {
    mutating func shuffle() {
        if count < 2 { return }
        for i in indices.dropLast() {
            let diff = distance(from: i, to: endIndex)
            let j = index(i, offsetBy: diff.arc4random)
            swapAt(i, j)
        }
    }
}

//🍎🍎🍎扩展Int功能：随机整数
extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self))) }
        else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

