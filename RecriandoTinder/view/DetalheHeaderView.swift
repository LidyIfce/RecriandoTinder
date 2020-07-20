//
//  DetalheHeaderView.swift
//  RecriandoTinder
//
//  Created by Lidiane Gomes Barbosa on 20/07/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit

class DetalheHeaderView: UICollectionReusableView {
    
    var fotoImageView: UIImageView = .fotoImageView(named: "pessoa-1")
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(fotoImageView)
        fotoImageView.preencherSuperView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
