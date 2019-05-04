//
//  RoundImage.swift
//  Pilly
//
//  Created by Murtaza on 20/04/2019.
//  Copyright © 2019 Murtaza. All rights reserved.
//

import UIKit

@IBDesignable class RoundImageView: UIImageView {
    private var _round = false
    private var _borderColor = UIColor.clear
    private var _borderWidth: CGFloat = 0
     private var _BackColor = UIColor.clear
    
    @IBInspectable var round: Bool {
        set {
            _round = newValue
            makeRound()
        }
        get {
            return self._round
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        set {
            _borderColor = newValue
            setBorderColor()
        }
        get {
            return self._borderColor
        }
    }
    
    
    @IBInspectable var backColor: UIColor {
        set {
            _BackColor = newValue
            setImageColor()
        }
        get {
            return self._BackColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            _borderWidth = newValue
            setBorderWidth()
        }
        get {
            return self._borderWidth
        }
    }
    
    override internal var frame: CGRect {
        set {
            super.frame = newValue
            makeRound()
        }
        get {
            return super.frame
        }
    }
    
    private func makeRound() {
        if self.round {
            self.clipsToBounds = true
            self.layer.cornerRadius = (self.frame.width + self.frame.height) / 4
        } else {
            self.layer.cornerRadius = 0
        }
    }
    
   private func setImageColor() {
       //let color: UIColor?
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
    self.layer.backgroundColor = _BackColor as! CGColor
    }
    
    private func setBorderColor() {
        self.layer.borderColor = self._borderColor.cgColor
    }
    
    private func setBorderWidth() {
        self.layer.borderWidth = self._borderWidth
    }
}
