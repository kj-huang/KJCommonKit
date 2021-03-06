//
//  KJAlertAction.swift
//  KJCommonKit
//
//  Created by 黄克瑾 on 2020/7/8.
//  Copyright © 2020 黄克瑾. All rights reserved.
//

import Foundation
import UIKit

@objcMembers
public class KJAlertAction: NSObject {
    typealias KJAlertActionHandler = (KJAlertAction) -> Void
    
    /// 标题
    private(set) var title: String? = nil
    /// 类型
    private var style: KJAlertAction.Style = .default {
        didSet {
            font = style == .default ? UIFont.systemFont(ofSize: 15.0, weight: .medium) : style == .cancel ? UIFont.systemFont(ofSize: 15.0, weight: .semibold) : UIFont.systemFont(ofSize: 15.0, weight: .bold)
            titleColor = style == .cancel ? UIColor.black : style == .destructive ? UIColor.red : UIColor.black.withAlphaComponent(0.9)
        }
    }
    /// 点击回调
    private(set) var handler: KJAlertActionHandler? = nil
    /// 文本颜色，受style影响自动改变，外部可自行修改
    open var titleColor: UIColor = UIColor.black
    /// 字体，受style影响自动改变，外部可自行修改
    open var font: UIFont = UIFont.systemFont(ofSize: 15.0)
    /// layer，有渐变背景或其他需求，请外部自行设置
    open var layer: CALayer? = nil
    /// 富文本，有需要请外部自行设置，当存在该属性时，title、style、font、titleColor等属性无效
    open var attTitle: NSAttributedString? = nil
    
    
    /// 初始化
    /// - Parameters:
    ///   - title: 文案
    ///   - style: 类型
    ///   - custom: 自定义
    ///   - handler: 点击回调
    @objc(initTitle:style:custom:handler:)
    public init(title: String?,
                style: KJAlertAction.Style = .default,
                custom: ((KJAlertAction) -> Void)? = nil,
                handler: ((KJAlertAction) -> Void)? = nil) {
        super.init()
        self.title = title
        defer {
            self.style = style
            custom?(self)
        }
        self.handler = handler
    }
    
    /// 类方法(方便OC使用)
    /// - Parameters:
    ///   - title: 文案
    ///   - style: 类型
    ///   - custom: 自定义
    ///   - handler: 点击回调
    /// - Returns: KJAlertAction
    public static func action(title: String?,
                              style:KJAlertAction.Style = .default,
                              custom: ((KJAlertAction) -> Void)? = nil,
                              handler: ((KJAlertAction) -> Void)? = nil) -> KJAlertAction {
        return KJAlertAction(title: title, style: style, custom: custom, handler: handler)
    }
    
    /// 禁止外界使用init初始化
    private override init() {}
    private class func new() {}
    
}



