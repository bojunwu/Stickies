//
//  Data.swift
//  Stickies
//
//  Created by Bojun Wu on 6/1/17.
//  Copyright © 2017 Bojun Wu. All rights reserved.
//
import Foundation
import UIKit
class Data_save: NSObject, NSCoding {
//    var id: Int
    var x: CGFloat
    var y: CGFloat
    var text: String
    var color: String
    var font: String
    var size: CGFloat
    
    
    init(text: String, x: CGFloat, y: CGFloat, color: String, font:String, size: CGFloat) {
//        self.id = id
        self.x = x
        self.y = y
        self.text = text
        self.color = color
        self.font = font
        self.size = size
        
    }
    
    required convenience init(coder aDecoder: NSCoder) {
//        let id = aDecoder.decodeInteger(forKey: "id")
        let text = aDecoder.decodeObject(forKey: "text") as! String
        let x = aDecoder.decodeObject(forKey: "x") as! CGFloat
        let y = aDecoder.decodeObject(forKey: "y") as! CGFloat
        let color = aDecoder.decodeObject(forKey: "color") as! String
        let font = aDecoder.decodeObject(forKey: "font") as! String
        let size = aDecoder.decodeObject(forKey: "size") as! CGFloat

        self.init(text: text, x: x, y :y, color: color, font: font, size: size)
    }
    
    func encode(with aCoder: NSCoder) {
//        aCoder.encode(id, forKey: "id")
        aCoder.encode(text, forKey: "text")
        aCoder.encode(x, forKey: "x")
        aCoder.encode(y, forKey: "y")
        aCoder.encode(color, forKey: "color")
        aCoder.encode(font, forKey: "font")
        aCoder.encode(size, forKey: "size")

    }
}
