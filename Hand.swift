//
//  Hand.swift
//  coloretto
//
//  Created by Kinpira on 2014/11/17.
//  Copyright (c) 2014年 Kinpira. All rights reserved.
//

class Hand{
    
    var field:Array<CardList>
    var scoreField:[Int]!
    
    init(){
        field = Array<CardList>()
        scoreField = [0,0,0,0,0,0,0,0,0]
    }
    
    func numOfColor()->[Int]{
        var count = [0,0,0,0,0,0,0,0,0]
        count[0] = numCard(.Red)
        count[1] = numCard(.Green)
        count[2] = numCard(.Blue)
        count[3] = numCard(.Yellow)
        count[4] = numCard(.Pink)
        count[5] = numCard(.Gray)
        count[6] = numCard(.Brown)
        count[7] = numCard(.Joker)
        count[8] = numCard(.Plus)
        
        return count
    }
    
    func numCard(color:CardList)->Int{
        var count = 0
        for list in field{
            if(color == list){
                count++
            }
        }
        return count
    }
    
    func showField()->[Int]{
        return numOfColor()
    }
    
    func setField(card:Array<CardList>){
        field = field + card
    }
    
    func checkScore()->Int{
        
        var score:Int = 0
        
        scoreField = numOfColor()
        sort()
        checkJoker()
        for(var i:Int = 0;i < 7;i++){
            if(i < 3){
                score += scoreField[i]*(scoreField[i]+1)/2
            }else{
                score -= scoreField[i]*(scoreField[i]+1)/2
            }
        }
        
        score += scoreField[8]*2
        return score
    }
    
    private func sort(){
        for(var i:Int = 0;i < 7;i++){
            for(var j:Int = 0;j < 7;j++){
                if(scoreField[i] > scoreField[j]){
                    let temp = scoreField[i]
                    scoreField[i] = scoreField[j]
                    scoreField[j] = temp
                }
            }
        }
    }
    
    private func checkJoker(){
        var joker = scoreField[7]
        for i in 0..<joker{
            for j in 0..<3{
                if(scoreField[j] < 6){
                    scoreField[j]++
                    break;
                }
            }
        }
    }
    
    
}
