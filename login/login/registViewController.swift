//
//  registViewController.swift
//  login
//
//  Created by 李昊 on 15/9/26.
//  Copyright © 2015年 李昊. All rights reserved.
//

import UIKit
import CoreData

class registViewController: UIViewController ,UITextFieldDelegate{

    @IBOutlet weak var user_name: UITextField!
    @IBOutlet weak var u_password: UITextField!
    @IBOutlet weak var u_password2: UITextField!
    @IBOutlet weak var confrim: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        user_name.placeholder="用户名/账号"
        u_password.placeholder = "密码"
        u_password2.placeholder = "请重复密码"
        
        confrim.layer.cornerRadius = 4.0
        confrim.layer.masksToBounds = true
        
        user_name.delegate = self
        u_password.delegate = self
        u_password2.delegate = self
        
        u_password.secureTextEntry = true
        u_password2.secureTextEntry = true

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
            if(info.username==name){
                return false
            }
        }
            //创建User对象
            let user = NSEntityDescription.insertNewObjectForEntityForName("User",
                inManagedObjectContext: context) as! User
            
            //对象赋值
            user.username = name
            user.password = password
            
            //保存
            try!context.save()
            return true
    }
    func massagebox(titleS:String, messageS:String,flag:Bool){
        UIAlertView(title: titleS, message:messageS, delegate: self, cancelButtonTitle: "确定").show()
        
    }
    @IBAction func Tapregist(sender: AnyObject) {
            if(u_password.text != u_password2.text ){
                massagebox("⚠",messageS: "密码不一致",flag:true)
            }else if(user_name.text == ""||u_password.text == ""){
                massagebox("⚠",messageS: "用户名或密码错误",flag:true)
            }else if(u_password.text!.characters.count < 8 ){
                massagebox("⚠",messageS: "密码过短",flag:true)
            }else if(judge(u_password.text!)==false){
                massagebox("⚠",messageS: "密码不合法",flag:true)
            }else if(judge_up(user_name.text!,password: u_password.text!)){
                massagebox("😊",messageS: "注册成功",flag:false)
            }else{
                massagebox("⚠",messageS: "用户名已经存在",flag:true)
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
        user_name.resignFirstResponder()
        u_password.resignFirstResponder()
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
