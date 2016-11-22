//
//  GameScene2.swift
//  Extirswipe
//
//  Created by Joseph Primmer on 12/1/15.
//  Copyright © 2015 TNTPrimer. All rights reserved.
//

import SpriteKit

class GameScene2: SuperGameScene {

    var timeVar = 0.0
    var goal = 20
    let quitButton = SKSpriteNode(imageNamed: "button")
    let quitLabel = SKLabelNode(fontNamed: "Copperplate-Bold")
    var quitCheck = false
    var quit = false
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        super.didMoveToView(view)
        
        pickType()
        setType(UInt32(currentType), node: typeDisp)
        
        quitButton.xScale = 0.20
        quitButton.yScale = 0.20
        quitButton.position = CGPoint(x:CGRectGetMidX(self.frame)-144,
            y:CGRectGetMaxY(self.frame)-44);
        quitButton.zPosition = 2.0
        self.addChild(quitButton)
        quitLabel.fontColor = UIColor.redColor()
        quitLabel.text = "Quit"
        quitLabel.fontSize = 35;
        quitLabel.position = CGPoint(x:CGRectGetMidX(self.frame)-144,
            y:CGRectGetMaxY(self.frame)-54);
        quitLabel.zPosition = 3.0
        self.addChild(quitLabel)
        
        scoreLabel.fontColor = UIColor.blackColor()
        scoreLabel.text = String(score)+"/"+String(goal)
        scoreLabel.fontSize = 30;
        scoreLabel.position = CGPoint(x:CGRectGetMidX(self.frame)+140, y:CGRectGetMaxY(self.frame)-130);
        scoreLabel.zPosition = 2.0
        self.addChild(scoreLabel)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("updateTimer"), userInfo: nil, repeats: true)
        
        timeLabel.fontColor = UIColor.blackColor()
        timeLabel.text = String(timeVar)
        timeLabel.fontSize = 30;
        timeLabel.position = CGPoint(x:CGRectGetMidX(self.frame)+140, y:CGRectGetMaxY(self.frame)-55);
        timeLabel.zPosition = 2.0
        self.addChild(timeLabel)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if(gameOver == true)
        {
            for touch in touches
            {
                let loc = touch.locationInNode(self)
                let check = self.nodeAtPoint(loc)
                if(check == bak2menu || check == bak2menuText)
                {
                    bak2Pressed = true
                    bak2menuText.fontColor = UIColor.redColor()
                    bak2menuText.fontSize = 30;
                    bak2menu.xScale = 0.33
                    bak2menu.yScale = 0.29
                    bak2menu.texture = SKTexture(imageNamed: "buttonSel")
                    
                }
            }
        }
        else
        {
            for touch in touches {
                let loc = touch.locationInNode(self)
                touchesBeganLoc = loc
                extir.position = loc
                if(extir.intersectsNode(quitButton) || extir.intersectsNode(quitLabel))
                {
                    quitCheck = true
                    quitButton.xScale = 0.25
                    quitButton.yScale = 0.25
                    quitLabel.fontSize = 40
                    quitButton.texture = SKTexture(imageNamed: "buttonSel")
                }
                else
                {
                    for var index = 0; index<8; ++index
                    {
                        if(extir.intersectsNode(sprites[index]!) && sprites[index]!.parent == self)
                        {
                            checks[index] = true
                            sprites[index]!.xScale = bigSize
                            sprites[index]!.yScale = bigSize
                            numSprites[index].fontSize = 45
                            
                        }
                    }

                }
            }
            
        }
        
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesMoved(touches, withEvent: event)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        if (gameOver == true)
        {
            for touch in touches
            {
                let loc = touch.locationInNode(self)
                let check = self.nodeAtPoint(loc)
                if((check == bak2menu || check == bak2menuText) && (bak2Pressed == true))
                {
                    bak2Pressed = false
                    bak2menu.removeFromParent()
                    bak2menuText.removeFromParent()
                    let transition = SKTransition.revealWithDirection(.Down, duration: 0.0)
                    let nextScene = MenuScene(size: scene!.size)
                    nextScene.scaleMode = .AspectFill
                    scene?.view?.presentScene(nextScene, transition: transition)
                }
                else
                {
                    bak2Pressed = false
                    bak2menuText.fontColor = UIColor.blackColor()
                    bak2menuText.fontSize = 45;
                    bak2menu.xScale = 0.38
                    bak2menu.yScale = 0.35
                    bak2menu.texture = SKTexture(imageNamed: "button")
                }
            }
            
        }
        else
        {
            line.removeFromParent()
            for touch in touches
            {
                let loc = touch.locationInNode(self)
                extir.position = loc
                let check = self.nodeAtPoint(loc)
                if(((check == quitButton)||(check == quitLabel)) && (quitCheck == true))
                {
                    quit = true
                    quitCheck = false
                }
                else
                {
                    quitCheck = false
                    quitButton.xScale = 0.20
                    quitButton.yScale = 0.20
                    quitLabel.fontSize = 35
                    quitButton.texture = SKTexture(imageNamed: "button")
                for var index = 0; index<8; ++index
                {
                    if(extir.intersectsNode(sprites[index]!))
                    {
                        if(checks.indexOf(true) != index && checks.indexOf(true) != nil)
                        {
                            var boolFlag = false
                            switch(currentType)
                            {
                            case(0): boolFlag = shapes[checks.indexOf(true)!].getType() == shapes[index].getType()
                            case(1): boolFlag = shapes[checks.indexOf(true)!].getNumb() == shapes[index].getNumb()
                            case(2): boolFlag = shapes[checks.indexOf(true)!].getColo() == shapes[index].getColo()
                            default: debugPrint(("ABORT MISSION MAYDAY MAYDAY"))
                            }
                            
                            if(boolFlag)
                            {
                                sprites[checks.indexOf(true)!]?.removeFromParent()
                                sprites[index]?.removeFromParent()
                                numSprites[checks.indexOf(true)!].removeFromParent()
                                numSprites[index].removeFromParent()
                                checks[index] = false
                                newPuzzle++
                            }
                            else
                            {
                                sprites[index]?.xScale = smallSize
                                sprites[index]?.yScale = smallSize
                                if(money > 0)
                                {
                                    money--
                                }
                                moneyLabel.text = "$"+String(money)
                                numSprites[index].fontSize = 40
                                checks[index] = false
                            }
                            
                        }
                        else
                        {
                            sprites[index]?.xScale = smallSize
                            sprites[index]?.yScale = smallSize
                            numSprites[index].fontSize = 40
                            checks[index] = false
                        }
                    }
                }
                for var index = 0; index<8; ++index
                {
                    if(!extir.intersectsNode(sprites[index]!) || checks[index] == true)
                    {
                        sprites[index]?.xScale = smallSize
                        sprites[index]?.yScale = smallSize
                        numSprites[index].fontSize = 40
                        checks[index] = false
                    }
                }
            }
            if(newPuzzle == 4)
            {
                newPuzzle = 0
                score++
                pickType()
                setType(UInt32(currentType), node: typeDisp)
                randomizeShapes()
                addShapes()
                money += 3
                moneyLabel.text = "$"+String(money)
                scoreLabel.text = String(score)+"/"+String(goal)
                if(score == goal)
                {
                    gameEnded()
                }
            }
            
        }
        }
        
    }
    
    override func randomizeShapes()
    {
        super.randomizeShapes()
    }
    
    override func addShapes()
    {
        super.addShapes()
    }
    
    override func pickType()
    {
        currentType = Int(arc4random_uniform(UInt32(3)))
    }
    
    override func setType(type: UInt32, node: SKSpriteNode)
    {
        super.setType(type, node: node)
    }
    
    override func updateTimer()
    {
        timeVar += 0.1
        timeLabel.text = String(round((timeVar*10))/10)
    }
    override func gameEnded()
    {
        gameOver = true
        for sprite in sprites
        {
            if (sprite != nil)
            {
                sprite!.removeFromParent()
            }
        }
        for num in numSprites
        {
            num.removeFromParent()
        }
        typeDisp.removeFromParent()
        timeLabel.removeFromParent()
        
        quitButton.removeFromParent()
        
        bak2menu.xScale = 0.38
        bak2menu.yScale = 0.35
        
        bak2menuText.fontColor = UIColor.blackColor()
        bak2menuText.text = "Menu"
        bak2menuText.fontSize = 45;
        bak2menuText.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)-70);
        bak2menuText.zPosition = 2.0
        
        bak2menu.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)-60)
        bak2menu.removeFromParent()
        bak2menuText.removeFromParent()
        self.addChild(bak2menu)
        self.addChild(bak2menuText)
        
        scoreLabel.fontSize = 25
        scoreLabel.fontColor = UIColor.redColor()
        scoreLabel.text = "Finish Time: "+String(round((timeVar*10))/10)
        
        let timeBonus = Int(80 - round((round((timeVar*10))/10)))*2
        if(timeBonus > 0)
        {
            money += timeBonus
            moneyLabel.text = "Money: $"+String(money)
            quitLabel.text = "TimeBonus: $"+String(timeBonus)
        }
        else
        {
            moneyLabel.text = "Money: $"+String(money)
            quitLabel.text = "TimeBonus: $0"
        }
        debugPrint(timeBonus)
        
        moneyLabel.fontColor = UIColor.redColor()
        moneyLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)+35)
        moneyLabel.fontSize = 40
        
        quitLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)+70)
        quitLabel.fontSize = 40
        
        defaults.setInteger(defaults.integerForKey("money")+money, forKey: "money")
        
        if((round((timeVar*10))/10 < defaults.doubleForKey("lowTime") || (defaults.doubleForKey("lowTime") == 0.0)))
        {
            defaults.setDouble(round((timeVar*10))/10, forKey: "lowTime")
        }
        scoreLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        scoreLabel.fontSize = 40
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if(quit == true)
        {
            let transition = SKTransition.revealWithDirection(.Down, duration: 0.0)
            let nextScene = MenuScene(size: scene!.size)
            nextScene.scaleMode = .AspectFill
            scene?.view?.presentScene(nextScene, transition: transition)
        }
        
    }
}

