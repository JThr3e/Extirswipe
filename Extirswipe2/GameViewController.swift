//
//  GameViewController.swift
//  Extirswipe2
//
//  Created by Joseph Primmer on 11/16/15.
//  Copyright (c) 2015 TNTPrimer. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // RESET()
        if let scene = MenuScene(fileNamed:"MenuScene") {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = false
            skView.showsNodeCount = false
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
        }
    }
    func RESET()
    {
        defaults.setInteger(0, forKey: "highScore")
        defaults.setInteger(10000, forKey: "money")
        defaults.setInteger(0, forKey: "texture")
        defaults.setDouble(0.0, forKey: "lowTime")
        defaults.setBool(false, forKey: "Paper")
        defaults.setBool(false, forKey: "Bamboo")
        defaults.setBool(false, forKey: "Gold")
        defaults.setBool(false, forKey: "Inferno")
        defaults.setBool(false, forKey: "Water")
        defaults.setBool(false, forKey: "Space")
        defaults.setBool(false, forKey: "Paper")
        
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .Portrait
        } else {
            return .Portrait
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
