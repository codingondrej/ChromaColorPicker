//
//  ViewController.swift
//  ChromaColorPicker-Demo
//
//  Created by Cardasis, Jonathan (J.) on 8/11/16.
//  Copyright © 2016 Jonathan Cardasis. All rights reserved.
//

import UIKit
import ChromaColorPicker

class ViewController: UIViewController {
    @IBOutlet weak var colorDisplayView: UIView!
    
    let colorPicker = ChromaColorPicker()
    let brightnessSlider = ChromaBrightnessSlider()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupColorPicker()
        setupBrightnessSlider()
        setupColorPickerHandles()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Private
    private var homeHandle: ChromaColorHandle! // reference to home handle
    
    private func setupColorPicker() {
        colorPicker.delegate = self
        colorPicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(colorPicker)
        
        let verticalOffset = -defaultColorPickerSize.height / 6
        
        NSLayoutConstraint.activate([
            colorPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            colorPicker.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: verticalOffset),
            colorPicker.widthAnchor.constraint(equalToConstant: defaultColorPickerSize.width),
            colorPicker.heightAnchor.constraint(equalToConstant: defaultColorPickerSize.height)
        ])
    }
    
    private func setupBrightnessSlider() {
        brightnessSlider.connect(to: colorPicker)
        
        // Style
        brightnessSlider.trackColor = UIColor.blue
        brightnessSlider.showsShadow = false
        brightnessSlider.borderWidth = 0
        brightnessSlider.handle.borderWidth = 3.0 // Example of customizing the handle's properties.
        
        // Layout
        brightnessSlider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(brightnessSlider)
        
        NSLayoutConstraint.activate([
            brightnessSlider.centerXAnchor.constraint(equalTo: colorPicker.centerXAnchor),
            brightnessSlider.topAnchor.constraint(equalTo: colorPicker.bottomAnchor, constant: 28),
            brightnessSlider.widthAnchor.constraint(equalTo: colorPicker.widthAnchor, multiplier: 0.9),
            brightnessSlider.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func setupColorPickerHandles() {
        // (Optional) Assign a custom handle size - all handles appear as the same size
        // colorPicker.handleSize = CGSize(width: 48, height: 60)
        
        // 1. Add handle and then customize
        addHomeHandle()
        
        // 2. Add a handle via a color
        let peachColor = UIColor(red: 1, green: 203 / 255, blue: 164 / 255, alpha: 1)
        colorPicker.addHandle(at: peachColor)
        
        // 3. Create a custom handle and add to picker
        let customHandle = ChromaColorHandle()
        customHandle.color = UIColor.purple
        colorPicker.addHandle(customHandle)

        let firstHandleLabel = UILabel()
         [firstHandleLabel].forEach {
                    $0.font = UIFont.systemFont(ofSize: 17, weight: .heavy)
                    $0.textColor = .white
                    $0.textAlignment = .center
            $0.backgroundColor = UIColor.red.withAlphaComponent(0.3)
                }

                firstHandleLabel.text = "2"
                homeHandle.handleSize = 45
                homeHandle.accessoryView = firstHandleLabel
                homeHandle.borderWidth = 3
    }
    
    private func addHomeHandle() {
        homeHandle = colorPicker.addHandle(at: .blue)
        
        // Setup custom handle view with insets
        let customImageView = UIImageView(image: #imageLiteral(resourceName: "home").withRenderingMode(.alwaysTemplate))
        customImageView.contentMode = .scaleAspectFit
        customImageView.tintColor = .white
        homeHandle.accessoryView = customImageView
        homeHandle.accessoryViewEdgeInsets = .zero//UIEdgeInsets(top: 2, left: 4, bottom: 4, right: 4)
    }
}

extension ViewController: ChromaColorPickerDelegate {
    func colorPickerHandleDidChange(_ colorPicker: ChromaColorPicker, handle: ChromaColorHandle, to color: UIColor) {
        colorDisplayView.backgroundColor = color
        
        // Here I can detect when the color is too bright to show a white icon
        // on the handle and change its tintColor.
        if handle === homeHandle, let imageView = homeHandle.accessoryView as? UIImageView {
            let colorIsBright = color.isLight
            
            UIView.animate(withDuration: 0.2, animations: {
                imageView.tintColor = colorIsBright ? .black : .white
            }, completion: nil)
        }
    }
}


private let defaultColorPickerSize = CGSize(width: 320, height: 320)
private let brightnessSliderWidthHeightRatio: CGFloat = 0.1
