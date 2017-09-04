//
//  newFace.swift
//  SmilesTemp
//
//  Copyright © 2016 temp. All rights reserved.
//

import UIKit

class newFace: UIView {

    var scale: CGFloat
    
    override init(frame: CGRect) {
        self.scale = 1.0
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.scale = 1.0
        super.init(coder: aDecoder)
    }
    
    func drawCircleAtPoint(center: CGPoint, radius: CGFloat, inContext: CGContext) {
        UIGraphicsPushContext(inContext)
        inContext.beginPath()
        inContext.addArc(center: CGPoint(x: center.x,y: center.y), radius: radius, startAngle: CGFloat(0), endAngle: CGFloat(M_PI*2), clockwise: true)
        //CGContextAddArc(inContext, center.x, center.y, radius, 0, CGFloat(M_PI*2), 0)
        inContext.strokePath()
        UIGraphicsPopContext()
    }
    
    override func draw(_ dirtyRect: CGRect) {
        super.draw(dirtyRect)
        
        // Drawing code here.
        let context = UIGraphicsGetCurrentContext()
        let midX = self.bounds.origin.x + self.bounds.width/2
        let midY = self.bounds.origin.y + self.bounds.height/2
        let midPoint = CGPoint(x: midX,y: midY)
        
        let bBoxWidth = self.bounds.width
        let bBoxHeight = self.bounds.height
        var smileSize = min(bBoxWidth, bBoxHeight) / 2
        smileSize *= scale
        
        context!.setLineWidth(5.0)
        UIColor.blue.setStroke()
        
        self.drawCircleAtPoint(center: midPoint, radius: smileSize/2, inContext: context!)
        
        let EYE_H = CGFloat(0.35)
        let EYE_W = CGFloat(0.35)
        let EYE_RADIUS = CGFloat(5.0)
        
        let eyePoint1 = CGPoint(x:midPoint.x - smileSize * EYE_W,y: midPoint.y - smileSize * EYE_H)
        self.drawCircleAtPoint(center: eyePoint1, radius: EYE_RADIUS, inContext: context!)
        
        let eyePoint2 = CGPoint(x:midPoint.x + smileSize * EYE_W,y: midPoint.y - smileSize * EYE_H)
        self.drawCircleAtPoint(center: eyePoint2, radius: EYE_RADIUS, inContext: context!)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
