//
//  ViewController.swift
//  Concentration
//
//  Created by Lixin on 2018/12/2.
//  Copyright © 2018年 Lixin. All rights reserved.
//

import UIKit

 class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards : cardButtons.count+1 / 2 ) //卡牌对的数量
    var flipCount: Int = 0 {
        didSet{
            flipCountLabel.text = "flips : \(flipCount)"
        }
    }
    @IBOutlet weak  var flipCountLabel: UILabel!
    @IBOutlet  var cardButtons: [UIButton]!  //UIBtton数组 //按住commad可以rename
    @IBAction  func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            upadateViewFromModel()
        }else{
            print("chosen card was not in cardButtons")
        }
        
    }
    
    func upadateViewFromModel(){
        for index in cardButtons.indices{ //根据卡片索引找到对应照片
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                //翻面（正面朝上）
                button.setTitle(emoji(for:card),for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }else{
                //如果有匹配，就把匹配的两张消掉(设置成透明)，否则，这两张翻面(背景设为红色)
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0) : #colorLiteral(red: 1, green: 0.44582057, blue: 0.4437403977, alpha: 1)//color
                
            }
        }
    }
    var emojiChoices = ["🙈","🐶","🐭","🦁","🐷","🐰","🐙","🐸"]
    var emoji = [Int:String]()
    func emoji(for card:Card)->String{
            if emoji[card.identifier] == nil , emojiChoices.count > 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
            }
        return emoji[card.identifier] ?? "?"
    }
}

