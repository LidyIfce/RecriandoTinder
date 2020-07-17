//
//  MatchViewController.swift
//  RecriandoTinder
//
//  Created by Lidiane Gomes Barbosa on 17/07/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit


class MatchViewController: UIViewController {
    
    let imageView: UIImageView = .fotoImageView(named: "pessoa-1")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        imageView.preencherSuperView()
        
        
        view.backgroundColor = UIColor.blue
    }
}
