//
//  KJStringEx.swift
//  KJCommonKit
//
//  Created by 黄克瑾 on 2020/7/8.
//  Copyright © 2020 黄克瑾. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    /// 计算文本的宽高
    /// - Parameters:
    ///   - maxWidth: 最大宽度
    ///   - font: 字体
    /// - Returns: size
    func kj_size(maxWidth: CGFloat, font: UIFont) -> CGSize {
        let style = NSMutableParagraphStyle()
        style.minimumLineHeight = font.lineHeight
        style.maximumLineHeight = font.lineHeight
        let att = NSAttributedString(string: self,
                                     attributes: [
                                        .paragraphStyle: style,
                                        .font: font])
        return att.kj_size(maxWidth)
    }
    
    func kj_height(maxWidth: CGFloat, font: UIFont) -> CGFloat {
        return ceilf(kj_size(maxWidth: maxWidth, font: font).height.kj_floatValue()).kj_cgFloatValue()
    }
}
