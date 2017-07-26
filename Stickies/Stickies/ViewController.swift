//
//  ViewController.swift
//  Stickies
//
//  Created by Bojun Wu on 5/29/17.
//  Copyright © 2017 Bojun Wu. All rights reserved.
//

import UIKit
protocol SampleProtocol
{
    func array_remove(index: Int)
}
protocol infoProtocol
{
    func info(index: Int)
}
protocol CombinedDelegate: SampleProtocol, infoProtocol {

}

class ViewController: UIViewController, CombinedDelegate{
       let defaults = UserDefaults.standard
       var stickies: [Stickie] = []
       var removing = false
       var backgroundView1: UIView!
       var stickieView_info: UIImageView!
       var text_view_info : UITextView!
       var bg: UIImageView!
    var info_index: Int!
       var bluebtn: UIButton!
       var yellowbtn: UIButton!
       var pinkbtn: UIButton!
       var violetbtn: UIButton!
       var tealbtn: UIButton!
       var redbtn: UIButton!
       var greenbtn: UIButton!
       var savebtn: UIButton!
       var font1btn: UIButton!
       var font2btn: UIButton!
       var font3btn: UIButton!
       var font4btn: UIButton!
       var font5btn: UIButton!
       var font_slider: UISlider!
       var font_size : UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bg = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height ))
        bg.image = UIImage(named: "bg2")
        bg.contentMode = UIViewContentMode.scaleToFill
        self.view.addSubview(bg)
        let count = defaults.integer(forKey: defaultsKeys.count)
        defaults.setValue(count, forKey: defaultsKeys.count_temp)
        let decoded  = defaults.object(forKey: "text") as! Data
        let decodedData = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [Data_save]
        if count>0{
        for i in 1...count
        {
            var text = ""
            text = decodedData[i-1].text
                let sticker = Stickie(frame: CGRect(x: decodedData[i-1].x, y: decodedData[i-1].y, width: 170, height: 170), texts:text, number: i,  color: decodedData[i-1].color, font: decodedData[i-1].font, size: decodedData[i-1].size)
            print(decodedData[i-1].x)
            print(decodedData[i-1].y)
                sticker.delegate = self
                self.view.addSubview(sticker)
                self.stickies.append(sticker)
        }
        }
        
        
        // add notification observer for app termination. When app terminates, save the text data
        NotificationCenter.default.addObserver(self, selector:#selector(ViewController.save), name:NSNotification.Name.UIApplicationWillTerminate, object:nil)
        
        NotificationCenter.default.addObserver(self, selector:#selector(ViewController.save), name: Notification.Name.UIApplicationWillResignActive, object: nil)
        
        let frame_plus = CGRect(x: 10, y: self.view.bounds.height - 50, width: 40 , height: 40)
        let plusbutton = UIButton(frame: frame_plus)
        plusbutton.setImage(UIImage(named: "plus.png"), for: UIControlState.normal)
        plusbutton.addTarget(self, action:#selector(self.add), for: .touchUpInside)
        self.view.addSubview(plusbutton)
        
        let frame_minus = CGRect(x: 60, y: self.view.bounds.height - 50, width: 40 , height: 40)
        let minusbutton = UIButton(frame: frame_minus)
        minusbutton.setImage(UIImage(named: "minus.png"), for: UIControlState.normal)
        minusbutton.addTarget(self, action:#selector(self.remove), for: .touchUpInside)
        self.view.addSubview(minusbutton)
        
        let frame_setting = CGRect(x: self.view.bounds.width - 50, y: self.view.bounds.height - 50, width: 40 , height: 40)
        let settingbutton = UIButton(frame: frame_setting)
        settingbutton.setImage(UIImage(named: "setting"), for: UIControlState.normal)
        settingbutton.addTarget(self, action:#selector(self.setting), for: .touchUpInside)
        self.view.addSubview(settingbutton)

        // tap to dismiss keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
   
    }
   
    func add(){
        var count = defaults.integer(forKey: defaultsKeys.count_temp)
        count += 1
        defaults.setValue(count, forKey: defaultsKeys.count_temp)

        
        
        let x = CGFloat(arc4random_uniform(UInt32(10)))
        let y = CGFloat(arc4random_uniform(UInt32(10)))
        let sticker = Stickie(frame: CGRect(x: self.view.bounds.width/3.5 + x * 8, y: self.view.bounds.width/2 + y * 8, width: 170, height: 170), texts:"",number: count,  color: "yellow", font: "Helvetica", size: 18)
            sticker.delegate = self
            if removing == true{
                sticker.removebutton()
            }
            self.view.addSubview(sticker)
            self.stickies.append(sticker)
        
    

    }
    
    func remove()
    {
        if stickies.count >= 1
        {
        if removing == false{
            
        for i in 0...stickies.count-1
        {
            print("remove")
            stickies[i].removebutton()
              print(stickies.count)
            removing = true
            }
        }
        else{
            for i in 0...stickies.count-1
        {
            print("cancel")
            stickies[i].cancel_remove()
            removing = false
        }
        }
        }
    }
    
    func array_remove(index: Int){
        print(index)
        print(stickies.count)
          stickies.remove(at: index-1)
        
        if stickies.count >= 1{
            for i in 0...(stickies.count-1)
            {
             if stickies[i].index>index
             {
               stickies[i].index = stickies[i].index - 1
                }
        }
        }
    }
    
       
    //save data
    func save() {
        var Data_array: [Data_save] = []
        let count = defaults.integer(forKey: defaultsKeys.count_temp)
        defaults.setValue(count, forKey: defaultsKeys.count)
        print(count)
        
        if count>=1{
        for i in 0...count-1{
            let data_to_save = Data_save(text: stickies[i].text.text, x: stickies[i].lastLocation_save.x, y: stickies[i].lastLocation_save.y, color: stickies[i].color, font:stickies[i].font, size: stickies[i].size)
            Data_array.append(data_to_save)
            print("data saving")
            print(stickies[i].lastLocation_save.x)
            print(stickies[i].lastLocation_save.y)
        }
            let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: Data_array)
            defaults.set(encodedData, forKey: "text")
          //  defaults.synchronize()

        }
    }
    func info(index: Int)
    {
        print("info page")
         info_index = index
        let frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        backgroundView1 = UIView(frame: frame)
        backgroundView1.backgroundColor = UIColor(white: 0.2, alpha: 0.9)
        self.view.addSubview(backgroundView1)
        let color = stickies[info_index-1].color

        stickieView_info = UIImageView(frame:  CGRect(x: (self.view.bounds.width-200)/2, y: self.view.bounds.height * 0.12, width: 200, height: 200))
        stickieView_info.image = UIImage(named: "stickie-\(color!)")
        stickieView_info.contentMode = UIViewContentMode.scaleToFill
        self.view.addSubview(stickieView_info)
        let frame_text = CGRect(x: (self.view.bounds.width-200)/2 + 8, y: 85, width: 190, height: 190)
        text_view_info = UITextView(frame: frame_text)
        print("index is \(index)")
        text_view_info.text = stickies[index-1].text.text
        text_view_info.backgroundColor = UIColor.clear
        text_view_info.font = UIFont(name: stickies[index-1].font, size: stickies[index-1].size)
        self.view.addSubview(text_view_info)

        let bluebtn_frame = CGRect(x: (self.view.bounds.width-275)/2, y: 300, width: 35 , height: 35)
        bluebtn = UIButton(frame: bluebtn_frame)
        bluebtn.setImage(UIImage(named: "stickie-blue"), for: UIControlState.normal)
        bluebtn.addTarget(self, action:#selector(self.blue), for: .touchUpInside)
        self.view.addSubview(bluebtn)
        
        let violet_frame = CGRect(x: (self.view.bounds.width-275)/2 + 40, y: 300, width: 35 , height: 35)
        violetbtn = UIButton(frame: violet_frame)
        violetbtn.setImage(UIImage(named: "stickie-violet"), for: UIControlState.normal)
        violetbtn.addTarget(self, action:#selector(self.violet), for: .touchUpInside)
        self.view.addSubview(violetbtn)
        
        let pink_frame = CGRect(x: (self.view.bounds.width-275)/2 + 80, y: 300, width: 35 , height: 35)
        pinkbtn = UIButton(frame: pink_frame)
        pinkbtn.setImage(UIImage(named: "stickie-pink"), for: UIControlState.normal)
        pinkbtn.addTarget(self, action:#selector(self.pink), for: .touchUpInside)
        self.view.addSubview(pinkbtn)
        
        let yellow_frame = CGRect(x: (self.view.bounds.width-275)/2 + 120, y: 300, width: 35 , height: 35)
        yellowbtn = UIButton(frame: yellow_frame)
        yellowbtn.setImage(UIImage(named: "stickie-yellow"), for: UIControlState.normal)
        yellowbtn.addTarget(self, action:#selector(self.yellow), for: .touchUpInside)
        self.view.addSubview(yellowbtn)
        
        let teal_frame = CGRect(x: (self.view.bounds.width-275)/2 + 160, y: 300, width: 35 , height: 35)
        tealbtn = UIButton(frame: teal_frame)
        tealbtn.setImage(UIImage(named: "stickie-teal"), for: UIControlState.normal)
        tealbtn.addTarget(self, action:#selector(self.teal), for: .touchUpInside)
        self.view.addSubview(tealbtn)
        
        let green_frame = CGRect(x: (self.view.bounds.width-275)/2 + 200, y: 300, width: 35 , height: 35)
        greenbtn = UIButton(frame: green_frame)
        greenbtn.setImage(UIImage(named: "stickie-green"), for: UIControlState.normal)
        greenbtn.addTarget(self, action:#selector(self.green), for: .touchUpInside)
        self.view.addSubview(greenbtn)

        
        let red_frame = CGRect(x: (self.view.bounds.width-275)/2 + 240, y: 300, width: 35 , height: 35)
        redbtn = UIButton(frame: red_frame)
        redbtn.setImage(UIImage(named: "stickie-red"), for: UIControlState.normal)
        redbtn.addTarget(self, action:#selector(self.red), for: .touchUpInside)
        self.view.addSubview(redbtn)

        
        let font1_frame = CGRect(x: self.view.bounds.width * 0.15, y: 300 + 0.1 * self.view.bounds.height , width: 100 , height: 25)
        font1btn = UIButton(frame: font1_frame)
        font1btn.setTitle("Helvetica",for: .normal)
        font1btn.titleLabel!.font =  UIFont(name: "Helvetica", size: 20)
        font1btn.addTarget(self, action:#selector(self.font1), for: .touchUpInside)
        self.view.addSubview(font1btn)
        
        let font2_frame = CGRect(x: self.view.bounds.width * 0.15, y: 300 + self.view.bounds.height * 0.17, width: 100 , height: 25)
        font2btn = UIButton(frame: font2_frame)
        font2btn.setTitle("Futura",for: .normal)
        font2btn.titleLabel!.font =  UIFont(name: "Futura", size: 20)
        font2btn.addTarget(self, action:#selector(self.font2), for: .touchUpInside)
        self.view.addSubview(font2btn)

        
        let font3_frame = CGRect(x: self.view.bounds.width * 0.15, y: 300 + self.view.bounds.height * 0.24, width: 100 , height: 25)
        font3btn = UIButton(frame: font3_frame)
        font3btn.setTitle("Optima",for: .normal)
        font3btn.titleLabel!.font =  UIFont(name: "Optima", size: 20)
        font3btn.addTarget(self, action:#selector(self.font3), for: .touchUpInside)
        self.view.addSubview(font3btn)

        let font4_frame = CGRect(x: self.view.bounds.width * 0.15, y: 300 + self.view.bounds.height * 0.31, width: 100 , height: 25)
        font4btn = UIButton(frame: font4_frame)
        font4btn.setTitle("Gill Sans",for: .normal)
        font4btn.titleLabel!.font =  UIFont(name: "Gill Sans", size: 20)
        font4btn.addTarget(self, action:#selector(self.font4), for: .touchUpInside)
        self.view.addSubview(font4btn)
        
        let font5_frame = CGRect(x: self.view.bounds.width * 0.15, y: 300 + self.view.bounds.height * 0.38, width: 100 , height: 25)
        font5btn = UIButton(frame: font5_frame)
        font5btn.setTitle("Baskerville",for: .normal)
        font5btn.titleLabel!.font =  UIFont(name: "Baskerville", size: 20)
        font5btn.addTarget(self, action:#selector(self.font5), for: .touchUpInside)
        self.view.addSubview(font5btn)
        
        
        font_slider = UISlider(frame:CGRect(x: self.view.bounds.width/2, y: 360 + self.view.bounds.height * 0.14, width: self.view.bounds.width/2.2, height: 20))
        font_slider.minimumValue = 12
        font_slider.maximumValue = 28
        font_slider.isContinuous = true
        font_slider.tintColor = UIColor.green
        font_slider.value = Float((text_view_info.font?.pointSize)!)
        font_slider.addTarget(self, action: #selector(font_change), for: .valueChanged)
        self.view.addSubview(font_slider)

        
        let save_frame = CGRect(x: self.view.bounds.width - 40, y: self.view.bounds.height -  40, width: 35 , height: 35)
        savebtn = UIButton(frame: save_frame)
        savebtn.setImage(UIImage(named: "save"), for: UIControlState.normal)
        savebtn.addTarget(self, action:#selector(self.save_info), for: .touchUpInside)
        self.view.addSubview(savebtn)
        
        
        let font_size_frame = CGRect(x: self.view.bounds.width/2, y: 360 + self.view.bounds.height * 0.14 - 35, width: 150, height: 30)
        let fonts_init_size = stickies[index-1].size!
        font_size = UITextView(frame: font_size_frame)
        font_size.text = "Font Size: \(Int(fonts_init_size))"
        font_size.textColor = UIColor.white
        font_size.backgroundColor = UIColor.clear
        font_size.font = .systemFont(ofSize:16)
        font_size.isEditable = false
        self.view.addSubview(font_size)


   
    }
    
    func font_change(sender:UISlider!){
        font_size.text = "Font Size: \(Int(sender.value))"
        text_view_info.font = UIFont(name: text_view_info.font!.fontName, size: CGFloat(sender.value))
    }
    
    func blue()
    {
        stickieView_info.image = UIImage(named: "stickie-blue")
        stickies[info_index-1].color = "blue"
    }
    func violet()
    {
        stickieView_info.image = UIImage(named: "stickie-violet")
        stickies[info_index-1].color = "violet"
    }
    func yellow()
    {
        stickieView_info.image = UIImage(named: "stickie-yellow")
        stickies[info_index-1].color = "yellow"
    }
    func pink()
    {
        stickieView_info.image = UIImage(named: "stickie-pink")
        stickies[info_index-1].color = "pink"
    }
    func teal()
    {
        stickieView_info.image = UIImage(named: "stickie-teal")
        stickies[info_index-1].color = "teal"
    }
    func red()
    {
        stickieView_info.image = UIImage(named: "stickie-red")
        stickies[info_index-1].color = "red"
    }
    func green()
    {
        stickieView_info.image = UIImage(named: "stickie-green")
        stickies[info_index-1].color = "green"
    }


    func font1()
    {
       text_view_info.font = UIFont(name: "Helvetica", size: text_view_info.font!.pointSize)
    }
    func font2()
    {
        text_view_info.font = UIFont(name: "Futura", size: text_view_info.font!.pointSize)
    }
    func font3()
    {
        text_view_info.font = UIFont(name: "Optima", size: text_view_info.font!.pointSize)
    }
    func font4()
    {
        text_view_info.font = UIFont(name: "Gill Sans", size: text_view_info.font!.pointSize)
    }

    func font5()
    {
        text_view_info.font = UIFont(name: "Baskerville", size: text_view_info.font!.pointSize)
    }

   

    func save_info()
    {
        let text = text_view_info.text
        let font = text_view_info.font!.fontName
        let size = text_view_info.font!.pointSize
        bluebtn.removeFromSuperview()
        yellowbtn.removeFromSuperview()
        pinkbtn.removeFromSuperview()
        violetbtn.removeFromSuperview()
        tealbtn.removeFromSuperview()
        redbtn.removeFromSuperview()
        greenbtn.removeFromSuperview()
        savebtn.removeFromSuperview()
        stickieView_info.removeFromSuperview()
        text_view_info.removeFromSuperview()
        backgroundView1.removeFromSuperview()
        font1btn.removeFromSuperview()
        font2btn.removeFromSuperview()
        font3btn.removeFromSuperview()
        font4btn.removeFromSuperview()
        font5btn.removeFromSuperview()
        font_slider.removeFromSuperview()
        font_size.removeFromSuperview()
        let color = stickies[info_index-1].color
        let x = stickies[info_index-1].lastLocation_save.x
        let y = stickies[info_index-1].lastLocation_save.y
        
        let sticker = Stickie(frame: CGRect(x: x, y: y, width: 170, height: 170), texts:text!, number: info_index, color: color!,  font: font, size: size)
        sticker.delegate = self
        if removing == true{
            sticker.removebutton()
        }
        self.view.addSubview(sticker)
        stickies[info_index-1] = sticker
    }

    func setting()
    {
        let setting = BGSettingViewController()
        self.present(setting, animated: true, completion: nil);
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let bg_image = defaults.string(forKey: defaultsKeys.bg)
        if bg_image != "custom"
        {
        bg.image = UIImage(named: bg_image!)
        }
        else{
            let data = defaults.object(forKey: defaultsKeys.image) as! NSData
            bg.image = UIImage(data: data as Data)
        }
    }
    
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    
    
       }

