//
//  KJEdgeInsetsEx.swift
//  KJCommonKit
//
//  Created by 黄克瑾 on 2020/7/8.
//  Copyright © 2020 黄克瑾. All rights reserved.
//

import Foundation
import UIKit

extension UIEdgeInsets {
    
    /// 初始化
    /// - Parameters:
    ///   - horizontal: 水平方向   top 和  bottom
    ///   - vertical: 垂直方向  left 和 right
    init(horizontal: CGFloat = 0, vertical: CGFloat = 0) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
    
    /// 初始化
    /// - Parameter all: 四个方向同一个值
    init(_ all: CGFloat) {
        self.init(top: all, left: all, bottom: all, right: all)
    }
    
    /// 水平方向总和 left + right
    func kj_horizontal() -> CGFloat {
        return left + right
    }
    
    /// 垂直方向总和 bottom + top
    func kj_vertical() -> CGFloat {
        return top + bottom
    }
}
