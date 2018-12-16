//
//  GameOrder.swift
//  Concentration
//
//  Created by Braver Chiang on 12/16/18.
//  Copyright © 2018 Lixin. All rights reserved.
//

import Foundation

// MARK:  🍋  🍎🍎🍎分数奖惩制度
class GameOrder: ConcentrationDelegate { //第三步
    
    static var flipCount = 0
    static var score = 1000000
    
    
    struct Points {
        static let matchBonus = 100 //匹配➕20分
        static let missMatchPenalty = 10 //不匹配➖10分
    }
    
    
    //
    func startNewGame(_ game: Concentration) {
        GameOrder.flipCount = 0
        print("🍋1")
        GameOrder.score = 88 //
        game.seenCards = []
        for index in game.cards.indices  {
            game.cards[index].isFaceUp = false
            game.cards[index].isMatched = false
        }
        print("🍋2")
        game.cards.shuffle()  //🍎洗牌
        print("🍋3")
    }
    //第四步
    func  gameInit(numberOfPairsOfCards:Int,_ game: Concentration)  {
                assert(numberOfPairsOfCards > 0,
                       "Concentration.init(\(numberOfPairsOfCards)) : You must have at least one pair of cards")//创建卡牌是必须一对一对的，要不然怎么匹配呢
                for _ in 1...numberOfPairsOfCards{
                    let card = Card()
                    game.cards += [card,card]
        
                }
    }
    
    

    
}
