//
//  GameOrder.swift
//  Concentration
//
//  Created by Braver Chiang on 12/16/18.
//  Copyright © 2018 Lixin. All rights reserved.
//

import Foundation

// MARK:  🍋  🍎🍎🍎分数奖惩制度
class GameOrder: ConcentrationDelegate {
    
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
        GameOrder.score = 99 //
        game.seenCards = []
        for index in game.cards.indices  {
            game.cards[index].isFaceUp = false
            game.cards[index].isMatched = false
        }
        print("🍋2")
        game.cards.shuffle()  //🍎洗牌
        print("🍋3")
    }
    
    

    
}
