//
//  Shop.swift
//  Extirswipe
//
//  Created by Joseph Primmer on 12/30/15.
//  Copyright © 2015 TNTPrimer. All rights reserved.
//

//import SpriteKit
import SpriteKit

class Shop: SKScene {
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
        
        defaults.setBool(true, forKey: "Paper")
        bgr = SKSpriteNode(imageNamed: "BGR"+(String)(currentBGR))
        bgr.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        bgr.xScale = (bgr.size.width / CGRectGetMaxX(self.frame))+0.3
        bgr.yScale = (bgr.size.height / CGRectGetMaxY(self.frame))
        bgr.zPosition = -1.0
        
        shopText.fontColor = UIColor.blackColor()
        shopText.text = "Background Shop"
        shopText.fontSize = 45;
        shopText.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)+210);
        shopText.zPosition = 2.0
        
        cost.fontColor = UIColor.darkGrayColor()
        cost.text = "Bought!"
        cost.fontSize = 40;
        cost.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)+170);
        cost.zPosition = 2.0
        
        money.fontColor = UIColor.darkGrayColor()
        money.text = "PuzzleBits: $"+(String)(defaults.integerForKey("money"))
        money.fontSize = 30;
        money.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)+320);
        money.zPosition = 2.0
            
        menuButton.position = CGPoint(x:CGRectGetMidX(self.frame)-80, y:CGRectGetMidY(self.frame)-180)
        menuButton.xScale = 0.285
        menuButton.yScale = 0.2625
        menuText.fontColor = UIColor.blackColor()
        menuText.text = "Menu"
        menuText.fontSize = 30;
        menuText.position = CGPoint(x:CGRectGetMidX(self.frame)-80, y:CGRectGetMidY(self.frame)-190);
        menuText.zPosition = 2.0
        
        equipButton.position = CGPoint(x:CGRectGetMidX(self.frame)+80, y:CGRectGetMidY(self.frame)-180)
        equipButton.xScale = 0.285
        equipButton.yScale = 0.2625
        equipText.fontColor = UIColor.blackColor()
        if(defaults.integerForKey("texture") == 0)
        {
            equipText.text = "Equipped"
        }
        else{
            equipText.text = "Use"
        }
        
        equipText.fontSize = 30;
        equipText.position = CGPoint(x:CGRectGetMidX(self.frame)+80, y:CGRectGetMidY(self.frame)-190);
        equipText.zPosition = 2.0
        
        right.position = CGPoint(x:CGRectGetMidX(self.frame)+150, y:CGRectGetMidY(self.frame)-20)
        right.xScale = 0.5
        right.yScale = 0.5
        
        left.position = CGPoint(x:CGRectGetMidX(self.frame)-150, y:CGRectGetMidY(self.frame)-20)
        left.xScale = 0.5
        left.yScale = 0.5
            
        self.addChild(bgr)
        self.addChild(menuButton)
        self.addChild(menuText)
        self.addChild(equipButton)
        self.addChild(equipText)
        self.addChild(left)
        self.addChild(right)
        self.addChild(shopText)
        self.addChild(cost)
        self.addChild(money)
        outline(shopText)
        
        
    }
    
    func outline(node: SKLabelNode)
    {
        //debugPrint("hey")
        let shadow = SKLabelNode(fontNamed: node.fontName)
        shadow.text = node.text
        shadow.fontColor = UIColor.lightGrayColor()
        shadow.position = node.position
        shadow.zPosition = node.zPosition-1
        shadow.fontSize = node.fontSize+1
        self.addChild(shadow)
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
            if(check == equipButton || check == equipText)
            {
                equipPressed = true
                equipText.fontColor = UIColor.redColor()
                equipText.fontSize = 20;
                equipButton.xScale = equipButton.xScale*0.75
                equipButton.yScale = equipButton.yScale*0.75
                equipButton.texture = SKTexture(imageNamed: "buttonSel")
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
                let transition = SKTransition.revealWithDirection(.Down, duration: 0.0)
                let nextScene = MenuScene(size: scene!.size)
                nextScene.scaleMode = .AspectFill
                scene?.view?.presentScene(nextScene, transition: transition)
            }
            else if((check == equipButton || check == equipText) && (equipPressed == true))
            {
                if(canBuy)
                {
                    equipPressed = false
                    if(defaults.integerForKey("money") >= intCost){
                        defaults.setInteger(defaults.integerForKey("money") - intCost, forKey: "money")
                        canBuy = false
                        switch(currentBGR){
                        case(0): defaults.setBool(true, forKey: "Paper")
                        case(1): defaults.setBool(true, forKey: "Bamboo")
                        case(2): defaults.setBool(true, forKey: "Gold")
                        case(3): defaults.setBool(true, forKey: "Inferno")
                        case(4): defaults.setBool(true, forKey: "Water")
                        case(5): defaults.setBool(true, forKey: "Space")
                        default: defaults.setBool(true, forKey: "Paper")
                        }
                        if(currentBGR == 5){
                            cost.fontSize = 14
                            cost.fontName = "Zapfino"
                            cost.text = "WE CHOOSE 2 GOTO THE MOON!"
                        }
                        else{
                            cost.text = "Bought!"
                        }
                        money.text = "PuzzleBits: $"+(String)(defaults.integerForKey("money"))
                        equipText.fontColor = UIColor.blackColor()
                        equipButton.xScale = 0.285
                        equipButton.yScale = 0.2625
                        equipText.fontSize = 30
                        equipButton.texture = SKTexture(imageNamed: "button")
                        equipText.text = "USE"
                    }
                    else{
                        equipPressed = false
                        equipText.fontColor = UIColor.blackColor()
                        equipButton.xScale = 0.285
                        equipButton.yScale = 0.2625
                        equipText.fontSize = 30
                        equipButton.texture = SKTexture(imageNamed: "button")
                        equipText.text = "2POOR"
                    }
                }
                else
                {
                    equipPressed = false
                    equipText.fontColor = UIColor.blackColor()
                    equipButton.xScale = 0.285
                    equipButton.yScale = 0.2625
                    equipText.fontSize = 30
                    equipText.text = "Equipped"
                    equipButton.texture = SKTexture(imageNamed: "button")
                    defaults.setInteger(currentBGR, forKey: "texture")
                }
                
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
                checkBuy()
                left.xScale = 0.5
                left.yScale = 0.5
                bgr.texture = SKTexture(imageNamed: "BGR"+(String)(currentBGR))
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
                checkBuy()
                right.xScale = 0.5
                right.yScale = 0.5
                bgr.texture = SKTexture(imageNamed: "BGR"+(String)(currentBGR))
            }
            else
            {
                menuPressed = false
                equipPressed = false
                leftPress = false
                rightPress = false
                menuText.fontColor = UIColor.blackColor()
                equipText.fontColor = UIColor.blackColor()
                menuButton.xScale = 0.285
                menuButton.yScale = 0.2625
                equipButton.xScale = 0.285
                equipButton.yScale = 0.2625
                left.xScale = 0.5
                left.yScale = 0.5
                right.xScale = 0.5
                right.yScale = 0.5
                menuText.fontSize = 30
                equipText.fontSize = 30
                menuButton.texture = SKTexture(imageNamed: "button")
                equipButton.texture = SKTexture(imageNamed: "button")
            }
        }


    }
    func checkBuy()
    {
        cost.fontSize = 40;
        cost.fontName = "AvenirNext-HeavyItalic"
        var purchased = false
        switch(currentBGR){
        case(0): purchased = defaults.boolForKey("Paper")
        case(1): purchased = defaults.boolForKey("Bamboo")
        case(2): purchased = defaults.boolForKey("Gold")
        case(3): purchased = defaults.boolForKey("Inferno")
        case(4): purchased = defaults.boolForKey("Water")
        case(5): purchased = defaults.boolForKey("Space")
        default: purchased = true
        }
        if(purchased)
        {
            canBuy = false
            cost.text = "Bought!"
            if(defaults.integerForKey("texture") == currentBGR)
            {
                equipText.text = "Equipped"
            }
            else{
                equipText.text = "USE"
            }
        }
        else{
            canBuy = true
            switch(currentBGR){
            case(0): intCost = 0
            case(1): intCost = 500
            case(2): intCost = 2000
            case(3): intCost = 4000
            case(4): intCost = 5000
            case(5): intCost = 8000
            default: intCost = 99999
            }
            cost.text = "$"+(String)(intCost)
            equipText.text = "BUY"
        }
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        
        
    }
}






