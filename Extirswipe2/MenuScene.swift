//
//  MenuScene.swift
//  Extirswipe
//
//  Created by Joseph Primmer on 11/29/15.
//  Copyright © 2015 TNTPrimer. All rights reserved.
//

import SpriteKit
import iAd

class MenuScene: SKScene, ADBannerViewDelegate{
    var color = UIColor.redColor()
    var colorAction = 0
    var whiteAction = 0
    var r = 255
    var w = 0
    var g = 0
    var b = 0
    var bannerView: ADBannerView!
    let defaults = NSUserDefaults.standardUserDefaults()
    let playButton = SKSpriteNode(imageNamed: "button")
    let playText2 = SKLabelNode(fontNamed: "Copperplate-Bold")
    let playButton2 = SKSpriteNode(imageNamed: "button")
    let shopButton = SKSpriteNode(imageNamed: "button")
    let infoButton = SKSpriteNode(imageNamed: "info")
    let helpButton = SKSpriteNode(imageNamed: "help")
    let shopText = SKLabelNode(fontNamed: "Copperplate-Bold")
    let playText = SKLabelNode(fontNamed: "Copperplate-Bold")
    let title = SKLabelNode(fontNamed: "Chalkduster")
    let version = SKLabelNode(fontNamed: "Copperplate-Bold")
    let highScore = SKLabelNode(fontNamed: "Copperplate-Bold")
    let lowTime = SKLabelNode(fontNamed: "Copperplate-Bold")
    let money = SKLabelNode(fontNamed: "Copperplate-Bold")
    var playPressed = false
    var play2Pressed = false
    var shopPressed = false
    var infoPressed = false
    var helpPressed = false
    
    override func didMoveToView(view: SKView) {
        //debugPrint("BGR"+(String)(defaults.integerForKey("texture")))
        let bgr = SKSpriteNode(imageNamed: "BGR"+(String)(defaults.integerForKey("texture")))
        //let bgr = SKSpriteNode(imageNamed: "BGR1")
        bgr.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        bgr.xScale = (bgr.size.width / CGRectGetMaxX(self.frame))+0.3
        bgr.yScale = (bgr.size.height / CGRectGetMaxY(self.frame))
        bgr.zPosition = -1.0
        
       // debugPrint(self.frame)
        bannerView = ADBannerView(adType: .Banner)
        bannerView.delegate = self
        bannerView.hidden = true
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        let viewDict = ["bannerView": bannerView]
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[bannerView]|", options: .AlignAllCenterX, metrics: nil, views: viewDict))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[bannerView]|", options: .AlignAllCenterY, metrics: nil, views: viewDict))
        
        
        
        playButton.position = CGPoint(x:CGRectGetMidX(self.frame)-100, y:CGRectGetMidY(self.frame)-30)
        playButton.xScale = 0.38
        playButton.yScale = 0.35
        playText.fontColor = UIColor.blackColor()
        playText.text = "Timed"
        playText.fontSize = 40;
        playText.position = CGPoint(x:CGRectGetMidX(self.frame)-100, y:CGRectGetMidY(self.frame)-40);
        playText.zPosition = 2.0
        
        playButton2.position = CGPoint(x:CGRectGetMidX(self.frame)+100, y:CGRectGetMidY(self.frame)-30)
        playButton2.xScale = 0.38
        playButton2.yScale = 0.35
        playText2.fontColor = UIColor.blackColor()
        playText2.text = "Practice"
        playText2.fontSize = 40;
        playText2.position = CGPoint(x:CGRectGetMidX(self.frame)+100, y:CGRectGetMidY(self.frame)-40);
        playText2.zPosition = 2.0
        
        shopButton.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)-150)
        shopButton.xScale = 0.38
        shopButton.yScale = 0.35
        shopText.fontColor = UIColor.blackColor()
        shopText.text = "Shop"
        shopText.fontSize = 40;
        shopText.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)-160);
        shopText.zPosition = 2.0
        
        infoButton.position = CGPoint(x:CGRectGetMidX(self.frame)-145, y:CGRectGetMidY(self.frame)-230)
        infoButton.xScale = 0.4
        infoButton.yScale = 0.4
        
        helpButton.position = CGPoint(x:CGRectGetMidX(self.frame)+145, y:CGRectGetMidY(self.frame)-230)
        helpButton.xScale = 0.4
        helpButton.yScale = 0.4
        
        

        title.fontColor = UIColor.blueColor()
        title.text = "Extirswipe"
        title.fontSize = 60;
        title.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)+250);
        title.zPosition = 2.0
        
        version.fontColor = UIColor.redColor()
        version.text = ""
        version.fontSize = 25;
        version.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)+200);
        version.zPosition = 2.0
        
        
        highScore.fontColor = UIColor.darkGrayColor()
        highScore.text = "Highest Score: "+(String)(defaults.integerForKey("highScore"))
        highScore.fontSize = 35;
        highScore.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)+150);
        highScore.zPosition = 2.0
        
        money.fontColor = UIColor.darkGrayColor()
        money.text = "Puzzlebits: "+(String)(defaults.integerForKey("money"))
        money.fontSize = 35;
        money.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)+75);
        money.zPosition = 2.0
        
        lowTime.fontColor = UIColor.darkGrayColor()
        if(defaults.doubleForKey("lowTime") == 0.0)
        {
            lowTime.text = "Lowest Time: none"
        }
        else
        {
            lowTime.text = "Lowest Time: "+(String)(defaults.doubleForKey("lowTime"))
        }
        lowTime.fontSize = 35;
        lowTime.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)+110);
        lowTime.zPosition = 2.0
        
        self.addChild(bgr)
        self.addChild(version)
        self.addChild(playText)
        self.addChild(title)
        self.addChild(playButton)
        self.addChild(playButton2)
        self.addChild(playText2)
        self.addChild(helpButton)
        self.addChild(infoButton)
        //outline(highScore)
        self.addChild(highScore)
        //outline(lowTime)
        self.addChild(lowTime)
        //outline(money)
        self.addChild(money)
        self.addChild(shopButton)
        self.addChild(shopText)
        
    }
//    func outline(node: SKLabelNode)
//    {
//        //debugPrint("hey")
//        let shadow = SKLabelNode(fontNamed: node.fontName)
//        shadow.text = node.text
//        shadow.fontColor = UIColor.lightGrayColor()
//        shadow.position = node.position
//        shadow.zPosition = node.zPosition-1
//        shadow.fontSize = node.fontSize+1
//        self.addChild(shadow)
//    }
    
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        bannerView.hidden = true
        debugPrint("YES")
    }
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        bannerView.hidden = true
        debugPrint("NAW")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches
        {
            let loc = touch.locationInNode(self)
            let check = self.nodeAtPoint(loc)
            if(check == playButton || check == playText)
            {
                playPressed = true
                playText.fontColor = UIColor.redColor()
                playText.fontSize = 30;
                playButton.xScale = 0.33
                playButton.yScale = 0.29
                playButton.texture = SKTexture(imageNamed: "buttonSel")
            }
            if(check == playButton2 || check == playText2)
            {
                play2Pressed = true
                playText2.fontColor = UIColor.redColor()
                playText2.fontSize = 30;
                playButton2.xScale = 0.33
                playButton2.yScale = 0.29
                playButton2.texture = SKTexture(imageNamed: "buttonSel")
            }
            if(check == shopButton || check == shopText)
            {
                shopPressed = true
                shopText.fontColor = UIColor.redColor()
                shopText.fontSize = 30;
                shopButton.xScale = 0.33
                shopButton.yScale = 0.29
                shopButton.texture = SKTexture(imageNamed: "buttonSel")
            }
            if(check == infoButton)
            {
                infoPressed = true
                infoButton.xScale = 0.3
                infoButton.yScale = 0.3
            }
            if(check == helpButton)
            {
                helpPressed = true
                helpButton.xScale = 0.3
                helpButton.yScale = 0.3
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
            if((check == playButton || check == playText) && (playPressed == true))
            {
                playPressed = false
                let transition = SKTransition.revealWithDirection(.Down, duration: 0.0)
                let nextScene = GameScene(size: scene!.size)
                nextScene.scaleMode = .AspectFill
                scene?.view?.presentScene(nextScene, transition: transition)
            }
            else if((check == playButton2 || check == playText2) && (play2Pressed == true))
            {
                play2Pressed = false
                let transition = SKTransition.revealWithDirection(.Down, duration: 0.0)
                let nextScene = GameScene2(size: scene!.size)
                nextScene.scaleMode = .AspectFill
                scene?.view?.presentScene(nextScene, transition: transition)
            }
            else if((check == shopButton || check == shopText) && (shopPressed == true))
            {
                shopPressed = false
                let transition = SKTransition.revealWithDirection(.Down, duration: 0.0)
                let nextScene = Shop(size: scene!.size)
                nextScene.scaleMode = .AspectFill
                scene?.view?.presentScene(nextScene, transition: transition)
            }
            else if(check == infoButton)&&(infoPressed == true)
            {
                infoPressed = false
                infoButton.xScale = 0.4
                infoButton.yScale = 0.4
                let transition = SKTransition.revealWithDirection(.Up, duration: 0.5)
                let nextScene = Info(size: scene!.size)
                nextScene.scaleMode = .AspectFill
                scene?.view?.presentScene(nextScene, transition: transition)
            }
            else if(check == helpButton)&&(helpPressed == true)
            {
                helpPressed = false
                helpButton.xScale = 0.4
                helpButton.yScale = 0.4
                let transition = SKTransition.revealWithDirection(.Up, duration: 0.5)
                let nextScene = Help(size: scene!.size)
                nextScene.scaleMode = .AspectFill
                scene?.view?.presentScene(nextScene, transition: transition)
            }
            else
            {
                playPressed = false
                playText.fontColor = UIColor.blackColor()
                playText2.fontColor = UIColor.blackColor()
                shopText.fontColor = UIColor.blackColor()
                shopButton.xScale = 0.38
                shopButton.yScale = 0.35
                playButton.xScale = 0.38
                playButton.yScale = 0.35
                playButton2.xScale = 0.38
                playButton2.yScale = 0.35
                infoButton.xScale = 0.4
                infoButton.yScale = 0.4
                helpButton.xScale = 0.4
                helpButton.yScale = 0.4
                playText.fontSize = 40
                playText2.fontSize = 40
                shopText.fontSize = 40
                playButton.texture = SKTexture(imageNamed: "button")
                playButton2.texture = SKTexture(imageNamed: "button")
                shopButton.texture = SKTexture(imageNamed: "button")
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        switch(colorAction)
        {
        case(0):b+=20;title.fontSize++;if(b>=230){colorAction++}
        case(1):r-=20;title.fontSize--;if(r<=0){colorAction++}
        case(2):g+=20;title.fontSize++;if(g>=230){colorAction++}
        case(3):b-=20;title.fontSize--;if(b<=0){colorAction++}
        case(4):r+=20;title.fontSize++;if(r>=230){colorAction++}
        case(5):g-=20;title.fontSize--;if(g<=0){colorAction=0}
        default:debugPrint("OH HEW NAW")
        }
        if(whiteAction == 0)
        {
            w+=3
            if(w >= 140) {whiteAction = 1}
        }
        else
        {
            w-=3
            if(w<=0) {whiteAction = 0}
        }
        
       color = UIColor(red: (CGFloat)(r)/(255.0), green: (CGFloat)(g)/(255.0), blue: (CGFloat)(b)/(255.0), alpha: 255.0)
        money.fontColor = UIColor.init(white: (CGFloat)(w)/255.0, alpha: 255)
        highScore.fontColor = UIColor.init(white: (CGFloat)(w)/255.0, alpha: 255)
        lowTime.fontColor = UIColor.init(white: (CGFloat)(w)/255.0, alpha: 255)
        title.fontColor = color
        
    }
}

