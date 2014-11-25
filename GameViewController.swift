//
//  GameViewController.swift
//  coloretto
//
//  Created by Kinpira on 2014/11/17.
//  Copyright (c) 2014年 Kinpira. All rights reserved.
//


import UIKit
import SpriteKit

class GameViewController: UIViewController ,ColorettoDelegate{
    
    var scene:GameScene!
    var coloretto:Coloretto!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skView = self.view as SKView
        scene = GameScene(size:self.view.bounds.size)
        scene.scaleMode = .AspectFill
        
        coloretto = Coloretto()
        coloretto.delegate = self
        
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        
        var swipeDown = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(swipeDown)
        
        var swipeUp = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(swipeUp)
        
        skView.presentScene(scene)
        
    }
    
    @IBAction func didTap(sender: UITapGestureRecognizer) {
        if(RetryFlag){
            let skView = self.view as SKView
            scene = GameScene(size:self.view.bounds.size)
            scene.scaleMode = .AspectFill
            
            DeckActionFlag = false
            MoveTableActionFlag = false
            TakeTableActionFlag = false
            TakeTable_1Flag = false
            TakeTable_2Flag = false
            TakeTable_3Flag = false
            MyTurn = true
            YourTurn = true
            NextRoundFlag = false
            LastFlag = false
            RetryFlag = false
            Turn = 1
            
            coloretto = Coloretto()
            coloretto.delegate = self
            
            skView.presentScene(scene)
        }
        coloretto.takeCardfromDeck()
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if(!DeckActionFlag){
            if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
                switch swipeGesture.direction {
                case UISwipeGestureRecognizerDirection.Right:
                    coloretto.takeCardfromTable(2)
                case UISwipeGestureRecognizerDirection.Down:
                    coloretto.takeCardfromTable(1)
                case UISwipeGestureRecognizerDirection.Up:
                    coloretto.takeCardfromTable(3)
                default:
                    break
                }
            }
        }else if(!MoveTableActionFlag){
            if let swipeGesture = gesture as? UISwipeGestureRecognizer {
                
                switch swipeGesture.direction {
                case UISwipeGestureRecognizerDirection.Right:
                    coloretto.moveCardtoTable(2)
                case UISwipeGestureRecognizerDirection.Down:
                    coloretto.moveCardtoTable(1)
                case UISwipeGestureRecognizerDirection.Up:
                    coloretto.moveCardtoTable(3)
                default:
                    break
                }
            }
        }
    }
    
    func gameEnd(my:Int,your:Int) {
        scene.winAndLosetext(my, your: your)
    }
    func gameMessage(str:String){
        scene.textMessage(str)
    }
    
    func gameTakeCard(card:CardList){
        scene.showDeckTakeCard(card)
    }
    
    func gameShowField(cardList:Array<CardList>,num:Int,field:[Int]){
        scene.showField(cardList,num:num){
                self.scene.turnChange()
            if(!(MyTurn||YourTurn)){
                if(LastFlag){
                    self.coloretto.end()
                }
                self.scene.nextRound()
                self.coloretto.nextRound()
            }
        }
        scene.changeString(num,color:UIColor.redColor())
        scene.numString(field)
    }

    func gameShowTable(cardList:Array<CardList>,num:Int){
        scene.showTable(cardList,num: num)
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}