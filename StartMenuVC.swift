//
//  StartMenuVC.swift
//  planeteater
//
//  Created by firat sezel on 15/01/16.
//  Copyright © 2016 firat sezel. All rights reserved.
//
import UIKit

class StartMenuVC: UIViewController {

    @IBOutlet weak var startBut: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    var help = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myNormalAttributedTitle = NSAttributedString(string: "START",
            attributes: [NSForegroundColorAttributeName : UIColor.white])
        startBut.setAttributedTitle(myNormalAttributedTitle, for: UIControlState())
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "startback.jpg")!)
        AnimationStar1()
        let seconds = 0.6
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let delay2 = seconds * Double(NSEC_PER_SEC) * 1.5  // nanoseconds per seconds
        let delay3 = seconds * Double(NSEC_PER_SEC) * 2  // timer for fourt delay time
        let dispatchTime = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        let dispatchTime2 = DispatchTime.now() + Double(Int64(delay2)) / Double(NSEC_PER_SEC)
        let dispatchTime3 = DispatchTime.now() + Double(Int64(delay3)) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
            self.AnimationStar2()
        })
        
        DispatchQueue.main.asyncAfter(deadline: dispatchTime2, execute: {
            self.AnimationStar3()
        })
        
        DispatchQueue.main.asyncAfter(deadline: dispatchTime3, execute: {
            self.AnimationStar4()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func AnimationStar1(){
        let square = UIView()
        square.frame = CGRect(x: -30, y: 300, width: 32, height: 32)
        square.backgroundColor = UIColor(patternImage: UIImage(named: "animationstar.png")!)
        
        // add the square to the screen
        self.view!.addSubview(square)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 16,y: 239))
        path.addCurve(to: CGPoint(x: 301, y: 239), controlPoint1: CGPoint(x: 136, y: 373), controlPoint2: CGPoint(x: 178, y: 110))
        
        // create a new CAKeyframeAnimation that animates the objects position
        let anim = CAKeyframeAnimation(keyPath: "position")
        
        // set the animations path to our bezier curve
        anim.path = path.cgPath
        
        anim.rotationMode = kCAAnimationRotateAuto
        anim.repeatCount = Float.infinity
        anim.duration = 2.0
        
        // we add the animation to the squares 'layer' property
        square.layer.add(anim, forKey: "animate position along path")
    }
    
    func AnimationStar2(){
        let square = UIView()
        square.frame = CGRect(x: -30, y: 250, width: 32, height: 32)
        square.backgroundColor = UIColor(patternImage: UIImage(named: "animationstar.png")!)
        
        // add the square to the screen
        self.view!.addSubview(square)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 16,y: 189))
        path.addCurve(to: CGPoint(x: 301, y: 189), controlPoint1: CGPoint(x: 136, y: 323), controlPoint2: CGPoint(x: 178, y: 60))
        
        // create a new CAKeyframeAnimation that animates the objects position
        let anim = CAKeyframeAnimation(keyPath: "position")
        
        // set the animations path to our bezier curve
        anim.path = path.cgPath
        
        anim.rotationMode = kCAAnimationRotateAuto
        anim.repeatCount = Float.infinity
        anim.duration = 2.0
        
        // we add the animation to the squares 'layer' property
        square.layer.add(anim, forKey: "animate position along path")
    }
    
    func AnimationStar3(){
        let square = UIView()
        square.frame = CGRect(x: -30, y: 350, width: 32, height: 32)
        square.backgroundColor = UIColor(patternImage: UIImage(named: "animationstar.png")!)
        
        // add the square to the screen
        self.view!.addSubview(square)
        
        //bezier path for curve
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 16,y: 289))
        path.addCurve(to: CGPoint(x: 301, y: 289), controlPoint1: CGPoint(x: 136, y: 423), controlPoint2: CGPoint(x: 178, y: 110))
        
        // create a new CAKeyframeAnimation that animates the objects position
        let anim = CAKeyframeAnimation(keyPath: "position")
        
        // set the animations path to our bezier curve
        anim.path = path.cgPath
        
        anim.rotationMode = kCAAnimationRotateAuto
        anim.repeatCount = Float.infinity
        anim.duration = 2.0
        
        // we add the animation to the squares 'layer' property
        square.layer.add(anim, forKey: "animate position along path")
    }
    
    func AnimationStar4(){
        let square = UIView()
        square.frame = CGRect(x: -30, y: 450, width: 32, height: 32)
        square.backgroundColor = UIColor(patternImage: UIImage(named: "animationstar.png")!)
        
        // add the square to the screen
        self.view!.addSubview(square)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 16,y: 389))
        path.addCurve(to: CGPoint(x: 301, y: 389), controlPoint1: CGPoint(x: 136, y: 523), controlPoint2: CGPoint(x: 178, y: 160))
        
        // create a new CAKeyframeAnimation that animates the objects position
        let anim = CAKeyframeAnimation(keyPath: "position")
        
        // set the animations path to our bezier curve
        anim.path = path.cgPath
        
        anim.rotationMode = kCAAnimationRotateAuto
        anim.repeatCount = Float.infinity
        anim.duration = 2.0
        
        // we add the animation to the squares 'layer' property
        square.layer.add(anim, forKey: "animate position along path")
    }
    
    
    @IBAction func startButAc(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toGame", sender: self)
    }
    
}
