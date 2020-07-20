//
//  DetalhePerfilCell.swift
//  RecriandoTinder
//
//  Created by Lidiane Gomes Barbosa on 20/07/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit

class DetalhePerfilCell: UICollectionViewCell {
    let nomeLabel: UILabel = .textBoldLabel(32)
    let idadeLabel: UILabel = .textLabel(28)
    let fraseLabel:UILabel = .textLabel(18)
    
    var usuario:Usuario?{
        didSet{
            if let usuario = usuario{
                nomeLabel.text = usuario.nome
                idadeLabel.text = String(usuario.idade)
                fraseLabel.text = usuario.frase
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        
        let nomeIdadeStackView = UIStackView(arrangedSubviews: [nomeLabel, idadeLabel, UIView()])
        nomeIdadeStackView.spacing = 12
        
        let stackView = UIStackView(arrangedSubviews: [nomeIdadeStackView, fraseLabel])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        
        
        addSubview(stackView)
        stackView.preencherSuperView(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
