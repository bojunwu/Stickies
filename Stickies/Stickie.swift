//
//  Stickie.swift
//  Stickies
//
//  Created by Bojun Wu on 5/30/17.
//  Copyright © 2017 Bojun Wu. All rights reserved.
//

import UIKit

class Stickie: UIView {
    let defaults = UserDefaults.standard
    var lastLocation = CGPoint(x: 0, y: 0)
    var lastLocation_save = CGPoint(x: 0, y: 0)
    var Stickie_bg: UIImageView!
    var text:UITextView!
    var removebtn: UIButton!
    var index: Int!
    var delegate:CombinedDelegate?
    var color: String!
    var font: String!
    var size: CGFloat!

    init(frame: CGRect, texts: String, number: Int, color: String, font: String, size: CGFloat) {
        super.init(frame: frame)
        index = number
        self.font = font
        self.size = size
        self.color = color
        let panRecognizer = UIPanGestureRecognizer(target:self, action:#selector(self.detectPan))
        self.gestureRecognizers = [panRecognizer]
        let image1: UIImage = UIImage(named: "stickie-\(color)")!
        Stickie_bg = UIImageView(image:image1)
        let frame_bg = CGRect(x: 0, y: 0, width: 170, height: 170)
        Stickie_bg.frame = frame_bg
        self.addSubview(Stickie_bg)

        let frame_text = CGRect(x: 5, y: 5, width: 155, height: 160)
        text = UITextView(frame: frame_text)
        text.text = texts
        text.backgroundColor = UIColor.clear
        text.font = UIFont(name: font, size: size)
        self.addSubview(text)
        lastLocation_save = self.frame.origin
        
        let info_button = CGRect(x: 139, y: 130, width: 21 , height: 21)
        let infobtn = UIButton(frame: info_button)
        infobtn.setImage(UIImage(named: "info.png"), for: UIControlState.normal)
        infobtn.addTarget(self, action:#selector(self.info), for: .touchUpInside)
        self.addSubview(infobtn)

        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func detectPan(recognizer:UIPanGestureRecognizer) {
        switch(recognizer.state)
        {
        case .began:
            lastLocation = self.center
        case .changed:
            let translation  = recognizer.translation(in: self.superview)
            self.center = CGPoint(x: lastLocation.x + translation.x, y: lastLocation.y + translation.y)
            self.superview?.bringSubview(toFront: self)
        case .ended:
             self.superview?.bringSubview(toFront: self)
            lastLocation = self.center
            lastLocation_save = self.frame.origin
        default:
            print("will not handel")
        }    }
    
    func removebutton()
    {
        let remove_button = CGRect(x: 142, y: -11, width: 30 , height: 30)
        removebtn = UIButton(frame: remove_button)
        removebtn.setImage(UIImage(named: "remove.png"), for: UIControlState.normal)
        removebtn.addTarget(self, action:#selector(self.remove), for: .touchUpInside)
        self.addSubview(removebtn)
    }
    func cancel_remove()
    {
        removebtn.removeFromSuperview()
    }

    
    func remove(){
        print("removecalling")
        self.removeFromSuperview()
        var count = defaults.integer(forKey: defaultsKeys.count_temp)
        if count >= 1
        {
            count -= 1
            defaults.setValue(count, forKey: defaultsKeys.count_temp)
        }
        delegate?.array_remove(index: index)
        }
    
    func info()
    {
        print("infocalling")
        self.removeFromSuperview()
        delegate?.info(index: index)


    }
    
}
