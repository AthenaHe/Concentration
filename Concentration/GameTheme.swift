//
//  GameTheme.swift
//  Concentration
//
//  Created by Braver Chiang on 12/16/18.
//  Copyright © 2018 Lixin. All rights reserved.
//

import Foundation
import UIKit

class GameTheme {
    
    var emoji = [Int:String]() //表情字典
    func emoji(for card:Card)->String{//设置卡片表情
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card.identifier] ?? "?" //怎么有些卡牌没有表情呢，哪里出了问题？
    }
    
    
    //🍎🍎🍎设置游戏主题  //🍋定义一个新的类, 这里类似一个元组 ([String], UIColor, UIColor)
    typealias Theme = (emojiChoices: [String], backgroundColor: UIColor, cardBackColor: UIColor)
    
    //🍎🍎🍎设置表情主题
    var emojiThemes: [String: Theme] = [
        "Times":   (["🕐","🕑","🕢","🕤","🕧","🕖","🕝","🕛","🕒","🕚","⏰"], #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)),
        "Animals": (["🙈","🐶","🐭","🦁","🐷","🐰","🐙","🐸","🐧","🐨","🐣"], #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)),
        "Fruits":  (["🍏","🍑","🍎","🍐","🍊","🍋","🍌","🍉","🍇","🍒","🍍"], #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)),
        "Balls":   (["⚽️","🏀","🏈","⚾️","🎾","🏐","🏉","🎱","🏓","🏸","🏏"], #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), #colorLiteral(red: 0, green: 0.8970268369, blue: 0.6035302281, alpha: 1))
    ]
    
    //🍎🍎🍎背景主题有0，1，2，3，默认是0
    var indexTheme = 0 {
        didSet {
            print (indexTheme, keys[indexTheme])
            emoji = [Int: String]()
            title = keys[indexTheme]// FIXME: bbb
            (emojiChoices,backgroundColor,cardBackColor) =
                emojiThemes[keys [indexTheme]] ?? ([],.black,.purple)
            
            //updateAppearance() FIXME: aaa
        }
    }
    
    //🍎🍎🍎游戏主题名称
    var keys: [String] {
        return Array(emojiThemes.keys)
    }
    var emojiChoices = [String] ()
    var backgroundColor = UIColor.black//屏幕背景颜色
    var cardBackColor = UIColor.orange//卡牌背景颜色
    var title = "None"
    
    func resetGameTheme(){
        indexTheme = keys.count.arc4random
    }
    
}
