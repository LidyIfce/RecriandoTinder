//
//  CombineCardView.swift
//  RecriandoTinder
//
//  Created by Lidiane Gomes Barbosa on 15/07/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit

class CombineCardView: UIView {
    
    let fotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pessoa-1")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
        
    }()
    
    let nomeLabel : UILabel = {
        let label = UILabel()
        label.text = "Ana Laura"
        return label
        
    }()
    let idadeLabel : UILabel = {
           let label = UILabel()
           label.text = "20"
           return label
           
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.borderWidth = 0.3
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 8
        clipsToBounds = true
        
        addSubview(fotoImageView)
        
        fotoImageView.preencherSuperView()
        
        let stackView = UIStackView(arrangedSubviews: [nomeLabel, idadeLabel])
        addSubview(stackView)
        
        stackView.preencher(top: nil, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor, padding: .init(top: 0, left: 16, bottom: 16, right: 16))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
