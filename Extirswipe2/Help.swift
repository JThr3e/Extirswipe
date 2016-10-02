//
//  Help.swift
//  Extirswipe
//
//  Created by Joseph Primmer on 12/31/15.
//  Copyright © 2015 TNTPrimer. All rights reserved.
//

import SpriteKit

class Help: SKScene {
    let defaults = NSUserDefaults.standardUserDefaults()
    var currentBGR = 0
    var bgr = SKSpriteNode(imageNamed: "BGR")
    let menuButton = SKSpriteNode(imageNamed: "button")
    let shopText = SKLabelNode(fontNamed: "AmericanTypewriter-Bold")
    let menuText = SKLabelNode(fontNamed: "Copperplate")
    let equipButton = SKSpriteNode(imageNamed: "button")
    let equipText = SKLabelNode(fontNamed: "Copperplate")
    let left = SKSpriteNode(imageNamed: "left")
    let right = SKSpriteNode(imageNamed: "right")
    let cost = SKLabelNode(fontNamed: "AvenirNext-HeavyItalic")
    let money = SKLabelNode(fontNamed: "AvenirNext-HeavyItalic")
    
    var intCost = 0
    var canBuy = false
    var menuPressed = false
    var equipPressed = false
    var leftPress = false
    var rightPress = false
    
    override func didMoveToView(view: SKView) {
        
        bgr = SKSpriteNode(imageNamed: "HELP"+(String)(currentBGR))
        bgr.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)+40)
        bgr.yScale = (self.frame.width / bgr.size.height)/1.4
        bgr.xScale = (self.frame.height / bgr.size.width)/1.7
        bgr.zPosition = -1.0
        
        menuButton.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)-270)
        menuButton.xScale = 0.285
        menuButton.yScale = 0.2625
        menuText.fontColor = UIColor.blackColor()
        menuText.text = "Menu"
        menuText.fontSize = 30;
        menuText.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)-280);
        menuText.zPosition = 2.0
        
        right.position = CGPoint(x:CGRectGetMidX(self.frame)+150, y:CGRectGetMidY(self.frame)-250)
        right.xScale = 0.5
        right.yScale = 0.5
        
        left.position = CGPoint(x:CGRectGetMidX(self.frame)-150, y:CGRectGetMidY(self.frame)-250)
        left.xScale = 0.5
        left.yScale = 0.5
        
        self.addChild(bgr)
        self.addChild(menuButton)
        self.addChild(menuText)
        self.addChild(left)
        self.addChild(right)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches
        {
            let loc = touch.locationInNode(self)
            let check = self.nodeAtPoint(loc)
            if(check == menuButton || check == menuText)
            {
                menuPressed = true
                menuText.fontColor = UIColor.redColor()
                menuText.fontSize = 20;
                menuButton.xScale = menuButton.xScale*0.75
                menuButton.yScale = menuButton.yScale*0.75
                menuButton.texture = SKTexture(imageNamed: "buttonSel")
            }
            if(check == left)
            {
                leftPress = true
                left.xScale = left.xScale*0.75
                left.yScale = left.yScale*0.75
            }
            if(check == right)
            {
                rightPress = true
                right.xScale = right.xScale*0.75
                right.yScale = right.yScale*0.75
            }
            
        }
        
        
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches
        {
            let loc = touch.locationInNode(self)
            let check = self.nodeAtPoint(loc)
            if((check == menuButton || check == menuText) && (menuPressed == true))
            {
                menuPressed = false
                let transition = SKTransition.revealWithDirection(.Down, duration: 0.5)
                let nextScene = MenuScene(size: scene!.size)
                nextScene.scaleMode = .AspectFill
                scene?.view?.presentScene(nextScene, transition: transition)
            }
            else if((check == left) && (leftPress == true))
            {
                if(currentBGR > 0)
                {
                    currentBGR--
                }
                else
                {
                    currentBGR = 5
                }
                left.xScale = 0.5
                left.yScale = 0.5
                bgr.texture = SKTexture(imageNamed: "HELP"+(String)(currentBGR))
            }
            else if((check == right) && (rightPress == true))
            {
                if(currentBGR < 5)
                {
                    currentBGR++
                }
                else
                {
                    currentBGR = 0
                }
                right.xScale = 0.5
                right.yScale = 0.5
                bgr.texture = SKTexture(imageNamed: "HELP"+(String)(currentBGR))
            }
            else
            {
                menuPressed = false
                leftPress = false
                rightPress = false
                menuText.fontColor = UIColor.blackColor()
                menuButton.xScale = 0.285
                menuButton.yScale = 0.2625
                left.xScale = 0.5
                left.yScale = 0.5
                right.xScale = 0.5
                right.yScale = 0.5
                menuText.fontSize = 30
                menuButton.texture = SKTexture(imageNamed: "button")
            }
        }
        
        
    }
    override func update(currentTime: CFTimeInterval) {
        
        
    }
}







