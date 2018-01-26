//
//  AwesomeProgressView.swift
//  Demo01
//
//  Created by Cognition on 26/12/17.
//  Copyright © 2017 Cognition. All rights reserved.
//

import UIKit

@IBDesignable class AwesomeProgressView: UIView {
    open static let progressBackgroundLineWidth = 7.0
    open static let progressCircleLineWidth = 3.0
    open static let startAngleOfTheTrack = -90.0
    open static let endAngleOfTheTrack = 270.0
    private func degreeToRadian(degree:Float)->Float {
        return ((degree * Float.pi) / 180)
    }
    @IBInspectable public var progress:Double = 0.0 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    private var progressCircleLineSeparator:Float {
        get {
            return Float((AwesomeProgressView.progressBackgroundLineWidth - AwesomeProgressView.progressCircleLineWidth)/2)
        }
    }
    @IBInspectable var backgroundTrackColor:UIColor = UIColor.init(white: 0.1, alpha: 0.8)
    @IBInspectable var progressTrackColor : UIColor = UIColor.init(white: 0.8, alpha: 1.0)
    
    override func draw(_ rect: CGRect) {
        self.drawOuterCircle()
        self.drawInnerCircle()
    }
    
    override var intrinsicContentSize: CGSize
    {
        return CGSize(width:120,height:120)
    }
    
    private func drawInnerCircle(){
        let frame = self.bounds
        let track = UIBezierPath()
        track.lineWidth = CGFloat(AwesomeProgressView.progressCircleLineWidth)
        track.lineCapStyle = .round
        
        let center = CGPoint(x: frame.midX, y: frame.midY)
        let radius = Float(frame.size.width/2) - Float(self.progressCircleLineSeparator) - Float(AwesomeProgressView.progressCircleLineWidth/2)
        
        let endAngle = (Double.pi * ( self.progress - 25)) / 50;
        
        track.addArc(withCenter: center, radius: CGFloat(radius), startAngle: CGFloat(self.degreeToRadian(degree: Float(AwesomeProgressView.startAngleOfTheTrack))), endAngle: CGFloat(endAngle), clockwise: true)
        
        self.progressTrackColor.set()
        track.stroke()
    }
    
    private func drawOuterCircle(){
        let frame = self.bounds
        let track = UIBezierPath()
        track.lineWidth = CGFloat(AwesomeProgressView.progressBackgroundLineWidth)
        track.lineCapStyle = .butt
        let center = CGPoint(x: frame.midX, y: frame.midY)
        let radius = (Float(frame.size.width) - Float(AwesomeProgressView.progressBackgroundLineWidth))/2
        track.addArc(withCenter: center, radius: CGFloat(radius), startAngle: CGFloat(self.degreeToRadian(degree: Float(AwesomeProgressView.startAngleOfTheTrack))), endAngle: CGFloat(self.degreeToRadian(degree: Float(AwesomeProgressView.endAngleOfTheTrack))), clockwise: true)
        
        self.backgroundTrackColor.set()
        track.stroke()
    }
    
}
