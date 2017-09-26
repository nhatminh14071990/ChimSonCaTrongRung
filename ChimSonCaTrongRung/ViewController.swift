//
//  ViewController.swift
//  ChimSonCaTrongRung
//
//  Created by Van Ho Si on 9/26/17.
//  Copyright © 2017 Van Ho Si. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var bird = UIImageView()
    var audioPlayer: AVAudioPlayer?
    var birdWidth: CGFloat = 0.0
    var birdHeight: CGFloat = 0.0
    let duration: TimeInterval = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.drawJungle()
        self.addBird()
        fly2()
        playSong()
    }
    
    func drawJungle() {

        let background = UIImageView(image: UIImage(named: "jungle.jpg"))
        background.frame = self.view.bounds
        background.contentMode = .scaleAspectFill
        self.view.addSubview(background)
    }
    
    func addBird() {
        bird = UIImageView(frame: CGRect(x: 0, y: 0, width: 110, height: 68))
        bird.animationImages = [
            UIImage(named: "bird0.png")!,
            UIImage(named: "bird1.png")!,
            UIImage(named: "bird2.png")!,
            UIImage(named: "bird3.png")!,
            UIImage(named: "bird4.png")!,
            UIImage(named: "bird5.png")!
        ]
        
        bird.animationDuration = 1
        bird.animationRepeatCount = 0
        bird.startAnimating()
        self.view.addSubview(bird)
        
    }
    
    //vi du tren lop
    func fly(){
        UIView.animate(withDuration: 2, animations: {
            self.bird.center = CGPoint(x: self.view.bounds.size.width - self.bird.frame.size.width * 0.5, y: self.view.bounds.size.height - self.bird.frame.size.height * 0.5)
        }) { (finished) in
            UIView.animate(withDuration: 2, animations: {
                self.bird.center = CGPoint(x: 0 + self.bird.frame.size.width * 0.5, y: 0 + self.bird.frame.size.height * 0.5)
            }) { (finished) in
                self.fly()
            }
            
        }
    }
    
    //bai tap ve nha
    func birdMove(duration: TimeInterval, positionX: CGFloat, positionY: CGFloat, scaleX: CGFloat, scaleY: CGFloat, rotation: CGFloat, callback: @escaping ()->()){
        
        self.bird.transform = CGAffineTransform.init(scaleX: scaleX, y: scaleY).concatenating(CGAffineTransform.init(rotationAngle: ((rotation * 3.14) / 180)))
        
        UIImageView.animate(withDuration: duration, animations: {
            
            self.bird.center = CGPoint(x: positionX, y: positionY)
            
        }) {(finished) in
            callback()
        }
    }
    
    func fly2(){
        birdWidth = self.bird.frame.size.width
        birdHeight = self.bird.frame.size.height
        
        self.birdMove(duration: self.duration, positionX: self.view.bounds.size.width - self.birdWidth * 0.5, positionY: self.view.bounds.size.height - self.birdHeight * 0.5, scaleX: 1, scaleY: 1, rotation: 45) { () in
            
            self.birdMove(duration: self.duration, positionX: 0 + self.birdWidth * 0.5, positionY: self.view.bounds.size.height - self.birdHeight * 0.5, scaleX: -1, scaleY: 1, rotation: 10) { () in
                
                self.birdMove(duration: self.duration, positionX: self.view.bounds.size.width - self.birdWidth * 0.5, positionY: 0 + self.birdHeight * 0.5, scaleX: 1, scaleY: 1, rotation: -45) { () in
                    
                    self.birdMove(duration: self.duration, positionX: 0 + self.birdWidth * 0.5, positionY: 0 + self.birdHeight * 0.5, scaleX: -1, scaleY: 1, rotation: 10) { () in
                        self.fly2()
                    }
                    
                }
                
            }
            
        }
        
//        UIImageView.animate(withDuration: self.duration, animations: {
//            self.bird.center = CGPoint(x: self.view.bounds.size.width - self.birdWidth * 0.5, y: self.view.bounds.size.height - self.birdHeight * 0.5)
//        }) {(finished) in
//            self.bird.transform = CGAffineTransform.init(scaleX: -1, y: 1).concatenating(CGAffineTransform.init(rotationAngle: ((10 * 3.14) / 180)))
//
//            UIImageView.animate(withDuration: self.duration, animations: {
//                self.bird.center = CGPoint(x: 0 + self.birdWidth * 0.5, y: self.view.bounds.size.height - self.birdHeight * 0.5)
//            }) {(finished) in
//                self.bird.transform = CGAffineTransform.init(scaleX: 1, y: 1).concatenating(CGAffineTransform.init(rotationAngle: ((-45 * 3.14) / 180)))
//
//                UIImageView.animate(withDuration: self.duration, animations: {
//                    self.bird.center = CGPoint(x: self.view.bounds.size.width - self.birdWidth * 0.5, y: 0 + self.birdHeight * 0.5)
//
//
//                }) {(finished) in
//                    self.bird.transform = CGAffineTransform.init(scaleX: -1, y: 1).concatenating(CGAffineTransform.init(rotationAngle: ((10 * 3.14) / 180)))
//
//                    self.birdMove(duration: self.duration, positionX: 0 + self.birdWidth * 0.5, positionY: 0 + self.birdHeight * 0.5) { () in
//                        self.fly2()
//                    }
//                }
//
//            }
//
//        }
    }
    
    func playSong(){
        let filePath = Bundle.main.path(forResource: "chao-mao-mai-hot.mp3", ofType: nil)!
        let url = URL(fileURLWithPath: filePath)
        audioPlayer = try! AVAudioPlayer(contentsOf: url)
        audioPlayer?.numberOfLoops = -1
        audioPlayer?.prepareToPlay()
        audioPlayer?.play()
    }
    
}

