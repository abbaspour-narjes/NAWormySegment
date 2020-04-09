//
//  NAWormySegment.swift
//  NAWormySegment
//
//  Created by anna on 1/16/1399 AP.
//  Copyright © 1399 abbaspour. All rights reserved.
//

import UIKit

@IBDesignable class NAWormySegment : UIControl{
    
    @IBInspectable var textColor:UIColor = UIColor.blue{
        didSet{
            for label in labels{
                label.textColor = textColor
            }
        }
    }
    
    @IBInspectable var BGColor:UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.6049871575){
        didSet{
            backgroundColor = BGColor
        }
    }
    
    @IBInspectable var selectedColor:UIColor = UIColor.white{
        didSet{
            thumbView.backgroundColor = selectedColor
        }
    }
    
    @IBInspectable  var items :[String] = ["Music","Movies","Apps","Setting"] {
          didSet{
              setupLabels()
          }
      }
    
    
    internal var labels:[UILabel]    = []
    internal var thumbView           = UIView()
   
    private var selectedIndex: Int = 0 {
        didSet{
            showSelectedIndex(oldSelected: oldValue)
        }
    }
    
    // - MARK: Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // - MARK: Functions
    
    func setupView(){
        layer.cornerRadius       = frame.height / 2
        clipsToBounds            = true
        backgroundColor          = BGColor
        setupLabels()
        insertSubview(thumbView, at: 0)
        var selectedFrame               = self.bounds
        let newWidth                    = selectedFrame.width / CGFloat(items.count)
        selectedFrame.size.width        = newWidth
        thumbView.frame                 = selectedFrame
    }
    
    func setupLabels(){
        for label in labels{
            label.removeFromSuperview()
        }
        labels.removeAll()
        
        for item in items{
            let label           = UILabel(frame: CGRect.zero)
            label.text          = item
            label.textAlignment = .center
            label.textColor     = textColor
            self.addSubview(label)
            labels.append(label)
        }
    }
    
    fileprivate func performAnimation(_ actionFrame: CGRect, _ newFrame: CGRect) {
        let animationDuration = 0.3
        UIView.animate(withDuration: animationDuration) {
            self.thumbView.frame = actionFrame
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            UIView.animate(withDuration: animationDuration) {
                self.thumbView.frame = newFrame
            }
        }
    }
    
    func showSelectedIndex(oldSelected:Int){
        let newFrame    =  labels[selectedIndex].frame
        let oldFrame    = labels[oldSelected].frame
        var actionFrame = newFrame
        
        if selectedIndex > oldSelected { // go forward
            let width = newFrame.size.width * CGFloat(selectedIndex - oldSelected + 1)
            actionFrame = CGRect(x: oldFrame.origin.x, y: newFrame.origin.y, width:width , height: newFrame.size.height)
            performAnimation(actionFrame, newFrame)
        }else if selectedIndex < oldSelected { // go backward
            if selectedIndex == 0 && oldSelected == labels.count - 1 {
                // exception move for end to start of segment
                let copyThumpView =  thumbView.copyView()
                copyThumpView.layer.cornerRadius = thumbView.layer.cornerRadius
                copyThumpView.clipsToBounds = true
                copyThumpView.backgroundColor = thumbView.backgroundColor
                insertSubview(copyThumpView, at: 0)
                
                let nonframe = CGRect(x: 0, y: oldFrame.origin.y, width: 0, height: oldFrame.height)
                self.thumbView.frame = nonframe
                
                let animationDuration = 0.3
                UIView.animate(withDuration: animationDuration) {
                    self.thumbView.frame = newFrame
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                    UIView.animate(withDuration: animationDuration, animations: {
                        copyThumpView.frame = CGRect(x: oldFrame.origin.x + oldFrame.width, y: oldFrame.origin.y, width: 0, height: oldFrame.height)
                        
                    }, completion: { (didEnd) in
                        if didEnd{
                            copyThumpView.removeFromSuperview()
                        }
                    })
                }
                
            }else{
                let width = newFrame.size.width * CGFloat( oldSelected - selectedIndex + 1)
                actionFrame = CGRect(x: newFrame.origin.x, y: newFrame.origin.y, width:width , height: newFrame.size.height)
                performAnimation(actionFrame, newFrame)
            }
        }
        
        
        
    }
    
    // - MARK: Delegate
    
    override func layoutSubviews() {
        super.layoutSubviews()
        thumbView.backgroundColor       = selectedColor
        thumbView.clipsToBounds         = true
        thumbView.layer.cornerRadius    = thumbView.frame.height / 2
        
        let labelHeight = self.frame.height
        let labelWidth  = self.frame.width / CGFloat(labels.count)
        
        for (index,label) in labels.enumerated(){
            let newxPosition = CGFloat(index) * labelWidth
            let newRect = CGRect(x: newxPosition, y: 0, width: labelWidth, height: labelHeight)
            label.frame = newRect
        }
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        
        for (index,item) in labels.enumerated(){
            if item.frame.contains(location){
                selectedIndex = index
                sendActions(for: .valueChanged)
            }
        }
        
        return false
    }
}



extension UIView
{
    func copyView<T: UIView>() -> T {
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as! T
    }
}
