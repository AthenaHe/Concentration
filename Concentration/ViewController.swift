//
//  ViewController.swift
//  Concentration
//
//  Created by Lixin on 2018/12/2.
//  Copyright © 2018年 Lixin. All rights reserved.
////按住commad可以rename

import UIKit
class ViewController: UIViewController {
    
    
    private lazy var game = Concentration(
        numberOfPairsOfCards: (cardButtons.count + 1) / 2    )
    
    private lazy var gameTheme = GameTheme()
    
    private lazy var gameOrder = GameOrder()
    
    
    
    @IBOutlet private weak  var flipCountLabel: UILabel! //🍎展示翻牌次数
    @IBOutlet private var cardButtons: [UIButton]!//🍎卡牌按钮们
    @IBOutlet weak var scoreLabel: UILabel! //🍎展示所得分数
    @IBOutlet weak var titleLabel: UILabel!//🍎展示当前游戏主题
    @IBOutlet weak var resetButton: UIButton! //🍎重置按钮
    
    
    //🍎🍎🍎新游戏 // MARK: 🍋核心逻辑
    @IBAction func newGame() {
        game.resetGame() //Model 1   //🍋 老板说:  开车/开始写代码
        
        gameTheme.resetGameTheme() //Model 2
        
        updateViewFromGameModel() //View 1
        
        updateViewFromGameTheme() //View 2
    }
    
    //🍎🍎🍎初始化游戏模式
    override func viewDidLoad() {
        super.viewDidLoad()
        game.guanjia = gameOrder //🍋 delegate很多都写在这个位置的第一行
        
        newGame()
    }
    
    
    // 🎾🎾 Controller层: 触发游戏   ?????????
    //🍎🍎🍎点击卡牌事件
    @IBAction  private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            // 🎾🎾 Model层: 游戏核心逻辑与数据运算
            game.chooseCard(at: cardNumber) //游戏开始，点中一张卡牌
            // 🎾🎾 View层: 把数据渲染到视图上
            updateViewFromGameModel()
        }else{
            print("chosen card was not in cardButtons")
        }
    }
    
    //🍎🍎🍎更新视图
    private func updateViewFromGameModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{//卡牌被翻开
                button.setTitle(gameTheme.emoji(for:card),for: UIControlState.normal)
                print("-----------------------")
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }else{
                //消除卡牌(把卡牌设置成透明)
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0) : #colorLiteral(red: 1, green: 0.44582057, blue: 0.4437403977, alpha: 1)//卡牌背景色
                
            }
            scoreLabel.text = "Score: \(GameOrder.score)"
            flipCountLabel.text = "Flips: \(GameOrder.flipCount)"
        }
    }
    
    
    //🍎🍎🍎更新游戏外观
    private func updateViewFromGameTheme() {
        view.backgroundColor = gameTheme.backgroundColor
        flipCountLabel.textColor = gameTheme.cardBackColor
        scoreLabel.textColor = gameTheme.cardBackColor
        titleLabel.textColor = gameTheme.cardBackColor
        resetButton.setTitleColor(gameTheme.backgroundColor, for: .normal)
        resetButton.backgroundColor = gameTheme.cardBackColor
        titleLabel.text = gameTheme.title
    }
    
}

