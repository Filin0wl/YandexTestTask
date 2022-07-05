//
//  GameControlView.swift
//  YandexTestTask
//
//  Created by Anastasia Perminova on 05.07.2022.
//

import UIKit

@IBDesignable
class GameControlView: UIView {
    
    private func loadViewFromXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "GameControlView", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first! as! UIView
    }
}
