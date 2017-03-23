//
//  GameScene.swift
//  planeteater
//
//  Created by firat sezel on 16/10/15.
//  Copyright (c) 2015 firat sezel. All rights reserved.
//

import SpriteKit
import AVFoundation
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}



class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let users = UserDefaults.standard
    
    var startTime: TimeInterval = TimeInterval()
    var endTime: TimeInterval = TimeInterval()
    
    var myProgressView: UIProgressView?
    var theBool: Bool?

    var numberofMyBalls: Int = 10
    
    var coinSound = URL(fileURLWithPath: Bundle.main.path(forResource: "balleffect", ofType: "wav")!)
    var audioPlayer = AVAudioPlayer()
    
    
    var rockets:[SKSpriteNode] = []
    var stars: [SKSpriteNode] = []
    var help: SKSpriteNode!
    var Bomb: SKSpriteNode!
    var Chance: SKSpriteNode!
    var score:Int = 0
    var myLabel:SKLabelNode!
    var speedLabel:SKLabelNode!
    var myLabelc:SKLabelNode!
    var speedLabelc:SKLabelNode!
    var gameoverLabel:SKLabelNode!
    var highscoreLabel:SKLabelNode!
    var highscoreLabelc:SKLabelNode!
    var totalnumberball:SKLabelNode!
    var speedy:Int = 0
    var button: SKNode! = nil
    var fireAllow:Bool = true
    var highscore:String = "0"
    var limitsofhelp: Int = 10 // help iconunun dusecegi araligi belirler
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(size: CGSize){
        super.init(size: size)
    }
    
    override func didMove(to view: SKView) {
        theBool = true // yeniden ates acilabilmesi icin
        numberofMyBalls = 20 //toplam atis hakkinin yenilenmesi
        
        //var coinSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("coin", ofType: "wav")!)
        //var audioPlayer = AVAudioPlayer()
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: coinSound, fileTypeHint: nil)
            audioPlayer.prepareToPlay()
        }catch {
            print("ses mes yok")
        }
        
        
        
        if users.object(forKey: "high") as? String != nil {
            highscore = users.object(forKey: "high") as! String
        }else{
            highscore = ""
        }
        
        PrepareLabels()
        help = SKSpriteNode(imageNamed: "help")
        
        let sprite = SKSpriteNode(imageNamed: "animationstar.png")
        
        sprite.position = CGPoint(x: 100, y: 50)
        sprite.color = UIColor.white
        
        let circle = UIBezierPath(roundedRect: CGRect(x: 60, y: 280, width: 200, height: 200), cornerRadius: 200)
        
        let followCircle = SKAction.follow(circle.cgPath, asOffset: false, orientToPath: false, duration: 4.0)
        
        sprite.run(SKAction.repeatForever(followCircle))
        
        Bomb = sprite
        
        Bomb.speed = 13
        speedy = 13
        
        self.addChild(highscoreLabelc)
        self.addChild(highscoreLabel)
        self.addChild(speedLabel)
        self.addChild(myLabel)
        self.addChild(speedLabelc)
        self.addChild(myLabelc)
        self.addChild(gameoverLabel)
        self.addChild(totalnumberball)
        self.addChild(sprite)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        //Sart the timer
        for touch in (touches){
            let location = touch.location(in: self)
            
            startTime = Date.timeIntervalSinceReferenceDate
            
            if(help.contains(location)){
                help.removeFromParent()
                let randomnum = Int(arc4random_uniform(5))
                switch randomnum {
                case 1:
                    speedy += 1
                    Bomb.speed += 1
                case 2:
                    speedy += 2
                    Bomb.speed += 2
                case 3:
                    speedy -= 2
                    Bomb.speed -= 1
                case 4:
                    speedy -= 1
                    Bomb.speed -= 1
                default:
                    numberofMyBalls += 5
                    
                speedLabelc.text = String(speedy)
                totalnumberball.text = String(numberofMyBalls)
                }
            }
        }
        
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if numberofMyBalls > 0 {
            for touch in (touches ) {
                let location = touch.location(in: self)
                
                //numberofMyBalls -= 1
                totalnumberball.text = String(numberofMyBalls)
                
                if numberofMyBalls == 0 {
                    GameOver()
                }//hic top atma hakkimiz kalmamissa oyun bitecek
                
                audioPlayer.stop()
                
                do {
                    try audioPlayer = AVAudioPlayer(contentsOf: coinSound, fileTypeHint: nil)
                    audioPlayer.prepareToPlay()
                }catch {
                    print("ses mes yok")
                }
                audioPlayer.play()
                
                if fireAllow && location.y < 165 {
                    numberofMyBalls -= 1 // her dokunusta gezegen hakkini azaltir
                    
                    let sprite = SKSpriteNode(imageNamed: "earth32")
                    sprite.alpha = 1
                    endTime = Date.timeIntervalSinceReferenceDate as Double
                    var speedofNode = (endTime - startTime) * 2
                    sprite.position = location
                    sprite.color = UIColor.white
                    
                    if speedofNode < 1.2 {
                        speedofNode = 1.2
                    }else if speedofNode > 3 {
                        speedofNode = 3
                    }
                    sprite.speed = CGFloat(speedofNode);
                    
                    let action = SKAction.move(to: CGPoint(x: 150, y: 360), duration: 3)
                    sprite.run(SKAction.repeatForever(action))
                    
                    
                    rockets.append(sprite)
                    self.addChild(sprite)
                }else{
                    if !fireAllow {
                        if button.contains(location) {
                            let scene = GameScene(size: self.size)
                            scene.backgroundColor = UIColor.black
                            self.view?.presentScene(scene)
                        }
                    }
                }
            }
        }
    }
   
    //Preparing Label for the beginning of the game - call in ViewLoad
    func PrepareLabels(){
        myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Score"
        myLabel.fontSize = 30
        myLabel.position = CGPoint(x: 55, y: 510)
        myLabel.isHidden = false
        
        speedLabel = SKLabelNode(fontNamed:"Chalkduster")
        speedLabel.text = "Speed"
        speedLabel.fontSize = 30
        speedLabel.position = CGPoint(x: 260, y: 510)
        speedLabel.isHidden = false
        
        myLabelc = SKLabelNode(fontNamed:"Chalkduster")
        myLabelc.text = "0"
        myLabelc.fontSize = 23
        myLabelc.position = CGPoint(x: 55, y: 480)
        myLabelc.isHidden = false
        
        speedLabelc = SKLabelNode(fontNamed:"Chalkduster")
        speedLabelc.text = "13"
        speedLabelc.fontSize = 23
        speedLabelc.position = CGPoint(x: 270, y: 470)
        speedLabelc.isHidden = false
        
        gameoverLabel = SKLabelNode(fontNamed:"Chalkduster")
        gameoverLabel.text = "GAME OVER"
        gameoverLabel.fontSize = 40
        gameoverLabel.position = CGPoint(x: 155, y: 180)
        gameoverLabel.isHidden = true
        
        highscoreLabel = SKLabelNode(fontNamed:"Chalkduster")
        highscoreLabel.text = "High Score"
        highscoreLabel.fontSize = 25
        highscoreLabel.position = CGPoint(x: 155, y: 150)
        highscoreLabel.isHidden = true
        
        highscoreLabelc = SKLabelNode(fontNamed:"Chalkduster")
        highscoreLabelc.text = "0"
        highscoreLabelc.fontSize = 25
        highscoreLabelc.position = CGPoint(x: 155, y: 120)
        highscoreLabelc.isHidden = true
        
        totalnumberball = SKLabelNode(fontNamed: "Chalkduster")
        totalnumberball.text = "20"
        totalnumberball.fontSize = 30
        totalnumberball.position = CGPoint(x: 155, y: 505)
        totalnumberball.isHidden = false
    }
    
    //Executes when game is over - Loading new scene
    func GameOver(){
        theBool = false
        gameoverLabel.isHidden = false
        Bomb.speed = 0
        fireAllow = false
        highscoreLabelc.isHidden = false
        highscoreLabel.isHidden = false
        if score > Int(highscore) {
            highscore = String(score)
            users.set(highscore, forKey: "high")
        }
        highscoreLabelc.text = highscore
        button = SKSpriteNode(imageNamed: "Replace.png")
        // Put it in the center of the scene
        
        button.position = CGPoint(x:160, y:30);
        theBool = false
        
        self.addChild(button)
    }
    
    //Update func for any updates during gameplay - updates for touches and gameover control
    override func update(_ currentTime: TimeInterval) {
        for(i:Int, in 0 ..< rockets.count){//  Error with Swift 3.0
            let sprite: SKSpriteNode = rockets[i]
            
            if sprite.contains(CGPoint(x: Bomb.position.x , y: Bomb.position.y)) {
                sprite.removeFromParent()
                rockets.remove(at: i)
                Bomb.speed += 1
                speedy += 1
                speedLabelc.text = String(speedy)
                if (speedy > 35 || speedy == 0 || numberofMyBalls == 0) {
                    GameOver()
                }
            }
            if sprite.position == CGPoint(x: 150, y: 360){
                sprite.removeFromParent()
                rockets.remove(at: i)
                AnimationStar()//star appears when the ball int the circle
                numberofMyBalls += 2
                Bomb.speed -= 1
                if speedy > 0 {
                    speedy -= 1
                }
                score += 10
                if score == limitsofhelp {
                    AnimationHelp()
                    limitsofhelp *= 2
                }
                myLabelc.text = String(score)
                speedLabelc.text = String(speedy)
                totalnumberball.text = String(numberofMyBalls)
                if (speedy > 35 || speedy == 0 || numberofMyBalls == 0) {
                    GameOver()
                }
            }
        }
    }
    
    //the ball which falls when the score doubled - suprise help?
    func AnimationHelp(){
        help = SKSpriteNode(imageNamed: "colorball")
        help.alpha = 1
        
        let xpos:Int = Int(arc4random_uniform(300))
        
        help.position = CGPoint(x: xpos, y: 400)
        
        help.speed = CGFloat(3)
        
        let actionh = SKAction.move(to: CGPoint(x: xpos, y: -100), duration: 12)
        
        help.run(SKAction.repeatForever(actionh))
        
        self.addChild(help)
    }
    
    //this animation executes when your ball passed from the circle
    func AnimationStar(){
        let square = UIView()
        square.frame = CGRect(x: -30, y: 300, width: 32, height: 32)
        square.backgroundColor = UIColor(patternImage: UIImage(named: "animationstar.png")!)
        
        // add the square to the screen
        self.view!.addSubview(square)
        
        //bezier path for curve
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 16,y: 239))
        path.addCurve(to: CGPoint(x: 301, y: 239), controlPoint1: CGPoint(x: 136, y: 373), controlPoint2: CGPoint(x: 178, y: 110))
        
        // create a new CAKeyframeAnimation that animates the objects position
        let anim = CAKeyframeAnimation(keyPath: "position")
        
        // set the animations path to our bezier curve
        anim.path = path.cgPath
        
        // this rotation mode means that our object will rotate so that it's parallel to whatever point it is currently on the curve
        anim.rotationMode = kCAAnimationRotateAuto
        anim.repeatCount = 1
        anim.duration = 1.0
        
        // we add the animation to the squares 'layer' property
        square.layer.add(anim, forKey: "animate position along path")
    }
}
