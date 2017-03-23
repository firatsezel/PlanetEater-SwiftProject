//
//  GameViewController.swift
//  WhiteRing
//
//  Created by firat sezel on 24/08/15.
//  Copyright (c) 2015 firat sezel. All rights reserved.
//

import UIKit
import SpriteKit



class GameViewController: UIViewController {
    
    @IBOutlet weak var CircleImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black
        
        CircleImage.layer.cornerRadius = CircleImage.frame.size.width / 2
        CircleImage.clipsToBounds = true
        
        
        CircleImage.layer.borderColor = UIColor.clear.cgColor
        CircleImage.layer.borderWidth = 5.0
        //CircleImage.backgroundColor = UIColor(patternImage: UIImage(named:"bh.gif")!)
        
        let scene = GameScene(size: view.bounds.size)
        scene.backgroundColor = UIColor.black
        // Configure the view.
        let skView = self.view as! SKView
        skView.ignoresSiblingOrder = true
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
        
    }
    
    override var shouldAutorotate : Bool {
        return true
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return UIInterfaceOrientationMask.allButUpsideDown
        } else {
            return UIInterfaceOrientationMask.all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGame" {
            self.viewDidLoad()
        }
    }
}
