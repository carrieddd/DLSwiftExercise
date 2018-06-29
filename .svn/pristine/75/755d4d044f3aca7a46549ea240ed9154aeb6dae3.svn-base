//
//  DLSelectierView.swift
//  dongliangHead
//
//  Created by iOS110 on 2018/5/18.
//  Copyright © 2018年 iOS110. All rights reserved.
//

import UIKit

protocol DLselecterDelegate {
    func selecterViewSelectItem(index:Int);
    
}
let LinePadding:CGFloat = CGFloat(0)
let ItemPadding:CGFloat = CGFloat(34)
let LineHigh:CGFloat = CGFloat(2)
let dl_btnTitleColor = UIColor.withHex(hexString:"666666")
let dl_btnSelTitleColor = UIColor.withHex(hexString:"F44858")
let dl_line = UIColor.withHex(hexString:"F44858")
let dl_cutline = UIColor.withHex(hexString:"E6E6E6")


public class DLSelecterView: UIView {

    typealias ClickHandle = (NSInteger) -> Void
    private var clickHandle:ClickHandle?
    var delegate:DLselecterDelegate?

    enum selecter {
        case average
        case onebyone
    }
    private var _items:[String]?
    var items:[String]{
        get{
            return _items!
        }
        set{
            _items = newValue
            initSubview()
        }
    }
    
    private var _type:selecter = .average
    var type:selecter {
        get{
            return _type
        }
        set{
            _type = newValue
            self.reframeItems()
        }
        
    }
    
    private var _index:Int = 0
    var index:Int{
        get{
            return _index
        }
        set{
            _index = newValue
            
            for (_, value) in (self.item_btns.enumerated()){
                value.isSelected = false
            }
            item_btns[_index].isSelected = true
            let tempBtn:UIButton = item_btns[_index].copy() as! UIButton
            tempBtn.sizeToFit()
            let tempFrame = tempBtn.frame
            selectedLine.frame = CGRect.init(x: tempFrame.minX + LinePadding, y: self.height-3, width: tempFrame.width, height: LineHigh)
            selectedLine.centerX = item_btns[_index].centerX

//            let tempFrame = item_btns[newValue].frame
//            selectedLine.frame = CGRect.init(x: tempFrame.minX + LinePadding, y: tempFrame.height, width: tempFrame.width - LinePadding - LinePadding, height: LineHigh)
        }
    }
    
    let contentScroll = DLPageScroll()
    var selectedLine:CALayer = {
        $0.backgroundColor = dl_line.cgColor
        return $0
    }(CALayer())
    
    var cutLine:CALayer = {
        $0.backgroundColor = dl_cutline.cgColor
        return $0
    }(CALayer())

    
    private var item_btns:[DLBaseButton] = []
    
    init(titles:[String],frame:CGRect) {
        super.init(frame: frame)
        self.items = titles
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initSubview(){
        item_btns.removeAll()
        items.forEach { [weak self](itemStr) in
            let item_btn = DLBaseButton.init(handle: { (sender) in
                self?.index = sender.tag
                self?.delegate?.selecterViewSelectItem(index: self?.index ?? 0)
                if self?.clickHandle != nil {
                    self?.clickHandle!(self?.index ?? 0)
                }
            })
            item_btn.setTitleColor(dl_btnTitleColor, for: .normal)
            item_btn.setTitleColor(dl_btnSelTitleColor, for: .selected)
            item_btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            item_btn.setTitle(itemStr, for: .normal)
            item_btns.append(item_btn)
        }
    
        reframeItems()
    }
    
    //configure Frame
    private func reframeItems(){
        guard items.count > 0 else {
            return
        }
        let heigh = self.frame.size.height - LineHigh
        
        contentScroll.frame = super.bounds
        self.addSubview(contentScroll)
        
        for (index,item_btn) in item_btns.enumerated() {
            item_btn.removeFromSuperview()
            item_btn.tag = index
            
            switch type {
            
            case .average:
                let width = dScreenW/CGFloat(items.count)
                item_btn.frame = CGRect.init(x: CGFloat(index) * width, y: CGFloat(0), width: width, height: heigh)
                
            case .onebyone:
                item_btn.sizeToFit()
                let width = item_btn.frame.size.width
                let lastIndex = index == 0 ? index : index - 1
                let x = index == 0 ? ItemPadding:item_btns[lastIndex].frame.maxX + ItemPadding
                item_btn.frame = CGRect.init(x:x, y: CGFloat(0), width: width, height: heigh)
                
//            default: break
            }
            contentScroll.addSubview(item_btn)
        }

        contentScroll.contentSize = CGSize.init(width:(item_btns.last?.frame.maxX ?? 0)+16, height: heigh)
        
        index = 0
        
//        let tempBtn:UIButton = item_btns[index].copy() as! UIButton
//        tempBtn.sizeToFit()
//        let tempFrame = tempBtn.frame
//
//        selectedLine.frame = CGRect.init(x: tempFrame.minX + LinePadding, y: self.height-3, width: tempFrame.width, height: LineHigh)
//        selectedLine.centerX = item_btns[index].centerX

        contentScroll.layer.addSublayer(selectedLine)
        
        cutLine.frame = CGRect.init(x:0, y:self.height-1, width:self.width, height: 1)
        self.layer.addSublayer(cutLine)
        
    }
}
