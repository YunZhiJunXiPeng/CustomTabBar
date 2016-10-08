//
//  RootViewController.swift
//  自定义TabBar
//
//  Created by Young on 10/8/16.
//  Copyright © 2016 Young. All rights reserved.
//

import UIKit

class RootViewController: UITabBarController, CustomTabBarDelegate {

    @IBOutlet weak var myTabBar: CustomTabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //  设置代理
        myTabBar.delegateTabbar = self;
    }

    // 实现代理方法
    func barButtonAction(sender: CustomCenterButton) {
        print(" RootViewController---->CustomBarbuttonDelegate方法")
        
        let newVc: UIAlertController = UIAlertController.init(title: "分享", message: "无兄弟不篮球", preferredStyle: UIAlertControllerStyle.alert)
        
        self.present(newVc, animated: true, completion: {
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0, execute: {
               newVc.dismiss(animated: true, completion: nil)
            })
            
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
       
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
