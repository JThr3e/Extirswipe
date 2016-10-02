//
//  SuperGameScene.swift
//  Extirswipe
//
//  Created by Joseph Primmer on 12/16/15.
//  Copyright © 2015 TNTPrimer. All rights reserved.
//
import SpriteKit
import iAd

class SuperGameScene: SKScene, ADBannerViewDelegate{
    
    //var bannerView: ADBannerView!
    var score = 0
    let defaults = NSUserDefaults.standardUserDefaults()
    let extir = SKSpriteNode(imageNamed:"Blob")
    let swipe = SKSpriteNode(imageNamed:"Blob")
    let scoreLabel = SKLabelNode(fontNamed:"Copperplate-Bold")
    let timeLabel = SKLabelNode(fontNamed:"Copperplate-Bold")
    let myLabel = SKLabelNode(fontNamed:"Copperplate-Bold")
    let typeDisp = SKSpriteNode(imageNamed: "Shapes")
    let bak2menu = SKSpriteNode(imageNamed: "button")
    let topBanner = SKSpriteNode(imageNamed: "TopBanner")
    let bak2menuText = SKLabelNode(fontNamed: "Copperplate-Bold")
    let moneyLabel = SKLabelNode(fontNamed: "Copperplate-Bold")
    var flasherCount = 2
    var shapes = [Shape]()
    var numSprites = [SKLabelNode]()
    var sprites = [SKSpriteNode?](count: 8, repeatedValue: nil)
    var checks = [Bool](count: 8, repeatedValue: false)
    let smallSize = (CGFloat)(0.35)
    let bigSize = (CGFloat)(0.4)
    var newPuzzle = 0
    var currentType = 0
    var linePath = UIBezierPath()
    var line = SKShapeNode()
    var touchesBeganLoc = CGPoint()
    var gameOver = false
    var timer = NSTimer()
    var bak2Pressed = false
    var money = 0
    
    //let maxTime = 5
    //var timeVar = 5
    //var timeShape = SKSpriteNode(imageNamed: "5")
    //let lightning = []
    //var moovyMove = false
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let bgr = SKSpriteNode(imageNamed: "BGR"+(String)(defaults.integerForKey("texture")))
        
        bgr.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        bgr.xScale = (bgr.size.width / CGRectGetMaxX(self.frame))+0.3
        bgr.yScale = (bgr.size.height / CGRectGetMaxY(self.frame))
        bgr.zPosition = -1.0
        self.addChild(bgr)
        
//        bannerView = ADBannerView(adType: .Banner)
//        bannerView.delegate = self
//        bannerView.hidden = true
//        bannerView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(bannerView)
//        let viewDict = ["bannerView": bannerView]
//        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[bannerView]|", options: .AlignAllCenterX, metrics: nil, views: viewDict))
//        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[bannerView]|", options: .AlignAllCenterY, metrics: nil, views: viewDict))
        
        moneyLabel.fontColor = UIColor.blackColor()
        moneyLabel.text = "$"+String(money)
        moneyLabel.fontSize = 25;
        moneyLabel.position = CGPoint(x:CGRectGetMidX(self.frame)-140, y:CGRectGetMaxY(self.frame)-130);
        moneyLabel.zPosition = 2.0
        self.addChild(moneyLabel)
        
        topBanner.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        debugPrint(self.frame.width)
        debugPrint(topBanner.size.width)
        debugPrint((self.frame.width / topBanner.size.width))
        topBanner.xScale = 1.05
        topBanner.yScale = 1.05
        topBanner.zPosition = -0.5
        self.addChild(topBanner)
        
        linePath.lineWidth = 1.0
        line.lineWidth = 10.0
        line.strokeColor = SKColor.yellowColor()
        line.zPosition = 1.5
        
        typeDisp.xScale = 0.98
        typeDisp.yScale = 0.96
        typeDisp.position = CGPoint(x:CGRectGetMidX(self.frame)-2,
            y:CGRectGetMaxY(self.frame)-78);
        typeDisp.zPosition = 2.0
        self.addChild(typeDisp)
        
        
        extir.xScale = 0.1
        extir.yScale = 0.1
        extir.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        self.addChild(extir)
        extir.hidden = true
        
        swipe.xScale = 0.1
        swipe.yScale = 0.1
        swipe.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        self.addChild(swipe)
        swipe.hidden = true
        
        randomizeShapes()
        addShapes()
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("updateTimer"), userInfo: nil, repeats: true)
    }
//    func bannerViewDidLoadAd(banner: ADBannerView!) {
//        bannerView.hidden = false
//        debugPrint("YES")
//    }
//    
//    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
//        bannerView.hidden = true
//        debugPrint("NAW")
//    }
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
                
                for var index = 0; index<8; ++index
                {
                    if(extir.intersectsNode(sprites[index]!) && sprites[index]?.parent == self)
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
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if(gameOver == false)
        {
            for touch in touches {
                let loc = touch.locationInNode(self)
                line.removeFromParent()
                line.removeAllChildren()
                linePath.removeAllPoints()
                linePath.moveToPoint(touchesBeganLoc)
                linePath.addLineToPoint(loc)
                line.path = linePath.CGPath
                let color = Int(arc4random_uniform(UInt32(6)))
                if(flasherCount == 0)
                {
                    flasherCount = 2
                    switch(color)
                    {
                    case(0):line.strokeColor = UIColor.redColor()
                    case(1):line.strokeColor = UIColor.blueColor()
                    case(2):line.strokeColor = UIColor.yellowColor()
                    case(3):line.strokeColor = UIColor.purpleColor()
                    case(4):line.strokeColor = UIColor.greenColor()
                    default:line.strokeColor = UIColor.orangeColor()
                    }
                }
                else
                {
                    flasherCount--
                }
                
                
                self.addChild(line)
                swipe.position = loc
                for var index = 0; index<8; ++index
                {
                    if(swipe.intersectsNode(sprites[index]!))
                    {
                        sprites[index]!.xScale = bigSize
                        sprites[index]!.yScale = bigSize
                        numSprites[index].fontSize = 45
                        
                    }
                }
                for var index = 0; index<8; ++index
                {
                    if(!swipe.intersectsNode(sprites[index]!) && checks[index] == false)
                    {
                        sprites[index]!.xScale = smallSize
                        sprites[index]!.yScale = smallSize
                        numSprites[index].fontSize = 40
                        
                    }
                }
                
            }
            
        }
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
                    bak2menu.xScale = 0.8
                    bak2menu.yScale = 0.4
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
                    if(extir.intersectsNode(sprites[index]!) )
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
//            if(newPuzzle == 4)
//            {
//                newPuzzle = 0
//                gameOver = false
//                timeVar = maxTime
//                timeShape.texture = SKTexture(imageNamed: "5")
//                score++
//                pickType(typeDisp)
//                randomizeShapes()
//                addShapes()
//                scoreLabel.text = "Score: " + String(score)
//            }
            
        }
        
    }
    
    func randomizeShapes()
    {
        var nums = [1, 2, 3, 4, 1, 2, 3, 4]
        var colors = [1, 2, 3, 4, 1, 2, 3, 4]
        var types = [1, 2, 3, 4, 1, 2, 3, 4]
        var loca = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        shapes.removeAll()
        
        for var index = 0; index<8; ++index
        {
            let nm = Int(arc4random_uniform(UInt32(nums.count)))
            let co = Int(arc4random_uniform(UInt32(colors.count)))
            let ty = Int(arc4random_uniform(UInt32(types.count)))
            let lo = Int(arc4random_uniform(UInt32(loca.count)))
            //            debugPrint((nums[nm]))
            //            debugPrint((colors[co]))
            //            debugPrint(((index/2)+1))
            shapes.append(Shape(t: types[ty], n: nums[nm], c: colors[co], l: loca[lo]))
            nums.removeAtIndex(nm)
            colors.removeAtIndex(co)
            types.removeAtIndex(ty)
            loca.removeAtIndex(lo)
            //debugPrint(((index/2)+1))
        }
        
        
        //        for shape in shapes
        //        {
        //            debugPrint((shape.getType()))
        //            debugPrint((shape.getNumb()))
        //            debugPrint((shape.getColo()))
        //
        //        }
        
    }
    
    func addShapes()
    {
        for var index = 0; index<8; ++index
        {
            numSprites.append(SKLabelNode(fontNamed: "Chalkduster"))
            switch(shapes[index].getType())
            {
            case(1):sprites[index] = SKSpriteNode(imageNamed: "Blob"+(String)(defaults.integerForKey("shapes")))
            case(2):sprites[index] = SKSpriteNode(imageNamed: "MCBlock"+(String)(defaults.integerForKey("shapes")))
            case(3):sprites[index] = SKSpriteNode(imageNamed: "Illuminati"+(String)(defaults.integerForKey("shapes")))
            case(4):sprites[index] = SKSpriteNode(imageNamed: "Plussy"+(String)(defaults.integerForKey("shapes")))
            default:sprites[index] = SKSpriteNode(imageNamed: "ERROR")
            }
            switch(shapes[index].getColo())
            {
            case(1):sprites[index]!.color = SKColor(red: 1.0/255, green: 130.0/255, blue: 254.0/255, alpha: 1.0)
            case(2):sprites[index]!.color = SKColor(red: 254.0/255, green: 40.0/255, blue: 40.0/255, alpha: 1.0)
            case(3):sprites[index]!.color = SKColor.yellowColor()
            case(4):sprites[index]!.color = SKColor.greenColor()
            default:sprites[index]!.color = SKColor.blackColor()
            }
            switch(shapes[index].getNumb())
            {
            case(1):numSprites[index].text = "1";
            case(2):numSprites[index].text = "2";
            case(3):numSprites[index].text = "3";
            case(4):numSprites[index].text = "4";
            default:numSprites[index].text = "5";
            }
            
            switch(shapes[index].getColo())
            {
            case(1):numSprites[index].fontColor = UIColor.orangeColor()
            case(2):numSprites[index].fontColor = UIColor.greenColor()
            case(3):numSprites[index].fontColor = UIColor.purpleColor()
            case(4):numSprites[index].fontColor = UIColor.redColor()
            default:numSprites[index].fontColor = UIColor.blackColor()
            }
            
            sprites[index]!.colorBlendFactor = 1.0
            sprites[index]!.xScale = smallSize
            sprites[index]!.yScale = smallSize
            
            //numSprites[index].fontColor = UIColor.blackColor()
            numSprites[index].fontSize = 40
            numSprites[index].zPosition = 1.0
            var xLoc = CGFloat(0.0)
            var yLoc = CGFloat(0.0)
            let xRand = (CGFloat)(arc4random_uniform(40))-20
            let yRand = (CGFloat)(arc4random_uniform(40))-20
            switch((shapes[index].getLoca()-1) / 3)
            {
            case(0): xLoc = CGRectGetMidX(self.frame)-150
            case(1): xLoc = CGRectGetMidX(self.frame)
            case(2): xLoc = CGRectGetMidX(self.frame)+150
            default: debugPrint("ABORT MISSION MAYDAY MAYDAYREEEE")
            }
            
            switch(shapes[index].getLoca() % 3)
            {
            case(0): yLoc = CGRectGetMidY(self.frame)-150
            case(1): yLoc = CGRectGetMidY(self.frame)
            case(2): yLoc = CGRectGetMidY(self.frame)+150
            default: debugPrint("ABORT MISSION MAYDAY MAYDAYRAAAAA")
            }
            sprites[index]?.position = CGPoint(x: xLoc + xRand, y: yLoc + yRand)
            numSprites[index].position = CGPoint(x: xLoc + xRand, y: yLoc + yRand - 10)
            numSprites[index].removeFromParent()
            self.addChild(sprites[index]!)
            self.addChild(numSprites[index])
            
            debugPrint(index)
        }
    }
    func pickType()
    {
        
    }
    
    func setType(type: UInt32, node: SKSpriteNode)
    {
        switch(type)
        {
            //currentType = Int(arc4random_uniform(UInt32(3)))
        case(0): node.texture = SKTexture(imageNamed: "ShapesType")
        case(1): node.texture = SKTexture(imageNamed: "NumbersType")
        case(2): node.texture = SKTexture(imageNamed: "ColorsType")
        default: debugPrint(("ABORT MISSION MAYDAY MAYDAY"))
        }
    }
    
    func updateTimer()
    {
//        timeVar--
//        if(timeVar == 0)
//        {
//            debugPrint("Outa Time")
//            gameOver = true
//            deaded()
//        }
//        else
//        {
//            timeShape.texture = SKTexture(imageNamed: (String)(timeVar))
//        }
    }
    func gameEnded()
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
        line.removeFromParent()
        
        bak2menu.xScale = 1.2
        bak2menu.yScale = 0.3
        
        bak2menuText.fontColor = UIColor.blackColor()
        bak2menuText.text = "bak2menu"
        bak2menuText.fontSize = 45;
        bak2menuText.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)-70);
        bak2menuText.zPosition = 2.0
        
        bak2menu.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)-60)
        bak2menu.removeFromParent()
        bak2menuText.removeFromParent()
        self.addChild(bak2menu)
        self.addChild(bak2menuText)
        scoreLabel.fontColor = UIColor.redColor()
        scoreLabel.text = "uLose Score: "+(String)(score)
        scoreLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        //        if(moovyMove == true)
        //        {
        //            for sprite in sprites
        //            {
        //                let loc = sprite?.position
        //                sprite?.position = CGPoint(x: (loc?.x)!+100, y: (loc?.y)!+100)
        //            }
        //            for num in numSprites
        //            {
        //                let loc = num.position
        //                num.position = CGPoint(x: (loc.x)+100, y: (loc.y)+100)
        //            }
        //            moovyMove = false
        //        }
        //        else
        //        {
        //            for sprite in sprites
        //            {
        //                let loc = sprite?.position
        //                sprite?.position = CGPoint(x: (loc?.x)!-100, y: (loc?.y)!-100)
        //            }
        //            for num in numSprites
        //            {
        //                let loc = num.position
        //                num.position = CGPoint(x: (loc.x)-100, y: (loc.y)-100)
        //            }
        //            moovyMove = true
        //        }
        
    }
}


