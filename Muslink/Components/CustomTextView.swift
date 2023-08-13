//
//  CustomTextView.swift
//  Muslink
//
//  Created by Аброрбек on 13.08.2023.
//

import UIKit

final class CustomTextView: UIView {
    
    var text: String? {
        didSet{
            if text?.count != 0 {
                textView.text = text
                textView.textColor = .black
            }
        }
    }
    
    func setTextColor(color: UIColor){
        textView.textColor = color
    }
    
    init(delegate: UITextViewDelegate){
        super.init(frame: .zero)
        textView.delegate = delegate
        
        setupTextView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBInspectable var keyboardType: UIKeyboardType = .default {
        didSet {
            textView.keyboardType = keyboardType
        }
    }
    
    private func setupTextView(){
        self.backgroundColor = Color.neutral16.color
        self.addSubview(textView)
        setupLayout()
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            textView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
            textView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
    }
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        textView.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        textView.backgroundColor = .clear
        textView.layer.cornerRadius = 16.0
        textView.textAlignment = .left
        textView.sizeToFit()
        textView.isScrollEnabled = false
        textView.text = "История написания, чем вы вдохновлялись и другие детали"
        textView.textColor = Color.neutral32.color
        
        return textView
    }()
}
