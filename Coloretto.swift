//
//  Coloretto.swift
//  coloretto
//
//  Created by Kinpira on 2014/11/17.
//  Copyright (c) 2014年 Kinpira. All rights reserved.
//

import SpriteKit

var DeckActionFlag = false
var MoveTableActionFlag = false
var TakeTableActionFlag = false
var TakeTable_1Flag = false
var TakeTable_2Flag = false
var TakeTable_3Flag = false
var MyTurn = true
var YourTurn = true
var NextRoundFlag = false
var LastFlag = false
var RetryFlag = false
var Turn = 1


protocol ColorettoDelegate{
    func gameEnd(my:Int,your:Int)
    func gameTakeCard(card:CardList)
    func gameMessage(str:String)
    func gameShowField(cardList:Array<CardList>,num:Int,field:[Int])
    func gameShowTable(cardList:Array<CardList>,num:Int)
}

enum CardList:Int{
    case Red = 0,Green,Blue,Yellow,Pink,Gray,Brown,Joker,Plus
    
    static func colorName(color:CardList)->String{
        switch color{
        case .Red:
            return "red.jpg"
        case .Brown:
            return "brown.jpg"
        case .Blue:
            return "blue.jpg"
        case .Green:
            return "green.jpg"
        case .Gray:
            return "gray.jpg"
        case .Pink:
            return "pink.jpg"
        case .Yellow:
            return "yellow.jpg"
        case .Joker:
            return "joker.jpg"
        case .Plus:
            return "+2.jpg"
        }
    }
    
    static func random()->CardList{
        return CardList(rawValue:Int(arc4random()%9))!
    }

}

class Coloretto {

    var takeCard:CardList!
    
    var myHand:Hand!
    var yourHand:Hand!
    var table:Table!
    var deck:Deck!
    var delegate:ColorettoDelegate?
    
    
    init(){
        myHand = Hand()
        yourHand = Hand()
        table = Table()
        deck = Deck()
    }
    
    func end(){
        let myScore = myHand.checkScore()
        let yourScore = yourHand.checkScore()
        delegate?.gameEnd(myScore,your: yourScore)
    }
    func takeCardfromDeck(){
        if(!DeckActionFlag && !table.isAllFull() && (MyTurn || YourTurn)){
            DeckActionFlag = true
                takeCard = deck.takeCard()
                delegate?.gameTakeCard(takeCard)
            if(deck.leftCardfifteen()){
                LastFlag = true
                delegate?.gameMessage("Last turn")
            }
        }else if(table.isAllFull()){
            delegate?.gameMessage("Full")
        }
    }
    
    func nextRound(){
        for(var i:Int = 1;i <= 3;i++){
            table.removeCard(i)
        }
    }
    
    func moveCardtoTable(num:Int){
        if(!table.isFull(num) && !table.takeTableFlag(num)){
            MoveTableActionFlag = true
            table.setCard(num: num, card: takeCard)
            if(Turn == 1){
                delegate?.gameShowTable(table.takeCard(num),num: num)
            }else{
            delegate?.gameShowTable(table.takeCard(num),num: num)
            }
            if(MyTurn && YourTurn){
                turnChange()
            }
        }else{
            delegate?.gameMessage("Full")
        }
    }
    func takeCardfromTable(num:Int){
        if(!table.isEmpty(num) && !table.takeTableFlag(num) && (MyTurn || YourTurn)){
            TakeTableActionFlag = true
            if(Turn == 1){
                myHand.setField(table.takeCard(num))
                delegate?.gameShowField(table.takeCard(num),num:num,field:myHand.showField())
            }else{
                yourHand.setField(table.takeCard(num))
                delegate?.gameShowField(table.takeCard(num),num:num,field:yourHand.showField())
            }
            table.inNonCard(num)
        }else{
            delegate?.gameMessage("Empty")
        }

    }
    
    func turnChange(){
        Turn = -1*Turn
    }
}