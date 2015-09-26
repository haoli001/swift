//
//  ViewController.swift
//  login
//
//  Created by 李昊 on 15/9/24.
//  Copyright © 2015年 李昊. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController ,UITextFieldDelegate{
    @IBOutlet weak var u_name: UITextField!
    @IBOutlet weak var u_password: UITextField!

    @IBOutlet weak var login_button: UIButton!
    @IBOutlet weak var regist_button: UIButton!
    var registViewControler:UIViewController!
    var tmp:Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        u_name.placeholder="用户名/账号"
        u_password.placeholder = "密码"
        
        login_button.layer.cornerRadius = 4.0
        login_button.layer.masksToBounds = true
    
        u_name.delegate = self
        u_password.delegate = self
        
        u_password.secureTextEntry = true
        
        tmp=3;
        
        registViewControler=storyboard?.instantiateViewControllerWithIdentifier("regist")
        
    }
    
    func judge(h:String)->Bool{
        for i in h.characters{
            if(i>"9"||i<"0"){
                if(i<"a"||i>"z"){
                    if(i>"Z"||i<"A"){
                        return false
                    }
                }
            }
        }
        return true
    }
    func judge_up(name:String,password:String)->Bool{
        
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        let fetchRequest:NSFetchRequest = NSFetchRequest()
        fetchRequest.fetchLimit = 1 //限定查询结果的数量
        fetchRequest.fetchOffset = 0 //查询的偏移量
        
        //声明一个实体结构
        let entity:NSEntityDescription? = NSEntityDescription.entityForName("User",
            inManagedObjectContext: context)
        //设置数据请求的实体结构
        fetchRequest.entity = entity
        
        //设置查询条件
        let predicate = NSPredicate(format: "username= '\(name)' ")
        fetchRequest.predicate = predicate
        
        //查询操作
        let fetchedObjects:[AnyObject]? = try!context.executeFetchRequest(fetchRequest)
        for info:User in fetchedObjects as! [User]{
            if(info.password==password){
                return true
            }else{
                return false
            }
        }
        return false
    }
    func massagebox(titleS:String, messageS:String,flag:Bool){
        UIAlertView(title: titleS, message:messageS, delegate: self, cancelButtonTitle: "确定").show()
        if(flag){
        tmp=tmp-1
        }
    }
    @IBAction func tapLogin_button(sender: AnyObject) {
        if(tmp<1){
            massagebox("⚠",messageS: "超过尝试次数",flag:false)
        }else
        if(u_name.text==""||u_password.text==""){
            massagebox("⚠",messageS: "用户名或密码错误",flag:true)
        }else if(u_password.text!.characters.count<8){
            massagebox("⚠",messageS: "密码过短",flag:true)
        }else if(judge(u_password.text!)==false){
            massagebox("⚠",messageS: "密码不合法",flag:true)
        }else if(judge_up(u_name.text!,password: u_password.text!)){
            massagebox("😊",messageS: "登录成功",flag:false)
        }else{
            massagebox("⚠",messageS: "用户名或密码错误",flag:true)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        [textField.resignFirstResponder()]
        return true;
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        u_name.resignFirstResponder()
        u_password.resignFirstResponder()
    }

    @IBAction func ToRegistView(sender: AnyObject) {
        registViewControler.view.frame=self.view.frame
        addChildViewController(registViewControler!)
        let subview = registViewControler?.view
        view.addSubview(subview!)
    }
}


