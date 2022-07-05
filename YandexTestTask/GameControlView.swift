//
//  GameControlView.swift
//  YandexTestTask
//
//  Created by Anastasia Perminova on 05.07.2022.
//

import UIKit

@IBDesignable
class GameControlView: UIView {
    
    //MARK: Outlets
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var actionButton: UIButton!
    
    //MARK: Inspectable variableis
    @IBInspectable var gameTimeLeft: Double = 7 {
        didSet {
            updateTimeLabel()
        }
    }
    @IBInspectable var isGameActive: Bool = false {
        didSet {
            updateTimeLabel()
            updateButtonLabel()
        }
    }
    @IBInspectable var gameDuration: Double {
        get {
            return stepper.value
        }
        set {
            stepper.value = newValue
            updateTimeLabel()
        }
    }
    
    //MARK: Variables
    var startStopHandler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupVIews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupVIews()
    }
    
    private func setupVIews() {
        let xibView = loadViewFromXib()
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(xibView)
    }
    
    private func loadViewFromXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "GameControlView", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first! as! UIView
    }
    
    
    private func updateTimeLabel() {
        stepper.isEnabled = !isGameActive
        if isGameActive {
            timeLabel.text = "Осталось: \(Int(gameTimeLeft)) сек"
            
        } else {
            timeLabel.text = "Время: \(Int(stepper.value)) сек"
        }
    }
    
    private func updateButtonLabel(){
        if isGameActive {
            actionButton.setTitle("Остановить", for: .normal)
        } else {
            actionButton.setTitle("Начать", for: .normal)
        }
    }
    
    //MARK: Actions
    @IBAction func stepperChanged(_ sender: UIStepper) {
        updateTimeLabel()
    }
    
    @IBAction func actionButtonTapped(_ sender: UIButton) {
        startStopHandler?()
    }
    
}
