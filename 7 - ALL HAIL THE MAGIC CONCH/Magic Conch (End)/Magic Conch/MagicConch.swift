//
//  MagicConch.swift
//  Magic Conch
//
//  Created by Jesse Tipton on 3/22/16.
//  Copyright © 2016 MAD. All rights reserved.
//

import UIKit

enum MagicConchResponse: String {
    
    case IDontThinkSo = "I don't think so."
    case MaybeSomeday = "Maybe someday."
    case Neither = "Neither."
    case No = "No."
    case Nothing = "Nothing."
    case TryAskingAgain = "Try asking again."
    case Yes = "Yes."
    
    static let allResponses: [MagicConchResponse] = [.IDontThinkSo, .MaybeSomeday, .Neither, .No, .Nothing, .TryAskingAgain, .Yes]
    
    static func randomResponse() -> MagicConchResponse {
        let randomIndex = Int(arc4random_uniform(UInt32(allResponses.count)))
        return allResponses[randomIndex]
    }
    
}

class CircleView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderColor = UIColor.whiteColor().CGColor
        layer.borderWidth = 4
        layer.cornerRadius = frame.height / 2
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class ConchImageView: UIImageView {
    
    var start: CGPoint {
        return CGPointApplyAffineTransform(center, CGAffineTransformMakeTranslation(100, -50))
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let circleView = subviews.first as! CircleView
        
        CGContextSetRGBStrokeColor(context, 1, 1, 1, 1)
        CGContextSetLineWidth(context, 2)
        CGContextMoveToPoint(context, start.x, start.y)
        CGContextAddLineToPoint(context, circleView.center.x, circleView.center.y)
        CGContextStrokePath(context)
    }
    
}
