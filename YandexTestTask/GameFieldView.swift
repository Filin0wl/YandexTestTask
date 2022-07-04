//
//  GameFieldView.swift
//  YandexTestTask
//
//  Created by Anastasia Perminova on 04.07.2022.
//

import UIKit

class GameFieldView: UIView {
    
    // MARK: Variable
    var shapeColor: UIColor = .red
    var shapePosotion: CGPoint = .zero
    var shapeSize: CGSize = CGSize(width: 40, height: 40)
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        shapeColor.setFill() // заливка цветом
        
        
    }
    
    private func getTrianglePath(in rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 100))
        path.addLine(to: CGPoint(x: 100, y: 100))
        path.addLine(to: CGPoint(x: 50, y: 0))
        path.close()
        path.stroke()
        path.fill()
        return path
    }
}
