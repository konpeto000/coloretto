//
//  Deck.swift
//  coloretto
//
//  Created by Kinpira on 2014/11/18.
//  Copyright (c) 2014年 Kinpira. All rights reserved.
//

class Deck{
    
    var deckCard = Array(count: 9, repeatedValue: 0)
    
    init(){
        for(var i:Int = 0;i < 7;i++){
            deckCard[i] = 9
        }
        deckCard[7] = 3
        deckCard[8] = 10
    }
    
    func leftCardfifteen()->Bool{
        var count = 0
        for(var i:Int = 0;i < 9;i++){
            count += deckCard[i]
        }
        if(count == 15){
            return true
        }
        return false
    }
    
    func takeCard()->CardList{
        var breakFlag = false
        var color = CardList.random()
        while(true){
            color = CardList.random()
            switch color{
            case .Red:
                    if(deckCard[0] != 0){
                        deckCard[0]--
                        breakFlag = true
                }
            case .Blue:
                    if(deckCard[1] != 0){
                        deckCard[1]--
                        breakFlag = true
                }
            case .Gray:
                    if(deckCard[2] != 0){
                        deckCard[2]--
                        breakFlag = true
                }
            case .Green:
                    if(deckCard[3] != 0){
                        deckCard[3]--
                        breakFlag = true
                }
            case .Yellow:
                    if(deckCard[4] != 0){
                        deckCard[4]--
                        breakFlag = true
                }
            case .Pink:
                    if(deckCard[5] != 0){
                        deckCard[5]--
                        breakFlag = true
                }
            case .Brown:
                    if(deckCard[6] != 0){
                        deckCard[6]--
                        breakFlag = true
                }
            case .Joker:
                    if(deckCard[7] != 0){
                        deckCard[7]--
                        breakFlag = true
                }
            case .Plus:
                    if(deckCard[8] != 0){
                        deckCard[8]--
                        breakFlag = true
                }
            }
            if(breakFlag){
                break
            }
        }
        return color
    }
}