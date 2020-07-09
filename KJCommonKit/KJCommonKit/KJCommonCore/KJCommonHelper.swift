//
//  KJCommonHelper.swift
//  KJCommonKit
//
//  Created by 黄克瑾 on 2020/7/8.
//  Copyright © 2020 黄克瑾. All rights reserved.
//

import Foundation
import UIKit

/// 屏幕的宽高
let KJ_SCREEN_SIZE: CGSize = (UIScreen.main.bounds.size)
/// 屏幕的宽度
let KJ_SCREEN_WIDTH: CGFloat = (KJ_SCREEN_SIZE.width)
/// 屏幕的高度
let KJ_SCREEN_HEIGHT: CGFloat = (KJ_SCREEN_SIZE.height)
/// 判断设备是否是iPad
let isIPad: Bool = UIDevice.current.userInterfaceIdiom == .pad
/// 判断设备是否是iPhone
let isIPhone: Bool = UIDevice.current.model.hasPrefix("iPhone")
/// 判断设置是否是iPod
let isIPod: Bool = UIDevice.current.model.hasPrefix("iPod")


