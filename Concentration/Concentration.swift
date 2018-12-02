//
//  Concentration.swift
//  Concentration
//
//  Created by Lixin on 2018/12/2.
//  Copyright © 2018年 Lixin. All rights reserved.
//

import Foundation

class Concentration//翻牌游戏//🐨
    
{
    var cards = [Card]() //定义一个cards数组，类型是Card
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index:Int){ //选择卡牌动作
        
        // 🎾 如果点击的卡片，它还没有匹配成功过。
        if !cards[index].isMatched{ //如果卡片没有匹配成功
            
            // 🎾 下面是：已经有 1 张卡片朝上的情况。之前朝，上的那张是 index00 AOF，新翻开的一张是 index
            if let matchIndex = indexOfOneAndOnlyFaceUpCard,matchIndex != index{ //如果indexOfOneAndOnlyFaceUpCard！=index
                //检查卡片是否朝上
                // 🎾 原来那张 & 新翻那张 匹配了。
                if cards[matchIndex].identifier == cards[index].identifier { //如果在现在翻开的卡片和已经翻开的卡片的头像一样，说明匹配成功
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true //翻开卡片
                indexOfOneAndOnlyFaceUpCard = nil
                
            // 🎾 下面是：还没有 0 卡片朝上，或者已经有 2 张卡片朝上。
            } else {
                //0张卡片或者2张卡片朝上
                for filpDownIndex in cards.indices{
                    cards[filpDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index //
            }
        }
    }
    
    init(numberOfPairsOfCards:Int) { //卡牌初始化，创建卡牌//numberOfPairsOfCards卡片对数的数量
        for _ in 1...numberOfPairsOfCards{
            let card = Card()   //创建两张标识符一样的卡片
            cards += [card,card] //把两张卡牌加到卡牌数组里面
            
        }
        //未完待续。。。。(翻牌随机太简单，需要设置复杂一些)
    }
}
