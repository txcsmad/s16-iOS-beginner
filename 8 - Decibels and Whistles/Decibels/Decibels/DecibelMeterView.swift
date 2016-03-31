//
//  DecibelMeterView.swift
//  Decibels
//
//  Created by Jesse Tipton on 3/30/16.
//  Copyright © 2016 MAD. All rights reserved.
//

import UIKit

protocol DecibelMeterViewDataSource {
    
    func currentValueForDecibelMeterView(meterView: DecibelMeterView) -> Float
    
}

@IBDesignable class DecibelMeterView: UIView {

    @IBInspectable var meterBackgroundColor: UIColor = .blackColor()
    @IBInspectable var indicatorColor: UIColor = .redColor()
    
    var delegate: DecibelMeterViewDataSource?
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        let context = UIGraphicsGetCurrentContext()
        // Draw circle
        CGContextSetFillColorWithColor(context, meterBackgroundColor.CGColor)
        CGContextFillEllipseInRect(context, rect)
        
        // Draw dial
        CGContextSetStrokeColorWithColor(context, indicatorColor.CGColor)
        CGContextSetLineWidth(context, 2)
        CGContextMoveToPoint(context, bounds.size.width / 2, bounds.size.height / 2)
        
        guard let delegate = delegate else { return }
        let currentValue = delegate.currentValueForDecibelMeterView(self)
        let theta = Double(currentValue / 160.0) * M_PI
        let radius = Double(bounds.size.width / 2)
        let x = radius * cos(theta) + radius
        let y = radius * sin(theta) + radius
        
        CGContextAddLineToPoint(context, CGFloat(x), CGFloat(y))
        CGContextStrokePath(context)
    }
    
}
