//
//  Concentration.swift
//  Concentration
//
//  Created by Lixin on 2018/12/2.
//  Copyright © 2018年 Lixin. All rights reserved.
//

import Foundation
//翻牌游戏
class Concentration{
    private(set) var cards = [Card]()
    private(set) var flipCount = 0
    private(set) var score = 0
    private var seenCards: Set<Int> = []//🍎已经看过的卡牌集合
    //🍎🍎🍎分数奖惩制度
    private struct Points {
        static let matchBonus = 20 //匹配➕20分
        static let missMatchPenalty = 10 //不匹配➖10分
    }
    
     //是否只有一张牌正面朝上
    private var indexOfOneAndOnlyFaceUpCard: Int?{
        get{
            var foundIndex: Int?
            for index in cards.indices{
                if cards[index].isFaceUp{
                    if foundIndex == nil{
                        foundIndex = index
                    }else{
                        return  nil
                    }
                }
            }
            return foundIndex
        }
        set{
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    //🍎🍎🍎点击卡牌动作
    func chooseCard(at index:Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)) : Choosen index out of range")//防止有人选择的index不在正常范围内，捕捉异常
        // 🎾 如果点击的卡片，它还没有匹配成功过。
        if !cards[index].isMatched{
            // 🎾 下面是：已经有 1 张卡片朝上的情况。之前朝，上的那张是 index00 AOF，新翻开的一张是 index
            if let matchIndex = indexOfOneAndOnlyFaceUpCard,matchIndex != index{
                // 🎾 原来那张 & 新翻那张 匹配了。
                if cards[matchIndex].identifier == cards[index].identifier {
                    //🍎卡牌匹配成功，加分
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += Points.matchBonus
                }else{
                    //🍎卡牌匹配失败，如果翻开的卡牌是之前已经看过的，就扣分
                    if seenCards.contains(index) {
                        score -= Points.missMatchPenalty
                    }
                    if seenCards.contains(matchIndex){
                        score -= Points.missMatchPenalty
                    }
                    seenCards.insert(index) //表示这张牌看过了
                    seenCards.insert(matchIndex)
                }
                cards[index].isFaceUp = true
            // 🎾 下面是：0卡片朝上，或者已经有 2 张卡片朝上。
            } else {//卡牌未匹配
                indexOfOneAndOnlyFaceUpCard = index
            }
            flipCount += 1
        }
    }
    
    //🍎🍎🍎游戏重置
    func resetGame(){
        flipCount = 0
        score = 0
        seenCards = []
        for index in cards.indices  {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
        cards.shuffle()//🍎洗牌
    }
    
    //🍎🍎🍎卡牌初始化
    init(numberOfPairsOfCards:Int) {//numberOfPairsOfCards卡片对数的数量
        assert(numberOfPairsOfCards > 0,
               "Concentration.init(\(numberOfPairsOfCards)) : You must have at least one pair of cards")//创建卡牌是必须一对一对的，要不然怎么匹配呢
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card,card]
            
        }
    }
}

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


