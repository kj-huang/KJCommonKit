//
//  KJXlsxWriterManager.swift
//  KJCommonKit
//
//  Created by 黄克瑾 on 2020/7/11.
//  Copyright © 2020 黄克瑾. All rights reserved.
//  原生代码生成Excel,不能自定义sheet，如需特殊需求，建议使用libxlsxwriter开源库实现

import UIKit

@objcMembers
public class KJXlsxWriterManager: NSObject {
    
    /// 记录最大列数
    private var colIndex: Int = 0
    /// 记录最大行数
    private var rowIndex: Int = 0
    /// 记录所有数据
    private var excelDatas: Dictionary<String, Any> = Dictionary()
    /// 记录文件保存的本地路径
    private var filePath: URL? = nil
    
    
    
    /// 初始化
    /// - Parameter path: Excel文件保存的本地路径
    public init(path: String) {
        super.init()
        assert(path.hasSuffix(".xlsx") || path.hasSuffix(".xls"), "请给文件添加后缀.xlsx")
        self.filePath = URL(fileURLWithPath: path)
        assert(self.filePath != nil, "请给出正确的文件路径")
    }
    
    /// 新增数据
    /// - Parameters:
    ///   - data: 数据
    ///   - col: 列 0、1、2......
    ///   - row: 行 0、1、2......
    public func insert(data: String, col: Int, row: Int) {
        colIndex = max(col, colIndex)
        rowIndex = max(row, rowIndex)
        excelDatas.updateValue(data, forKey: "\(col):\(row)")
    }
    
    /// 根据列数添加数据（行数取当前最大值+1）
    /// - Parameters:
    ///   - data: 数据
    ///   - col: 列 0、1、2......
    public func append(data: String, col: Int) {
        insert(data: data, col: col, row: rowIndex+1)
    }
    
    
    /// 根据行数添加数据（列数取当前最大值+1）
    /// - Parameters:
    ///   - data: 数据
    ///   - row: 行 0、1、2......
    public func append(data: String, row: Int) {
        insert(data: data, col: colIndex + 1, row: row)
    }
    
    /// 开始写数据到文件
    public func writer() -> Bool {
        assert(excelDatas.count > 0, "请先添加数据后，再进行写入操作")
        var content = ""
        for i in 0...rowIndex {
            for j in 0...colIndex {
                // 取内容
                let val: String? = excelDatas["\(j):\(i)"] as? String
                content = content + (val ?? "")
                if j < colIndex {
                    content = content + "\t"
                }
            }
            if i < rowIndex {
                content = content + "\n"
            }
        }
        
        let fileManager = FileManager.default
        let data = content.data(using: .utf16)
        try? fileManager.removeItem(at: filePath!)
        if fileManager.createFile(atPath: filePath!.path,
                                  contents: data,
                                  attributes: nil) {
            print("Excel文件生成成功：\(filePath!)")
            return true
        }
        return false
    }
}

