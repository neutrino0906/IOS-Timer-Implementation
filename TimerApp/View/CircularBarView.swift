//
//  CircularBarView.swift
//  TimerApp
//
//  Created by Ground 2 on 15/03/24.
//

import UIKit

class CircularBarView: UIView {
    
    var circleLayer = CAShapeLayer()
    var progressLayer = CAShapeLayer()
    var startPoint = CGFloat(-Double.pi / 2)
    var endPoint = CGFloat(3 * Double.pi / 2)
    
    func createCircularPath(_ progress: Float) {
            let circularPath = UIBezierPath(arcCenter: CGPoint(x: CGFloat(0), y: CGFloat(0)), radius: 80, startAngle: startPoint, endAngle: endPoint, clockwise: true)
            circleLayer.path = circularPath.cgPath
            circleLayer.fillColor = UIColor.clear.cgColor
            circleLayer.lineCap = .round
            circleLayer.lineWidth = 20.0
            circleLayer.strokeEnd = 1
            circleLayer.strokeColor = UIColor.white.cgColor
            layer.addSublayer(circleLayer)
            progressLayer.path = circularPath.cgPath
            progressLayer.fillColor = UIColor.clear.cgColor
            progressLayer.lineCap = .round
            progressLayer.lineWidth = 10.0
            progressLayer.strokeEnd = CGFloat(progress)
        progressLayer.strokeColor = UIColor(named: "progressColor")?.cgColor
            layer.addSublayer(progressLayer)
        }

}
