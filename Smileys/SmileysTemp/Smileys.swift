//
//  Smileys.swift
//  SmileysTemp
//
//  Created by Sharad Paghadal on 02/12/16.
//  Copyright © 2016 temp. All rights reserved.
//

import UIKit

class Smileys: UIView, UIGestureRecognizerDelegate {
    
    var smileScale: CGFloat = 0.0
    var smileDiameter: CGFloat = 0.0
    var smileness: CGFloat = 0.0
    
    let movePoint :CGFloat = 10
    var currentValue = CGPoint.zero
    
    let MIN_SMILE_SCALE : CGFloat = 0.05
    let MAX_SMILE_SCALE : CGFloat = 5.00
    var midPoint = CGPoint.zero
    func scaleSmileDiameter(scale: CGFloat) {
        self.smileDiameter = self.bounds.size.width / (2)
        if self.bounds.size.width > self.bounds.size.height {
            self.smileDiameter = self.bounds.size.height / (2)
        }
        self.smileDiameter *= scale
    }
    
    func smilenes() -> CGFloat {
        if smileness == 0.0 {
            self.smileness = 1.0
        }
        return smileness
    }
    
    func setsmileScale(newSmileScale: CGFloat) {
        print(newSmileScale)
        if (newSmileScale > MIN_SMILE_SCALE) && (newSmileScale < MAX_SMILE_SCALE) {
            self.smileScale = newSmileScale
        }
        else {
            self.smileScale = 1.0
        }
    }

    func drawCircle(_ context: CGContext, diameter smileDiameter: CGFloat, midpoint midPoint: CGPoint) {
        UIGraphicsPushContext(context)
        context.beginPath()
        context.addArc(center: CGPoint(x: CGFloat(midPoint.x), y: CGFloat(midPoint.y)), radius: CGFloat(smileDiameter / 2), startAngle: CGFloat(0.0), endAngle: CGFloat(2 * M_PI), clockwise: true)
        context.strokePath()
        UIGraphicsPopContext()
    }
    
    

    
    
    override func draw(_ rect: CGRect) {
        
        midPoint.x = (self.bounds.origin.x + self.bounds.size.width / 2) + currentValue.x
        midPoint.y = (self.bounds.origin.y + self.bounds.size.height / 2) + currentValue.y
        let context = UIGraphicsGetCurrentContext()!
//        var midPoint = CGPoint.zero
//        midPoint.x = self.bounds.origin.x + self.bounds.size.width / 2
//        midPoint.y = self.bounds.origin.y + self.bounds.size.height / 2
        
        if self.smileScale < MIN_SMILE_SCALE {
            self.smileScale=1.0
        }
        self.scaleSmileDiameter(scale: smileScale)
        //smileDiameter *=0.75;
        context.setLineWidth(5.0)
        UIColor.brown.setStroke()
        self.drawCircle(context, diameter: self.smileDiameter, midpoint: midPoint)
        
        let EYE_H : CGFloat = 0.17
        let EYE_W : CGFloat = 0.17
        let EYE_DIA : CGFloat = 0.10
        
        var eyePoint = CGPoint.zero
        eyePoint.x = midPoint.x - EYE_W * self.smileDiameter
        eyePoint.y = midPoint.y - EYE_H * self.smileDiameter
        self.drawCircle(context, diameter: self.smileDiameter * EYE_DIA, midpoint: eyePoint)
        eyePoint.x += 2 * EYE_W * self.smileDiameter
        self.drawCircle(context, diameter: self.smileDiameter * EYE_DIA, midpoint: eyePoint)
        
        let MOUTH_H : CGFloat = 0.23
        let MOUTH_W : CGFloat = 0.2
        let MOUTH_DIA : CGFloat = 0.4
        
        var mouthStart = CGPoint.zero
        mouthStart.x = midPoint.x - MOUTH_W * self.smileDiameter
        mouthStart.y = midPoint.y + MOUTH_H * self.smileDiameter
        var mouthEnd = mouthStart
        mouthEnd.x += 2 * MOUTH_W * self.smileDiameter
        
        var mouthLeft = mouthStart
        mouthLeft.x += MOUTH_DIA * MOUTH_W * self.smileDiameter
        mouthLeft.y += MOUTH_DIA * MOUTH_H * self.smileness * self.smileDiameter
        var mouthRight = mouthEnd

        mouthRight.x -= MOUTH_DIA * MOUTH_W * self.smileDiameter
        mouthRight.y += MOUTH_DIA * MOUTH_H * self.smileness * self.smileDiameter
        
        context.beginPath()
        context.move(to: CGPoint(x: CGFloat(mouthStart.x), y: CGFloat(mouthStart.y)))
        context.addCurve(to: CGPoint(x: CGFloat(mouthEnd.x), y: CGFloat(mouthEnd.y)), control1: CGPoint(x: CGFloat(mouthLeft.x), y: CGFloat(mouthLeft.y)), control2: CGPoint(x: CGFloat(mouthRight.x), y: CGFloat(mouthRight.y)))
        context.strokePath()
        UIGraphicsPopContext()
    }
    
    func pinch(_ gesture: UIPinchGestureRecognizer) {
        if (gesture.state == .changed) || (gesture.state == .ended) {
            let gestureScale: CGFloat = gesture.scale
            print("geture scale : \(gestureScale)")
            print("SmileScale : \(smileScale)")
            self.setsmileScale (newSmileScale: (smileScale * gestureScale))
            print(smileScale)
            self.setNeedsDisplay(self.bounds)
            gesture.scale = 1.0
        }
    }
    
    func left(_ gesture: UISwipeGestureRecognizer){
        if (gesture.state == .changed) || (gesture.state == .ended) {
            
            currentValue.x -= movePoint
            //midPoint.y -= 1
            self.setNeedsDisplay(self.bounds)
        }
    }
    
    func right(_ gesture: UISwipeGestureRecognizer){
        if (gesture.state == .changed) || (gesture.state == .ended) {
            currentValue.x += movePoint
            self.setNeedsDisplay(self.bounds)
        }
    }
    
    func up(_ gesture: UISwipeGestureRecognizer){
        if (gesture.state == .changed) || (gesture.state == .ended) {
            
            currentValue.y -= movePoint
            //midPoint.y += 1
            self.setNeedsDisplay(self.bounds)
        }
    }
    
    func down(_ gesture: UISwipeGestureRecognizer){
        
        if (gesture.state == .changed) || (gesture.state == .ended) {
            //midPoint.x -= 1
            currentValue.y += movePoint
            
            self.setNeedsDisplay(self.bounds)
        }
        
    }
    
    func rotate(_ gesture: UIRotationGestureRecognizer){
//        self.transform = self.transform.rotated(by: gesture.rotation)
//        gesture.rotation = 0.0
        
        //let currentTransform : CGAffineTransform = self.layer.affineTransform
        
//        CGAffineTransform currentTransform = self. .affineTransform;
//        squareLayer.affineTransform = CGAffineTransformRotate(currentTransform, gesture.rotation);
        gesture.rotation = 0;
        
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
