//
//  CircularImageView.swift
//  Github Browser
//
//  Created by Mac Bellingrath on 1/22/16.
//  Copyright © 2016 Mac Bellingrath. All rights reserved.
//

import UIKit


@IBDesignable class CircularImageView: UIImageView {
    private var _round = false
    
    
 
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        round = true
    }
    @IBInspectable var round: Bool {
        set {
            _round = newValue
            makeRound()
        }
        get {
            return self._round
        }
    }
    override internal var frame: CGRect {
        set {
            round = true
            super.frame = newValue
            makeRound()
        }
        get {
            return super.frame
        }
        
    }
   
    
    func makeRound() {
        if self.round == true {
            self.layer.cornerRadius = (frame.width + frame.height ) / 4
       
            self.layer.masksToBounds = true
        } else {
            self.layer.cornerRadius = 0
        }
    }
}