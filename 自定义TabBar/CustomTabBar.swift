//
//  CustomTabBar.swift
//  自定义TabBar
//
//  Created by Young on 10/8/16.
//  Copyright © 2016 Young. All rights reserved.
//

import UIKit

// 定义一个协议 让代理去实现点击 加号时候的方法
protocol CustomTabBarDelegate {
    func barButtonAction(sender: CustomCenterButton)
}

class CustomTabBar: UITabBar {

    var delegateTabbar: CustomTabBarDelegate?
    
    // 引入自定义的 Button(中间的大加号)
    let addButton: CustomCenterButton = CustomCenterButton.init(frame: CGRect.zero)
    // 把自定义的 Button 放到 自定义的 Tabbar 上
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.addSubview(addButton)
        
        
        addButton.addTarget(self, action: #selector(barButtonAction), for: UIControlEvents.touchUpInside)
    }
    
    // 调用协议的方法
    func barButtonAction(sender: CustomCenterButton)
    {
        print("-调用协议方法-------->")
        self.delegateTabbar?.barButtonAction(sender: sender)
    }
    
    
    // 可视化编程时候走这个方法
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.addSubview(addButton)
        
        addButton.addTarget(self, action: #selector(barButtonAction), for: UIControlEvents.touchUpInside)
    }
    
    // 布局子控件  在这里主要是让大加号处于中间偏上的位置
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 布置每一个 item 的 frame
        var itemX: CGFloat = 0.0
        let itemY: CGFloat = 0.0
        let itemH: CGFloat  = self.bounds.size.height
        // 记录 标签个数也是就是 tabBarButton 的个数
        let ddd: CGFloat = CGFloat(self.items!.count)
        // 算出每一个占据的宽度 加上了加号 Button 的位置
        let itemW: CGFloat = self.bounds.size.width / (ddd + 1)
        
        var itemCurrent: CGFloat = 0
        
        // 遍历子视图 找出 tabbarButton 依次分配位置
        for itemTemp in self.subviews
        {
            print("子视图->",itemTemp,"\n")
            if NSStringFromClass(itemTemp.classForCoder) == "UITabBarButton"
            {
                // 留出中间位置给加号 Button
                if itemCurrent == 2
                {
                    itemCurrent = 3
                }
                
                itemX = itemCurrent * itemW
                itemTemp.frame = CGRect(x: itemX, y: itemY, width: itemW, height: itemH)
                itemCurrent += 1
            }
            // 算出加号的位置
            self.addButton.bounds.size = CGSize(width: itemW, height: itemH + 30)
            self.addButton.center = CGPoint(x: self.bounds.size.width / 2.0, y: 0)
        }
    }
    
    // 这个方法就是为了让超出的加号部分也能点击响应
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        // 只有在没有被隐藏的时候才会需要
        if self.isHidden == false
        {
            let newPoint: CGPoint = self.convert(point, to: self.addButton)
            // 判断点击的点在加号的范围里面  那么响应的范围就是加号的范围
            if self.addButton.point(inside: newPoint, with: event)
            {
                return self.addButton
            }else
            {// 其他时候  就按照系统的方法走就行了
                return super.hitTest(point, with: event)
            }
            
        }else
        {
            // 其他时候  就按照系统的方法走就行了
            return super.hitTest(point, with: event)
        }
    }
}
