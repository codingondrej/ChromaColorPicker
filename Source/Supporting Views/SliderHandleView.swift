//
//  SliderHandleView.swift
//  ChromaColorPicker
//
//  Created by Jon Cardasis on 4/13/19.
//  Copyright © 2019 Jonathan Cardasis. All rights reserved.
//

import UIKit

public class SliderHandleView: UIView {

    public var handleColor: UIColor = .black {
        didSet { updateHandleColor(to: handleColor) }
    }
    
    public var borderWidth: CGFloat = 3.0 {
        didSet { layoutNow() }
    }
    
    public var borderColor: UIColor = .white {
        didSet { layoutNow() }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    public override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return gestureRecognizer is UIPanGestureRecognizer ? false : true
    }
    
    override public func layoutSubviews() {
        // Circle
        handleLayer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: bounds.height, height: bounds.height), cornerRadius: bounds.height / 2).cgPath
        handleLayer.strokeColor = borderColor.cgColor
        handleLayer.lineWidth = borderWidth
        handleLayer.position = CGPoint(x: 0, y: 0)
    }
    
    // MARK: - Private
    private let handleLayer = CAShapeLayer()
    
    private func commonInit() {
        layer.addSublayer(handleLayer)
        updateHandleColor(to: handleColor)
    }
    
    private func updateHandleColor(to color: UIColor) {
        handleLayer.fillColor = color.cgColor
    }
}
