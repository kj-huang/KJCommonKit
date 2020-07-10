//
//  KJAlertController.swift
//  KJCommonKit
//
//  Created by 黄克瑾 on 2020/7/8.
//  Copyright © 2020 黄克瑾. All rights reserved.
//

import UIKit

@objcMembers
public class KJAlertController: UIViewController {
    
    // MARK: - var 所有属性请在present之前调用
    
    /// 标题的字体颜色
    open var titleColor: UIColor = UIColor.black
    /// 标题的字体大小
    open var titleFont: UIFont = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
    /// 内容的字体颜色
    open var messageColor: UIColor = UIColor.black.withAlphaComponent(0.9)
    /// 内容的字体大小
    open var messageFont = UIFont.systemFont(ofSize: 15.0)
    
    /// 富文本标题，如果设置了该属性， kjTitle、titleColor、titleFont等属性无效
    open var attTitle: NSAttributedString? = nil
    /// 富文本内容，如果设置了该属性，kjMessage、messageColor、messageFont等属性无效
    open var attMessage: NSAttributedString? = nil
    
    /// 标题对齐样式
    open var titleAlignment: NSTextAlignment = .center
    /// 内容对齐样式
    open var messageAlignment: NSTextAlignment = .center
    
    /// 标题
    open var kjTitle: String? = nil
    /// 内容
    open var kjMessage: String? = nil
    
    /// 与屏幕的间隔，会根据Style自动改变，外部也可以设置
    open var screenInsets: UIEdgeInsets = UIEdgeInsets.zero
    /// 内容与白色背景的间隔
    open var contentInsets: UIEdgeInsets = UIEdgeInsets(top: 35.0, left: 30.0, bottom: 20.0, right: 30.0)
    
    /// 水平排列按钮间隔，默认20
    open var interitemSpacing: CGFloat = 20.0
    /// 垂直排列按钮间隔，默认1.0
    open var lineSpacing: CGFloat = 1.0
    
    /// 是否展示按钮之间的分割线，默认true-显示
    open var showItemSeparator: Bool = true
    /// 分割线的颜色 默认lightGray
    open var itemSeparatorColor: UIColor = UIColor.lightGray
    /// 按钮垂直排列时(分割线左右的间隔),top和bottom是无效值， 按钮水平排列时(分割线top和bottom与按钮的top和bottom的间隔)，left和right无效
    open var itemSeparatorInsets: UIEdgeInsets = UIEdgeInsets.zero
    
    /// message与按钮之间的分割线，默认true-显示
    open var showContentSeparator: Bool = true
    /// message与按钮之间的分割线显色，默认 nil-表示和itemSeparatorColor颜色一致，反之使用设置的值
    open var contentSeparatorColor: UIColor? = nil
    /// 内容分割线左右下间隔
    open var contentSeparatorInsets: UIEdgeInsets = UIEdgeInsets.zero
    
    /// 分割线的宽度(按钮水平排列时)或高度(按钮垂直排列或内容分割线时)
    open var separatorSize: CGFloat = 0.5
    
    
    
    /// 按钮的高度， 默认38.0
    open var itemHeight: CGFloat = 40.0
    
    /// 类型
    private(set) var style: KJAlertController.Style = .sheet {
        didSet {
            screenInsets = UIEdgeInsets(top: 100.0, left: 35.0, bottom: style == .sheet ? 0.0 : 100.0, right: 35.0)
        }
    }
    
    /// 点击空白部分是否自动消失
    open var autoDisappear: Bool = true
    
    /// 按钮集合
    private(set) var items:[KJAlertAction] = []
    
    // MARK: - init
    
    /// 外部init初始化
    @objc(initTitle:message:style:)
    public init(title: String? = nil, message: String? = nil, style: KJAlertController.Style = .sheet) {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve
        kjTitle = title
        kjMessage = message
        defer { // 使用defer是为了能在init中触发didSet
            self.style = style
        }
    }
    
    internal required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 展示
    public func show(_ from: UIViewController) {
        assert(items.count > 0, "请添加Action")
        from.present(self, animated: true, completion: nil)
    }
    
    /// 添加按钮
    public func addAction(_ action: KJAlertAction) {
        assert((action.title != nil && action.title != "") || action.attTitle != nil, "请设置Action的title或attTitle")
        items.append(action)
    }
    
    // MARK: - UI
    
    private lazy var contentView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 10.0
        v.clipsToBounds = true
        return v
    }()
    
    /// 标题Label
    private lazy var titleView: UILabel? = {
        guard isExistTitle else { return nil }
        let lb = UILabel()
        lb.textAlignment = titleAlignment
        lb.numberOfLines = 0
        if attTitle != nil {
            lb.attributedText = attTitle
            lb.frame = CGRect(x: contentInsets.left,
                              y: contentInsets.top,
                              width: contentMaxWidth,
                              height: attTitle!.kj_height(contentMaxWidth))
        } else {
            lb.text = kjTitle
            lb.font = titleFont
            lb.textColor = titleColor
            lb.frame = CGRect(x: contentInsets.left,
                              y: contentInsets.top,
                              width: contentMaxWidth,
                              height: kjTitle!.kj_height(maxWidth: contentMaxWidth, font: messageFont))
        }
        return lb
    }()
    
    /// 内容Label
    private lazy var messageView: UILabel? = {
        guard isExistMessage else { return nil }
        let lb = UILabel()
        lb.textAlignment = messageAlignment
        lb.numberOfLines = 0
        var messageY = contentInsets.top
        if titleView != nil {
            messageY = titleView!.frame.maxY + 15.0
        }
        if attMessage != nil {
            lb.attributedText = attMessage
            lb.frame = CGRect(x: contentInsets.left,
                              y:  messageY,
                              width: contentMaxWidth,
                              height: attMessage!.kj_height(contentMaxWidth))
        } else {
            lb.text = kjMessage
            lb.font = messageFont
            lb.textColor = messageColor
            lb.frame = CGRect(x: contentInsets.left,
                              y: messageY,
                              width: contentMaxWidth,
                              height: kjMessage!.kj_height(maxWidth: contentMaxWidth, font: messageFont))
        }
        return lb
    }()
    
    /// 是否存在title
    private lazy var isExistTitle: Bool = {
        return attTitle != nil || (kjTitle != nil && kjTitle != "")
    }()
    /// 是否存在message
    private lazy var isExistMessage: Bool = {
        return attMessage != nil || (kjMessage != nil && kjMessage != "")
    }()
    /// 内容的最大宽度
    private lazy var contentMaxWidth: CGFloat = (KJ_SCREEN_WIDTH - contentInsets.kj_horizontal() - screenInsets.kj_horizontal())
    
    private lazy var itemScrollView: UIScrollView = {
        var vY = contentInsets.top
        if messageView != nil {
            vY = messageView!.frame.maxY + 20.0
        } else if titleView != nil {
            vY = titleView!.frame.maxY + 20.0
        }
        let vWidth = KJ_SCREEN_WIDTH - screenInsets.kj_horizontal()
        var vHeight = itemHeight * CGFloat(items.count)
        if style == .sheet || items.count > 2 {
            vHeight += (lineSpacing * CGFloat(items.count))
        } else {
            vHeight = itemHeight
        }
        let sv = UIScrollView(frame: CGRect(x: 0,
                                            y: vY,
                                            width: vWidth,
                                            height: vHeight))
        sv.contentSize = sv.bounds.size
        let itemContentView = UIView(frame: CGRect(x: 0, y: 0, width: sv.bounds.width, height: sv.bounds.height))
        sv.addSubview(itemContentView)
        let isVertical: Bool = style == .sheet || items.count > 2
        var lastBtn:KJAlertActionButton? = nil
        let itemWidth = isVertical ? contentMaxWidth : (contentMaxWidth - interitemSpacing) / 2.0
        for i in 0..<items.count {
            let action = items[i]
            // 按钮
            let btn = KJAlertActionButton(item: action) { [weak self] (model) in
                self?.dismiss(animated: true, completion: nil)
                model.handler?(model)
            }
            itemContentView.addSubview(btn)
            if lastBtn != nil {
                let btnX = isVertical ? lastBtn!.frame.minX : lastBtn!.frame.maxX + interitemSpacing
                let btnY = isVertical ? lastBtn!.frame.maxY + lineSpacing : lastBtn!.frame.minY
                btn.frame = CGRect(x: btnX,
                                   y: btnY,
                                   width: itemWidth,
                                   height: itemHeight)
            } else {
                btn.frame = CGRect(x: contentInsets.left,
                                   y: 0,
                                   width: itemWidth,
                                   height: itemHeight)
            }
            // 分割线
            if i < items.count - 1 && showItemSeparator {
                let lineView = UIView()
                lineView.backgroundColor = itemSeparatorColor
                let lineX = isVertical ? itemSeparatorInsets.left : (itemContentView.bounds.width - separatorSize) / 2.0
                let lineY = isVertical ? btn.frame.maxY + lineSpacing / 2.0 : btn.frame.minY + itemSeparatorInsets.top
                let lineW = isVertical ? itemContentView.bounds.width -  itemSeparatorInsets.kj_horizontal() : separatorSize
                let lineH = isVertical ? separatorSize : btn.bounds.height - itemSeparatorInsets.kj_vertical()
                lineView.frame = CGRect(x: lineX,
                                        y: lineY,
                                        width: lineW,
                                        height: lineH)
                itemContentView.addSubview(lineView)
            }
            lastBtn = btn
            
        }
        
        return sv
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        // 断言、避免出现特殊情况
        assert(self.navigationController == nil, "请present显示，不用设置UINavigationController")
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
        view.addSubview(contentView)
        var contentHeight: CGFloat = 0.0
        if titleView != nil {
            contentView.addSubview(titleView!)
            if isExistMessage == false {
                contentHeight = titleView!.frame.maxY
            }
        }
        if messageView != nil {
            contentView.addSubview(messageView!)
            contentHeight = messageView!.frame.maxY
        }
        contentHeight += contentInsets.bottom
        
        let itemViewMaxHeight = KJ_SCREEN_HEIGHT - contentInsets.top - contentInsets.bottom - contentHeight
        if itemScrollView.bounds.height > itemViewMaxHeight {
            var rect = itemScrollView.frame
            rect.size.height = itemViewMaxHeight
            itemScrollView.frame = rect
        }
        contentView.addSubview(itemScrollView)
        
        contentHeight = itemScrollView.frame.maxY + contentInsets.bottom
        var contentY = (KJ_SCREEN_HEIGHT - contentHeight) / 2.0
        if style == .sheet {
            contentY = KJ_SCREEN_HEIGHT - contentHeight - 20.0
            if #available(iOS 11.0, *) {
                if let window = UIApplication.shared.windows.first {
                    contentY -= window.safeAreaInsets.bottom
                }
            }
        }
        contentView.frame = CGRect(x: screenInsets.left,
                                   y: contentY,
                                   width: KJ_SCREEN_WIDTH - screenInsets.left - screenInsets.right,
                                   height: contentHeight)
        
        // 内容分割线
        if showContentSeparator {
            let lineView = UIView()
            lineView.backgroundColor = contentSeparatorColor ?? itemSeparatorColor
            lineView.frame = CGRect(x: contentSeparatorInsets.left,
                                    y: itemScrollView.frame.minY - contentSeparatorInsets.bottom,
                                    width: contentView.frame.width - contentSeparatorInsets.kj_horizontal(),
                                    height: separatorSize)
            contentView.addSubview(lineView)
        }
        
        // 添加手势
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapActionHandler))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    @objc private func didTapActionHandler() {
        if autoDisappear {
            dismiss(animated: true, completion: nil)
        }
    }
}

extension KJAlertController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view == contentView || touch.view?.isKind(of: UIButton.self) == true {
            return false
        }
        return true
    }
}

class KJAlertActionButton: UIButton {
    
    var itemModel: KJAlertAction? = nil {
        didSet {
            if itemModel?.attTitle != nil {
                setAttributedTitle(itemModel?.attTitle!, for: .normal)
            } else {
                titleLabel?.font = itemModel?.font
                setTitleColor(itemModel?.titleColor, for: .normal)
                setTitle(itemModel?.title, for: .normal)
            }
            if let customLayout = itemModel?.layer {
                layer.insertSublayer(customLayout, at: 0)
            }
        }
    }
    typealias KJAlertButtonAction = (KJAlertAction) -> Void
    private var block: KJAlertButtonAction? = nil
    
    init(item: KJAlertAction, action: @escaping KJAlertButtonAction) {
        super.init(frame: .zero)
        addTarget(self, action: #selector(didAction), for: .touchUpInside)
        block = action
        defer {
            itemModel = item
        }
    }
    
    @objc private func didAction() {
        block?(itemModel!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let customLayout = itemModel?.layer {
            customLayout.frame = CGRect(x: 0,
                                        y: 0,
                                        width: bounds.width,
                                        height: bounds.height)
        }
    }
}
