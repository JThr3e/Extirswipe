//
//  GameScene.swift
//  Extirswipe
//
//  Created by Joseph Primmer on 11/16/15.
//  Copyright (c) 2015 TNTPrimer. All rights reserved.
//

import SpriteKit

class GameScene: SuperGameScene {
    
    var maxTime = 8
    var timeVar = 8
    var midType = 0
    var genType = 0
    let typeDispMid = SKSpriteNode(imageNamed: "Shapes")
    let typeDispGen = SKSpriteNode(imageNamed: "Shapes")
    var timeShape = SKSpriteNode(imageNamed: "8")
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        super.didMoveToView(view)
        genType = Int(arc4random_uniform(UInt32(3)))
        midType = Int(arc4random_uniform(UInt32(3)))
        currentType = Int(arc4random_uniform(UInt32(3)))

        
        typeDispMid.xScale = 0.38
        typeDispMid.yScale = 0.38
        typeDispMid.position = CGPoint(x:CGRectGetMidX(self.frame)-115,
            y:CGRectGetMaxY(self.frame)-45);
        typeDispMid.zPosition = 2.0
        self.addChild(typeDispMid)
        
        typeDispGen.xScale = 0.38
        typeDispGen.yScale = 0.38
        typeDispGen.position = CGPoint(x:CGRectGetMidX(self.frame)-170,
            y:CGRectGetMaxY(self.frame)-45);
        typeDispGen.zPosition = 2.0
        self.addChild(typeDispGen)
        
        setType(UInt32(genType), node: typeDispGen)
        setType(UInt32(midType), node: typeDispMid)
        setType(UInt32(currentType), node: typeDisp)
        
        timeShape.xScale = 1.0
        timeShape.yScale = 1.5
        timeShape.position = CGPoint(x:CGRectGetMidX(self.frame)+140,
            y:CGRectGetMaxY(self.frame)-45);
        timeShape.zPosition = 2.0
        self.addChild(timeShape)
        
        scoreLabel.fontColor = UIColor.blackColor()
        scoreLabel.text = String(score)
        scoreLabel.fontSize = 25;
        scoreLabel.position = CGPoint(x:CGRectGetMidX(self.frame)+140, y:CGRectGetMaxY(self.frame)-130);
        scoreLabel.zPosition = 2.0
        self.addChild(scoreLabel)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
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
                for var index = 0; index<8; ++index
                {
                    if(extir.intersectsNode(sprites[index]!) && sprites[index]?.parent == self)
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
                                debugPrint("Wrong Ones")
                                gameOver = true
                                gameEnded()
                                sprites[index]?.xScale = smallSize
                                sprites[index]?.yScale = smallSize
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
                if(score % 5 == 0 && maxTime > 5 && score != 0)
                {
                    maxTime--
                }
                gameOver = false
                timeVar = maxTime
                timeShape.texture = SKTexture(imageNamed: (String)(maxTime))
                pickType()
                setType(UInt32(genType), node: typeDispGen)
                setType(UInt32(midType), node: typeDispMid)
                setType(UInt32(currentType), node: typeDisp)
                randomizeShapes()
                addShapes()
                money += 5
                moneyLabel.text = "$"+String(money)
                scoreLabel.text = String(score)
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
        currentType = midType
        midType = genType
        genType = Int(arc4random_uniform(UInt32(3)))
    }
    
    override func setType(type: UInt32, node: SKSpriteNode)
    {
        super.setType(type, node: node)
    }
    
    override func updateTimer()
    {
        timeVar--
        if(timeVar == 0)
        {
            debugPrint("Outa Time")
            gameOver = true
            gameEnded()
        }
        else
        {
            timeShape.texture = SKTexture(imageNamed: (String)(timeVar))
        }
    }
    override func gameEnded()
    {
        timer.invalidate()
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
        timeShape.removeFromParent()
        line.removeFromParent()
        typeDispGen.removeFromParent()
        typeDispMid.removeFromParent()
        
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
        
        moneyLabel.text = "Money: $"+String(money)
        moneyLabel.fontColor = UIColor.redColor()
        moneyLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)+35)
        moneyLabel.fontSize = 40
        scoreLabel.fontSize = 30
        scoreLabel.fontColor = UIColor.redColor()
        scoreLabel.text = "You Lose! Score: "+(String)(score)
        scoreLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        defaults.setInteger(defaults.integerForKey("money")+money, forKey: "money")
        
        if(score > defaults.integerForKey("highScore"))
        {
            defaults.setInteger(score, forKey: "highScore")
        }
        
    }

   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */

        
    }
}
