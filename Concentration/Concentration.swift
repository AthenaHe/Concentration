//
//  Concentration.swift
//  Concentration
//
//  Created by Lixin on 2018/12/2.
//  Copyright © 2018年 Lixin. All rights reserved.
//

import Foundation

class Concentration//翻牌游戏
{
    var cards = [Card]() //定义一个cards数组，类型是Card
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index:Int){
        if !cards[index].isMatched{ //如果卡片么有匹配成功
            if let matchIndex = indexOfOneAndOnlyFaceUpCard,matchIndex != index{
                //检查卡片是否朝上
                if cards[matchIndex].identifier == cards[index].identifier { //如果在现在翻开的卡片和已经翻开的卡片的头像一样，说明匹配成功
                    cards[matchIndex].isMatched = true //现在翻开的卡片匹配成功
                    cards[index].isMatched = true //已经翻开的卡片匹配成功
                }
                cards[index].isFaceUp = true //翻开卡片
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                //0张卡片或者2张卡片朝上
                for filpDownIndex in cards.indices{
                    cards[filpDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards:Int) { //numberOfPairsOfCards卡片对数的数量
        for _ in 1...numberOfPairsOfCards{
            let card = Card()   //创建两张标识符一样的卡片
            cards += [card,card]
            
        }
        //未完待续。。。。(翻牌随机太简单，需要设置复杂一些)
    }
}
