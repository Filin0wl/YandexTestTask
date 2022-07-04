//
//  GameFieldView.swift
//  YandexTestTask
//
//  Created by Anastasia Perminova on 04.07.2022.
//

import UIKit

@IBDesignable
class GameFieldView: UIView {
    
    // MARK: Inspectable variable
    @IBInspectable var shapeColor: UIColor = .blue
    @IBInspectable var shapePosition: CGPoint = .zero
    @IBInspectable var shapeSize: CGSize = CGSize(width: 40, height: 40)
    @IBInspectable var isShapeHidden: Bool = false
    
    //MARK: Variable
    private var curPath: UIBezierPath?
    
    //MARK: Poperties
    var shapeHitHandler: (() -> Void)?
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard !isShapeHidden else {
            curPath = nil
            return
        }
        shapeColor.setFill() // заливка цветом
        let path = getTrianglePath(in: CGRect(origin: shapePosition, size: shapeSize))
        path.fill()
        curPath = path
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard let curPath = curPath else { return }

        let hit = touches.contains(where: {touch -> Bool in
            let touchPoint = touch.location(in: self)
            return curPath.contains(touchPoint)
        })
        if hit {
            shapeHitHandler?()
        }
    }
    
    private func getTrianglePath(in rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.close()
        path.stroke()
        path.fill()
        return path
    }
    
    func randomizeShapePosition() {
        let maxX = bounds.maxX - shapeSize.width
        let maxY = bounds.maxY - shapeSize.height
        let x = CGFloat(arc4random_uniform(UInt32(maxX)))
        let y = CGFloat(arc4random_uniform(UInt32(maxY)))
        shapePosition = CGPoint(x: x, y: y)
    }
}
