//
//  ViewController.swift
//  KJCommonKit
//
//  Created by 黄克瑾 on 2020/7/8.
//  Copyright © 2020 黄克瑾. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let alert = KJAlertController(title: "标题", message: "副标题", style: .alert)
        alert.addAction(KJAlertAction(title: "确定", style: .default, custom: {
            (item) in
            let layer = CALayer()
            layer.backgroundColor = UIColor.orange.cgColor
            item.layer = layer
        }, handler: { (action) in
            print("点击了\(action.title ?? "")")
        }))
        alert.addAction(KJAlertAction(title: "删除", style: .destructive, handler: {
            (action) in
            print("点击了\(action.title ?? "")")
        }))
        alert.addAction(KJAlertAction(title: "取消", style: .cancel, handler: {
            (action) in
            print("点击了\(action.title ?? "")")
        }))
        alert.show(self)
        
//        let alert = UIAlertController(title: "标题", message: "内容", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
//        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
//        alert.addAction(UIAlertAction(title: "删除", style: .destructive, handler: nil))
//        self.present(alert, animated: true, completion: nil)
    }
}

