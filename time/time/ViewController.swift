//
//  ViewController.swift
//  time
//
//  Created by 李昊 on 15/11/17.
//  Copyright © 2015年 李昊. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var  ctimer:UIDatePicker!
    var btnstart:UIButton!
    var btnstart2:UIButton!
    var label = UILabel()
    var leftTime:Int = 60
    var flag = false
//    var alertView:UIAlertView!
    var timer:NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let win=UIScreen.mainScreen().bounds
        ctimer = UIDatePicker(frame:CGRectMake(win.width/2-100, 100, 200.0, 200.0));
        
        self.ctimer.datePickerMode = UIDatePickerMode.CountDownTimer;
        
       
        self.ctimer.countDownDuration = NSTimeInterval(leftTime);
        //ctimer.addTarget(self, action: "timerChanged", forControlEvents: UIControlEvents.ValueChanged)
        
        self.view.addSubview(ctimer)
        
        btnstart =  UIButton(type: .System)
        btnstart.frame = CGRect(x:win.width/2-50, y:400, width:100, height:100);
        btnstart.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        btnstart.setTitle("开始", forState:UIControlState.Normal)
        //btnstart.setTitle("倒计时中", forState:UIControlState.Disabled)
        
        btnstart.clipsToBounds = true;
        btnstart.layer.cornerRadius = 5;
        btnstart.addTarget(self, action:"startClicked:",forControlEvents:UIControlEvents.TouchUpInside)
        
        btnstart2 =  UIButton(type: .System)
        btnstart2.frame = CGRect(x:win.width/2-50, y:500, width:100, height:100);
        btnstart2.setTitle("停止", forState: UIControlState.Normal)
        btnstart2.addTarget(self, action:"stopClicked:",forControlEvents:UIControlEvents.TouchUpInside)
        btnstart2.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        btnstart2.clipsToBounds = true;
        btnstart2.layer.cornerRadius = 5;
        
        label = UILabel(frame:CGRectMake(win.width/2-100, win.height-120, 200, 100));
        label.textAlignment = NSTextAlignment.Center
        label.text="00:00";
        
        self.view.addSubview(btnstart2)
        self.view.addSubview(btnstart)
        self.view.addSubview(label)
    }
    
   
    func startClicked(sender:UIButton)
    {
        //self.btnstart.enabled = false;
        leftTime = Int(self.ctimer.countDownDuration);
        self.ctimer.enabled = false;
//        if(self.flag == false){
        timer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(1),target:self,selector:Selector("tickDown"),userInfo:nil,repeats:true)
//        }
        timer.fire()
        createAndFireLocalNotificationAfterSeconds(leftTime)
    }
    func stopClicked(sender:UIButton){
        self.timer.invalidate();
        self.ctimer.enabled = true;
        self.flag = true
        UIApplication.sharedApplication().cancelAllLocalNotifications()
    }
 
    func tickDown(){
       
        self.label.text="\(leftTime/60):\(leftTime%60)"
        leftTime -= 1;
        self.ctimer.countDownDuration = NSTimeInterval(leftTime);

        if(leftTime <= 0)
        {
         
            timer.invalidate();
            self.ctimer.enabled = true;
            self.btnstart.enabled = true;
            self.flag = true
            let alertView = UIAlertView()
            alertView.message = "时间到！"
            alertView.addButtonWithTitle("确定")
            alertView.show()
        }
    }
    func createAndFireLocalNotificationAfterSeconds(seconds: Int) {
        
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        let notification = UILocalNotification()
        
        let timeIntervalSinceNow =  NSNumber(integer: seconds).doubleValue
        notification.fireDate = NSDate(timeIntervalSinceNow:timeIntervalSinceNow);
        notification.timeZone = NSTimeZone.systemTimeZone();
        notification.alertBody = "计时完成！";
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification);
        
    }
        
}
