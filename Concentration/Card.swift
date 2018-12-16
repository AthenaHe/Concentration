//
//  Card.swift
//  Concentration
//
//  Created by Lixin on 2018/12/2.
//  Copyright © 2018年 Lixin. All rights reserved.
//

import Foundation

struct Card { //卡片属性

    var isFaceUp = false //是否正面朝上：刚开始反面朝上
    var isMatched = false //是否匹配：刚开始未有匹配
    var identifier: Int  //卡片标识符，唯一
    
   private static var identifierFactory = 0  //卡片标识符
    
   private static func getUniqueIdentifier() -> Int { //唯一标识符
        identifierFactory += 1
        return identifierFactory  //唯一的设置就是每次加1，这样就不会有一样的id啦
    }
    init() {
        self.identifier = Card.getUniqueIdentifier() //设置卡片标志符
        
        
        print("============"+"\(self.identifier)")

    }
}
