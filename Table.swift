//
//  Table.swift
//  coloretto
//
//  Created by Kinpira on 2014/11/17.
//  Copyright (c) 2014年 Kinpira. All rights reserved.
//

class Table{
    
    var table_1:Array<CardList>
    var table_2:Array<CardList>
    var table_3:Array<CardList>
    
    init (){
        table_1 = Array<CardList>()
        table_2 = Array<CardList>()
        table_3 = Array<CardList>()
    }
    
    func isEmpty(num:Int)->Bool{
        var empty = false
        switch num{
        case 1:
            empty = table_1.isEmpty
        case 2:
            empty = table_2.isEmpty
        case 3:
            empty = table_3.isEmpty
        default:
            break
        }
        return empty
    }
    
    func takeTableFlag(num:Int)->Bool{
        switch num{
        case 1:
            return TakeTable_1Flag
        case 2:
            return TakeTable_2Flag
        case 3:
            return TakeTable_3Flag
        default:
            break
        }
        return false
    }
    
    func isAllFull()->Bool{
        if(isFull(1)&&isFull(2)&&isFull(3)){
            return true
        }
        return false
    }
    
    func isFull(num:Int)->Bool{
        var full = false
        switch num{
        case 1:
            full = table_1.count >= 1
        case 2:
            full = table_2.count >= 2
        case 3:
            full = table_3.count >= 3
        default:
            break
        }
        return full
        
    }
    func setCard(#num:Int,card:CardList){
        switch num{
        case 1:
            table_1.append(card)
        case 2:
            table_2.append(card)
        case 3:
            table_3.append(card)
        default:
            break
        }
    }
    
    func takeCard(num:Int)->Array<CardList>{
        
        var take:Array<CardList>!
        
        switch num{
        case 1:
            take = table_1
        case 2:
            take = table_2
        case 3:
            take = table_3
        default:
            break
        }
        
        return take
    }
    
    func removeCard(num:Int){
        switch num{
        case 1:
            table_1.removeAll()
        case 2:
            table_2.removeAll()
        case 3:
            table_3.removeAll()
        default:
            break
        }
    }
    
    func inNonCard(num:Int){
        switch num{
        case 1:
            break
        case 2:
            table_2.append(CardList.random())
        case 3:
            table_3.append(CardList.random())
            table_3.append(CardList.random())
        default:
            break
        }
    }
}