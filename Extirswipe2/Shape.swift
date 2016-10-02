//
//  Shape.swift
//  Extirswipe
//
//  Created by Joseph Primmer on 11/18/15.
//  Copyright © 2015 TNTPrimer. All rights reserved.
//

import Foundation

class Shape{
    var type = 0
    var numb = 0
    var colo = 0
    var loca = 0
    
    init(t:Int, n:Int, c:Int, l:Int)
    {
        //debugPrint((n))
        //debugPrint((c))
        type = t
        numb = n
        colo = c
        loca = l
    }
    
    func getType() -> Int{
        return type
    }
    func getNumb() -> Int{
        return numb
    }
    func getColo() -> Int{
        return colo
    }
    func getLoca() -> Int{
        return loca
    }
    func setType(t:Int){
        self.type = t
    }
    func setNumb(n:Int){
        self.numb = n
    }
    func setColo(c:Int){
        self.colo = c
    }
    func setLoca(l:Int){
        self.loca = l
    }
}
