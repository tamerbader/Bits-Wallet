//
//  DrawingController.swift
//  Bits
//
//  Created by MetroStar on 12/27/17.
//  Copyright © 2017 TamerBader. All rights reserved.
//

import UIKit

class DrawingController: UIViewController {
    
    var lastPoint:CGPoint = CGPoint.zero
    var points:[CGPoint] = [CGPoint]()
    var swiped = false
    var renderer1: UIGraphicsImageRenderer? = nil
    
    var MAX_POINTS_COUNT:Int = 50
    private var privateKey:String = ""
    
    @IBOutlet weak var image: UIImageView!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = false
        if (privateKey.count < MAX_POINTS_COUNT) {
            if let touch:UITouch = touches.first {
                lastPoint = touch.location(in: self.view)
                addPointToKey(point: lastPoint)
                if (privateKey.count == MAX_POINTS_COUNT) {
                    beginKeyGeneration()
                }
            }
        } else {
            beginKeyGeneration()
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = true
        if (privateKey.count < MAX_POINTS_COUNT) {
            if let touch:UITouch = touches.first {
                let currentPoint = touch.location(in: self.view)
                drawLine(from: lastPoint, to: currentPoint)
                lastPoint = currentPoint
                addPointToKey(point: currentPoint)
                if (privateKey.count == MAX_POINTS_COUNT) {
                    beginKeyGeneration()
                }
            }
        } else {
            beginKeyGeneration()
        }
        
        
    }
    
    func addPointToKey(point:CGPoint) {
        let randNum:Int = random(from: 1 ... 10)
        if (Int(point.x) % randNum == 0) {
            if (Int(point.x + point.y) % 2 == 0) {
                privateKey += "\(Int(point.x))"
            } else {
                privateKey += "\(Int(point.y))"
            }
            
        }
    }
    
    func drawLine(from:CGPoint, to: CGPoint) {
        UIGraphicsBeginImageContext(self.view.frame.size)
        image.image?.draw(in: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        let context = UIGraphicsGetCurrentContext()
        
        context?.move(to: CGPoint(x: from.x, y: from.y))
        context?.addLine(to: CGPoint(x: to.x, y: to.y))
        
        context?.setBlendMode(CGBlendMode.normal)
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(5)
        
        context?.strokePath()
        
        image.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    func pointsToPublicKey(points:[CGPoint]) -> String {
        var publicKey:String = ""
        for i in 0...MAX_POINTS_COUNT - 1 {
            if (i % 2 == 0) {
                publicKey += "\(Int(points[i].x))"
            } else {
                publicKey += "\(Int(points[i].y))"

            }
        }
        
        return publicKey
    }
    
    func beginKeyGeneration() {
        print("Private Key: \(privateKey)")
    }
    
    func random(from range: ClosedRange<Int>) -> Int {
        let lowerBound = range.lowerBound
        let upperBound = range.upperBound
        
        return lowerBound + Int(arc4random_uniform(UInt32(upperBound - lowerBound)))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MAX_POINTS_COUNT = random(from: 50 ... 76)
        renderer1 = UIGraphicsImageRenderer(size: CGSize(width: self.view.frame.width, height: self.view.frame.height))
        image.backgroundColor = UIColor.clear
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
