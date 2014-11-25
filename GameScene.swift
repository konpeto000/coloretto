//
//  GameScene.swift
//  coloretto
//
//  Created by Kinpira on 2014/11/17.
//  Copyright (c) 2014年 Kinpira. All rights reserved.
//

import SpriteKit

let CardWidth:CGFloat = 40
let CardHeight:CGFloat = 60

class GameScene: SKScene {

    var textLayer = SKNode()
    var myFieldLayer = SKNode()
    var yourFieldLayer = SKNode()
    var tableLayer_1 = SKNode()
    var tableLayer_2 = SKNode()
    var tableLayer_3 = SKNode()
    var cardNumMyText = SKNode()
    var cardNumYourText = SKNode()
    var deckLayer = SKNode()
    
    override init(size:CGSize){
        super.init(size: size)
        
        backgroundColor = UIColor.grayColor()
        anchorPoint = CGPointMake(0, 1.0)

        
        let board = SKSpriteNode(imageNamed: "whitebg")
        board.position = CGPointMake(86-CardWidth/2, -157+CardHeight/3)
        board.anchorPoint = CGPointMake(0.0, 1.0)
        addChild(board)
    
        let card = SKSpriteNode(imageNamed: "card.jpg")
        card.position = CGPointMake(86, -157)
        card.anchorPoint = CGPointMake(0, 1.0)
        addChild(card)
        
        for(var i:Int = 0;i < 3;i++){
            for(var j:Int = i;j < 3;j++){
                let cardNum = SKSpriteNode(imageNamed:"card.jpg")
                cardNum.position = CGPointMake(300+(CardWidth+30)*CGFloat(i), -232+(CardHeight+15)*CGFloat(j))
                cardNum.anchorPoint = CGPointMake(0, 1.0)
                addChild(cardNum)
            }
            let num = SKLabelNode()
            num.fontColor = UIColor.whiteColor()
            num.position = CGPointMake(510-(CardHeight+15)*CGFloat(2-i), -275+(CardHeight+15)*CGFloat(i))
            num.text = "\(i+1)"
            num.name = "\(i+1)"
            addChild(num)
        }

        
        textLayer.position = CGPointMake(100, -115)
        deckLayer.position = CGPointMake(86, -157)
        myFieldLayer.position = CGPointMake(80, -300)
        yourFieldLayer.position = CGPointMake(80, -15)
        
        addChild(textLayer)
        addChild(deckLayer)
        addChild(myFieldLayer)
        addChild(yourFieldLayer)
        addChild(cardNumMyText)
        addChild(cardNumYourText)
        
        tableLayer_1.position = CGPointMake(230, -230)
        tableLayer_2.position = CGPointMake(230, -155)
        tableLayer_3.position = CGPointMake(230, -80)
        
        addChild(tableLayer_1);addChild(tableLayer_2);addChild(tableLayer_3)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textMessage(mes:String){
        let strLabel = SKLabelNode(fontNamed: "Chalkduster")
        strLabel.fontColor = UIColor.redColor()
        strLabel.text = mes
        textLayer.addChild(strLabel)
        
        let action = SKAction.fadeOutWithDuration(1.5)
        let remove = SKAction.removeFromParent()
        let seq = SKAction.sequence([action,remove])
        strLabel.runAction(seq)
    }
    
    func winAndLosetext(my:Int,your:Int){
        let score = SKLabelNode(fontNamed: "Chalkduster")
        score.fontColor = UIColor.redColor()
        score.text = "\(my) : \(your)"
        score.position = CGPointMake(530, -230)
        
        let win = SKLabelNode(fontNamed: "Chalkduster")
        win.fontColor = UIColor.redColor()
        if(my > your){
            win.text = "Player 1 Win !"
        }else{
            win.text = "Player 2 Win !"
        }
        if(my == your){
            win.text = "Draw"
        }
        win.position = CGPointMake(510, -280)
        addChild(score)
        addChild(win)
        RetryFlag = true
    }
    
    func showDeckTakeCard(card:CardList){
        let name = CardList.colorName(card)
        let sprite = SKSpriteNode(imageNamed: name)
        sprite.anchorPoint = CGPointMake(0, 1.0)
        deckLayer.addChild(sprite)
        spriteMoveAction(node: sprite, position: sprite.position + CGPointMake(3*CardWidth, 0),flag:false){
        }
    }
    
    func showField(cardList:Array<CardList>,num:Int,completion:()->()){
        var pos:CGPoint!
        var layer:SKNode!
        var i = 0
        
        for card in cardList{
            
            switch num{
            case 1:
                layer = tableLayer_1
                pos = tableLayer_1.position
                TakeTable_1Flag = true
            case 2:
                layer = tableLayer_2
                pos = tableLayer_2.position
                TakeTable_2Flag = true
            case 3:
                layer = tableLayer_3
                pos = tableLayer_3.position
                TakeTable_3Flag = true
            default:
                break
            }
            var node = layer.children
            let name = CardList.colorName(card)
            let sprite = SKSpriteNode(imageNamed: name)
            sprite.anchorPoint = CGPointMake(0, 1.0)
            sprite.position = CGPointMake(CGFloat(card.rawValue)*(CardWidth+5), 0)
            if(Turn == 1){
                pos = CGPointMake(160, -600) + sprite.position - myFieldLayer.position - pos

            }else{
                pos = CGPointMake(160, -30) + sprite.position - yourFieldLayer.position - pos
            }
            
            spriteMoveAction(node: node[i] as SKNode, position: pos, flag: true){
                if(Turn == 1){
                    self.myFieldLayer.addChild(sprite)
   
                }else{
                    self.yourFieldLayer.addChild(sprite)

                }
            }
            i++
        }
        runAction(SKAction.waitForDuration(0.3),completion:completion)
    }
    
    func turnChange(){
    
        if(Turn == 1){
            if(MyTurn){
                Turn = -1
            }
            MyTurn = false
        }else{
            if(YourTurn){
                Turn = 1
            }
            YourTurn = false
        }
    }
    
    func showTable(cardList:Array<CardList>,num:Int){
        let card = cardList.last!
        let name = CardList.colorName(card)
        let sprite = SKSpriteNode(imageNamed: name)
        sprite.anchorPoint = CGPointMake(0, 1.0)
        sprite.position = CGPointMake(CGFloat(cardList.count)*(CardWidth+30),0)
        
        var pos = CGPointMake(-2*CardWidth-5, 157) + sprite.position
        switch num{
        case 1:
            pos = tableLayer_1.position + pos
        case 2:
            pos = tableLayer_2.position + pos
        case 3:
            pos = tableLayer_3.position + pos
        default:
            break
        }
        
        for node in deckLayer.children{
            spriteMoveAction(node:node as SKNode,position: pos,flag:true){
                switch num{
                case 1 :
                    self.tableLayer_1.addChild(sprite)
                case 2 :
                    self.tableLayer_2.addChild(sprite)
                case 3 :
                    self.tableLayer_3.addChild(sprite)
                default:
                    break
                }
                DeckActionFlag = false
                MoveTableActionFlag = false
            }
        }
        
    }
    
    func changeString(num:Int,color:UIColor){
        let node = self.childNodeWithName(String(num)) as SKLabelNode
        node.fontColor = color
    }
    
    func numString(field:[Int]){
        
        if(Turn == 1){
            cardNumMyText.removeAllChildren()
        }else{
            cardNumYourText.removeAllChildren()
        }
        
        var i:CGFloat = 0
        for card in field{
            if(card == 0){
                i = i + 1
                continue
            }
            let str = SKLabelNode(fontNamed: "Chalkduster")
            str.text = "\(card)"
            str.fontSize = 30
            if(Turn == 1){
                str.position = myFieldLayer.position + CGPointMake(i*(CardWidth+5)+20, -70)

                cardNumMyText.addChild(str)
            }else{
                str.position = yourFieldLayer.position + CGPointMake(i*(CardWidth+5)+20, -20)

                cardNumYourText.addChild(str)
            }
            i = i + 1
            
        }
    }
    
    func spriteMoveAction(#node:SKNode,position:CGPoint,flag:Bool,completion:()->()){
        if(flag){
            let action = SKAction.moveTo(position, duration: 0.2)
            let remove = SKAction.removeFromParent()
            let seq = SKAction.sequence([action,remove])
        
            node.runAction(seq)
            
        }else{
            let action = SKAction.moveTo(position, duration: 0.2)
            node.runAction(action)
        }
        runAction(SKAction.waitForDuration(0.2),completion:completion)
    }
    
    func nextRound(){

            tableLayer_1.removeAllChildren()
            tableLayer_2.removeAllChildren()
            tableLayer_3.removeAllChildren()
            for(var i:Int = 1;i <= 3;i++){
                changeString(i, color: UIColor.whiteColor())
            }
            MyTurn = true
            YourTurn = true
            TakeTable_1Flag = false
            TakeTable_2Flag = false
            TakeTable_3Flag = false
            NextRoundFlag = false
        
    }

    override func didMoveToView(view: SKView) {
     
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}

func +(lhs:CGPoint,rhs:CGPoint)->CGPoint{
    return(CGPointMake(lhs.x+rhs.x, lhs.y+rhs.y))
}
func -(lhs:CGPoint,rhs:CGPoint)->CGPoint{
    return(CGPointMake(lhs.x-rhs.x, lhs.y-rhs.y))
}
func *(lhs:CGPoint,rhs:CGPoint)->CGPoint{
    return(CGPointMake(lhs.x*rhs.x, lhs.y*rhs.y))
}