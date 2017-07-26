//
//  BGSettingViewController.swift
//  Stickies
//
//  Created by Bojun Wu on 6/6/17.
//  Copyright © 2017 Bojun Wu. All rights reserved.
//

import UIKit
class BGSettingViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    var bg: UIImageView!
     let defaults = UserDefaults.standard
     let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self

        bg = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height ))
        let bg_image = defaults.string(forKey: defaultsKeys.bg)
        if bg_image != "custom"
        {
            bg.image = UIImage(named: bg_image!)
        }
        else{
            let data = defaults.object(forKey: defaultsKeys.image) as! NSData
            bg.image = UIImage(data: data as Data)
        }
        bg.contentMode = UIViewContentMode.scaleToFill
        self.view.addSubview(bg)

        let FrameTitle = CGRect(x: (self.view.bounds.width/2 - 110), y: 10, width: 220, height: 60)
        let title = UITextView(frame: FrameTitle)
         title.text = "Choose Background"
         title.backgroundColor = UIColor.clear
         title.font = .systemFont(ofSize:22)
         title.isEditable = false
         self.view.addSubview(title)

        let Frame = CGRect(x: 15, y: 20, width: 30, height: 30)
        let backbutton = UIButton(frame: Frame)
        backbutton.setImage(UIImage(named: "back"), for: UIControlState.normal)
        backbutton.addTarget(self, action:#selector(dismissview), for: .touchUpInside)
        self.view.addSubview(backbutton)
        
        
        let Frame1 = CGRect(x: 15, y: 50, width:  self.view.bounds.width/3.3, height: self.view.bounds.height/3.3)
        let bgbtn1 = UIButton(frame: Frame1)
        bgbtn1.setImage(UIImage(named: "bg1"), for: UIControlState.normal)
        bgbtn1.addTarget(self, action:#selector(bg1), for: .touchUpInside)
        self.view.addSubview(bgbtn1)
        
        let Frame2 = CGRect(x: 15 + self.view.bounds.width/3.3, y: 50, width:  self.view.bounds.width/3.3, height: self.view.bounds.height/3.3)
        let bgbtn2 = UIButton(frame: Frame2)
        bgbtn2.setImage(UIImage(named: "bg2"), for: UIControlState.normal)
        bgbtn2.addTarget(self, action:#selector(bg2), for: .touchUpInside)
        self.view.addSubview(bgbtn2)
        
        let Frame3 = CGRect(x: 15 + self.view.bounds.width/3.3 * 2, y: 50, width: self.view.bounds.width/3.3, height: self.view.bounds.height/3.3)
        let bgbtn3 = UIButton(frame: Frame3)
        bgbtn3.setImage(UIImage(named: "bg3"), for: UIControlState.normal)
        bgbtn3.addTarget(self, action:#selector(bg3), for: .touchUpInside)
        self.view.addSubview(bgbtn3)
        
        let Frame4 = CGRect(x: 15, y: 55+self.view.bounds.height/3.3, width: self.view.bounds.width/3.3, height: self.view.bounds.height/3.3)
        let bgbtn4 = UIButton(frame: Frame4)
        bgbtn4.setImage(UIImage(named: "bg4"), for: UIControlState.normal)
        bgbtn4.addTarget(self, action:#selector(bg4), for: .touchUpInside)
        self.view.addSubview(bgbtn4)
        
        let Frame5 = CGRect(x: 15 + self.view.bounds.width/3.3, y: 55+self.view.bounds.height/3.3, width:  self.view.bounds.width/3.3, height: self.view.bounds.height/3.3)
        let bgbtn5 = UIButton(frame: Frame5)
        bgbtn5.setTitle("Click here to use your own background image!",for: .normal)
        bgbtn5.titleLabel!.font =  UIFont(name: "Helvetica", size: 20)
        bgbtn5.titleLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping
        bgbtn5.titleLabel!.textAlignment = .center
        bgbtn5.addTarget(self, action:#selector(loadimage), for: .touchUpInside)
        self.view.addSubview(bgbtn5)
        
        let Frame6 = CGRect(x: 15 + self.view.bounds.width/3.3 * 2, y: 55+self.view.bounds.height/3.3, width:  self.view.bounds.width/3.3, height: self.view.bounds.height/3.3)
        let bgbtn6 = UIButton(frame: Frame6)
        bgbtn6.setImage(UIImage(named: "bg5"), for: UIControlState.normal)
        bgbtn6.addTarget(self, action:#selector(bg5), for: .touchUpInside)
        self.view.addSubview(bgbtn6)
        
        let Frame7 = CGRect(x: 15 , y: 60+self.view.bounds.height/3.3*2, width:  self.view.bounds.width/3.3, height: self.view.bounds.height/3.3)
        let bgbtn7 = UIButton(frame: Frame7)
        bgbtn7.setImage(UIImage(named: "bg7"), for: UIControlState.normal)
        bgbtn7.addTarget(self, action:#selector(bg7), for: .touchUpInside)
        self.view.addSubview(bgbtn7)
        
        let Frame8 = CGRect(x: 15 + self.view.bounds.width/3.3 , y: 60+self.view.bounds.height/3.3*2, width:  self.view.bounds.width/3.3, height: self.view.bounds.height/3.3)
        let bgbtn8 = UIButton(frame: Frame8)
        bgbtn8.setImage(UIImage(named: "bg8"), for: UIControlState.normal)
        bgbtn8.addTarget(self, action:#selector(bg8), for: .touchUpInside)
        self.view.addSubview(bgbtn8)
        
        let Frame9 = CGRect(x: 15 + self.view.bounds.width/3.3 * 2, y: 60+self.view.bounds.height/3.3*2, width:  self.view.bounds.width/3.3, height: self.view.bounds.height/3.3)
        let bgbtn9 = UIButton(frame: Frame9)
        bgbtn9.setImage(UIImage(named: "background"), for: UIControlState.normal)
        bgbtn9.addTarget(self, action:#selector(bg6), for: .touchUpInside)
        self.view.addSubview(bgbtn9)
    
        
        
    }
    func dismissview()
    {
        self.dismiss(animated: true, completion: nil);
    }
    func bg1()
    {
        bg.image = UIImage(named: "bg1")
        defaults.setValue("bg1", forKey: defaultsKeys.bg)
    }
    func bg2()
    {
        bg.image = UIImage(named: "bg2")
        defaults.setValue("bg2", forKey: defaultsKeys.bg)
    }
    func bg3()
    {
        bg.image = UIImage(named: "bg3")
        defaults.setValue("bg3", forKey: defaultsKeys.bg)
    }
    func bg4()
    {
        bg.image = UIImage(named: "bg4")
        defaults.setValue("bg4", forKey: defaultsKeys.bg)
    }
    func bg5()
    {
        bg.image = UIImage(named: "bg5")
        defaults.setValue("bg5", forKey: defaultsKeys.bg)
    }
    func bg6()
    {
        bg.image = UIImage(named: "background")
        defaults.setValue("background", forKey: defaultsKeys.bg)
    }
    func bg7()
    {
        bg.image = UIImage(named: "bg7")
        defaults.setValue("bg7", forKey: defaultsKeys.bg)
    }
    func bg8()
    {
        bg.image = UIImage(named: "bg8")
        defaults.setValue("bg8", forKey: defaultsKeys.bg)
    }
    func loadimage()
    {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }

     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            print("picking")
                        bg.contentMode = .scaleAspectFit
                        bg.image = image
            let imageData: NSData = UIImagePNGRepresentation(image)! as NSData
            defaults.setValue(imageData, forKey: defaultsKeys.image)
            defaults.setValue("custom", forKey: defaultsKeys.bg)
            
        } else{
            print("Something went wrong")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    

}
