//
//  CombineViewController.swift
//  RecriandoTinder
//
//  Created by Lidiane Gomes Barbosa on 14/07/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit

class CombineViewController: UIViewController{
    
    var perfilButton: UIButton = .iconMenu(named: "icone-perfil")
    var chatButton: UIButton = .iconMenu(named: "icone-chat")
    var logoButton: UIButton = .iconMenu(named: "icone-logo")
    
    var deslikeButton: UIButton = .iconFooter(named: "icone-deslike")
    var superlikeButton: UIButton = .iconFooter(named: "icone-superlike")
    var likeButton: UIButton = .iconFooter(named: "icone-like")
    
    var usuarios : [Usuario] = []
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        view.backgroundColor = UIColor.systemGroupedBackground
        
        navigationController?.navigationBar.isHidden = true
        
        self.adicionarHeader()
        self.adicionarFooter()
        self.buscarUsuarios()
        
    }
    
    func buscarUsuarios(){
        self.usuarios = UsuarioService.shared.buscaUsuarios()
        self.adicionarCards()
    }
   
}


extension CombineViewController{
    
    func adicionarHeader(){
        
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        let top: CGFloat = window?.safeAreaInsets.top ?? 44
        
       let stackView = UIStackView(arrangedSubviews: [perfilButton, logoButton, chatButton])
       stackView.distribution = .equalCentering
       
       view.addSubview(stackView)
    stackView.preencher(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: nil, padding: .init(top: top, left: 16, bottom: 0, right: 16))
   }
    
    func adicionarFooter(){
        let stackView = UIStackView(arrangedSubviews: [UIView(),deslikeButton, superlikeButton, likeButton, UIView()])
        stackView.distribution = .equalCentering
        
        view.addSubview(stackView)
        stackView.preencher(top: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, padding: .init(top: 0, left: 16, bottom: 32, right: 16))
    }
}


extension CombineViewController{
    
    func adicionarCards(){

        for usuario in usuarios{
        
            let card = CombineCardView()
         
             
            card.frame = CGRect(x: 0, y: 0, width: view.bounds.width - 32, height: view.bounds.height * 0.7)
            card.center = view.center
            card.usuario = usuario
            card.tag = usuario.id
             
            let gesture = UIPanGestureRecognizer()
            gesture.addTarget(self, action: #selector(handlerCard))
             
            card.addGestureRecognizer(gesture)
                
            view.insertSubview(card, at: 0)
        }
    }
}

extension CombineViewController{
    
    @objc func handlerCard(_ gesture: UIPanGestureRecognizer){
        if let card = gesture.view as? CombineCardView {
            let point = gesture.translation(in: view)
            
            card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
            
            let rotationAngle = point.x / view.bounds.width * 0.4
            
            if point.x > 0{
                card.likeImageView.alpha = rotationAngle * 5
                card.deslikeImageView.alpha = 0
            }else{
                card.likeImageView.alpha = 0
                card.deslikeImageView.alpha = rotationAngle * 5 * -1
            }
            
            card.transform = CGAffineTransform(rotationAngle: rotationAngle)
            
            if gesture.state == .ended{
                UIView.animate(withDuration: 0.2){
                    card.center = self.view.center
                    card.transform = .identity
                    
                    card.likeImageView.alpha = 0
                    card.deslikeImageView.alpha = 0
                }
            }
        }
    }
}
