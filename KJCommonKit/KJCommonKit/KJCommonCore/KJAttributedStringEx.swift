//
//  KJAttributedStringEx.swift
//  KJCommonKit
//
//  Created by 黄克瑾 on 2020/7/8.
//  Copyright © 2020 黄克瑾. All rights reserved.
//

import Foundation
import UIKit

extension NSAttributedString {
    
    /// 计算宽高
    /// - Parameter maxWidth: 最大宽度
    /// - Returns: size
    func kj_size(_ maxWidth: CGFloat) -> CGSize {
        return boundingRect(with: CGSize(width: maxWidth, height: CGFloat(MAXFLOAT)), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil).size
    }
    
    /// 计算高度
    /// - Parameter maxWidth: 最大宽度
    /// - Returns: size
    func kj_height(_ maxWidth: CGFloat) -> CGFloat {
        return ceilf(kj_size(maxWidth).height.kj_floatValue()).kj_cgFloatValue()
    }
}
