//
//  ViewController.swift
//  Concentration
//
//  Created by Lixin on 2018/12/2.
//  Copyright © 2018年 Lixin. All rights reserved.
////按住commad可以rename

import UIKit
class ViewController: UIViewController {
    
    //FIXME: 启动游戏
    private lazy var game = Concentration(numberOfPairsOfCards : numberOfPairsOfCards )
    
    //FIXME: 启动游戏
    var numberOfPairsOfCards:Int{ //🍎卡牌对数
        return (cardButtons.count+1) / 2
    }
    
    @IBOutlet private weak  var flipCountLabel: UILabel! //🍎展示翻牌次数
    @IBOutlet private var cardButtons: [UIButton]!//🍎卡牌按钮们
    @IBOutlet weak var scoreLabel: UILabel! //🍎展示所得分数
    @IBOutlet weak var titleLabel: UILabel!//🍎展示当前游戏主题
    @IBOutlet weak var resetButton: UIButton! //🍎重置按钮
    
    //🍎🍎🍎新游戏
    @IBAction func newGame() {
        game.resetGame()
        indexTheme = keys.count.arc4random
        upadateViewFromModel()
    }
    
    //🍎🍎🍎初始化游戏模式
    override func viewDidLoad() {
        super.viewDidLoad()
        indexTheme =  keys.count.arc4random
        upadateViewFromModel()
    }
    
    // 🎾🎾 Controller层: 触发游戏   ?????????
    //🍎🍎🍎点击卡牌事件
    @IBAction  private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            // 🎾🎾 Model层: 游戏核心逻辑与数据运算
            game.chooseCard(at: cardNumber) //游戏开始，点中一张卡牌
            // 🎾🎾 View层: 把数据渲染到视图上
            upadateViewFromModel()
        }else{
            print("chosen card was not in cardButtons")
        }
        
    }
    
    //🍎🍎🍎更新视图
    private func upadateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{//卡牌被翻开
                button.setTitle(emoji(for:card),for: UIControlState.normal)
                print("-----------------------")
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }else{
                //消除卡牌(把卡牌设置成透明)
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0) : #colorLiteral(red: 1, green: 0.44582057, blue: 0.4437403977, alpha: 1)//卡牌背景色
                
            }
            scoreLabel.text = "Score: \(game.score)"
            flipCountLabel.text = "Flips: \(game.flipCount)"
        }
    }
    
    //🍎🍎🍎设置游戏主题
    typealias Theme = (emojiChoices: [String], backgroundColor: UIColor, cardBackColor: UIColor)
    
    //🍎🍎🍎设置表情主题
    private var emojiThemes: [String: Theme] = [
        "Times":   (["🕐","🕑","🕢","🕤","🕧","🕖","🕝","🕛","🕒","🕚","⏰"], #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)),
        "Animals": (["🙈","🐶","🐭","🦁","🐷","🐰","🐙","🐸","🐧","🐨","🐣"], #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)),
        "Fruits":  (["🍏","🍑","🍎","🍐","🍊","🍋","🍌","🍉","🍇","🍒","🍍"], #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)),
        "Balls":   (["⚽️","🏀","🏈","⚾️","🎾","🏐","🏉","🎱","🏓","🏸","🏏"], #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), #colorLiteral(red: 0, green: 0.8970268369, blue: 0.6035302281, alpha: 1))
    ]
    
    //🍎🍎🍎背景主题有0，1，2，3，默认是0
    private var indexTheme = 0 {
        didSet {
            print (indexTheme, keys[indexTheme])
            emoji = [Int: String]()
            titleLabel.text = keys[indexTheme]
            (emojiChoices,backgroundColor,cardBackColor) =
                emojiThemes[keys [indexTheme]] ?? ([],.black,.purple)
            
            updateAppearance()
        }
    }
    //🍎🍎🍎游戏主题名称
    private var keys: [String] {
        return Array(emojiThemes.keys)
    }
    private var emojiChoices = [String] ()
    private var backgroundColor = UIColor.black//屏幕背景颜色
    private var cardBackColor = UIColor.orange//卡牌背景颜色
    
    //🍎🍎🍎更新游戏外观
    private func updateAppearance() {
        view.backgroundColor = backgroundColor
        flipCountLabel.textColor = cardBackColor
        scoreLabel.textColor = cardBackColor
        titleLabel.textColor = cardBackColor
        resetButton.setTitleColor(backgroundColor, for: .normal)
        resetButton.backgroundColor = cardBackColor
    }
    
    private var emoji = [Int:String]() //表情字典
    private func emoji(for card:Card)->String{//设置卡片表情
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
            
            
            print("🍄🍄🍄🍄🍄🍄🍄🍄🍄🍄🍄🍄🍄🍄🍄🍄"+"\(card.identifier)")
            print("🍄🍄 \(String(describing: emoji[card.identifier]))")
            
        }
        
        
        
        print("🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥"+"\(emojiChoices)")
        
        print("🐠🐠🐠🐠🐠🐠🐠🐠🐠🐠🐠🐠🐠🐠🐠🐠"+"\(card.identifier)")
        print("🐠🐠 \(String(describing: emoji[card.identifier]))")
        return emoji[card.identifier] ?? "?" //怎么有些卡牌没有表情呢，哪里出了问题？
    }
}

