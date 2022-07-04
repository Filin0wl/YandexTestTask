//
//  GameFieldView.swift
//  YandexTestTask
//
//  Created by Anastasia Perminova on 04.07.2022.
//

import UIKit

@IBDesignable
class GameFieldView: UIView {
    
    // MARK: Variable
    @IBInspectable var shapeColor: UIColor = .blue
    @IBInspectable var shapePosition: CGPoint = .zero
    @IBInspectable var shapeSize: CGSize = CGSize(width: 40, height: 40)
    @IBInspectable var isShapeHidden: Bool = false
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard !isShapeHidden else { return }
        shapeColor.setFill() // заливка цветом
        let path = getTrianglePath(in: CGRect(origin: shapePosition, size: shapeSize))
        path.fill()
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
