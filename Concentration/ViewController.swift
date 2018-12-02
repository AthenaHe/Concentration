//
//  ViewController.swift
//  Concentration
//
//  Created by Lixin on 2018/12/2.
//  Copyright © 2018年 Lixin. All rights reserved.
//

import UIKit
//按住commad可以rename
 class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards : cardButtons.count+1 / 2 ) //卡牌对的数量 ，设置成lazy属性是为了让它使用到的时候再初始化
    var flipCount: Int = 0 {
        didSet{
            flipCountLabel.text = "flips : \(flipCount)" //设置翻牌的次数
        }
    }
    @IBOutlet weak  var flipCountLabel: UILabel! //展示翻牌次数
    @IBOutlet  var cardButtons: [UIButton]!  //UIButton数组
    @IBAction  func touchCard(_ sender: UIButton) { //点击卡牌事件
        flipCount += 1 //翻牌次数加一
        if let cardNumber = cardButtons.index(of: sender) { //每个卡牌数字号就是对应cardButtons下标
            game.chooseCard(at: cardNumber) //游戏开始，点中一张卡牌
            upadateViewFromModel() //更新视图
        }else{
            print("chosen card was not in cardButtons")
        }
        
    }
    
    func upadateViewFromModel(){ //更新视图
        for index in cardButtons.indices{ //根据卡牌按钮索引找到对应卡牌
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                //卡牌翻正面
                button.setTitle(emoji(for:card),for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }else{
                //消除卡牌(把卡牌设置成透明)
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0) : #colorLiteral(red: 1, green: 0.44582057, blue: 0.4437403977, alpha: 1)//color
                
            }
        }
    }
    var emojiChoices = ["🙈","🐶","🐭","🦁","🐷","🐰","🐙","🐸"] //各种头像集合
    var emoji = [Int:String]() //表情字典
    func emoji(for card:Card)->String{//设置卡片表情
            if emoji[card.identifier] == nil , emojiChoices.count > 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count))) //将卡牌打乱(随机设置卡牌上的表情)
                emoji[card.identifier] = emojiChoices.remove(at: randomIndex) //将emojiChoices数组中的表情移除放到emoji数组中
            }
        return emoji[card.identifier] ?? "?" //有表情返回表情，表情用完了就返回问号
    }
}

