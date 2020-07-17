//
//  CombineViewController.swift
//  RecriandoTinder
//
//  Created by Lidiane Gomes Barbosa on 14/07/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit

enum Acao{
    case like, deslike, superlike
}

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
        
        let loading = Loading(frame: view.frame)
        view.insertSubview(loading, at: 0)
        
        self.adicionarHeader()
        self.adicionarFooter()
        self.buscarUsuarios()
        
    }
    
    func buscarUsuarios(){
        UsuarioService.shared.buscaUsuarios{ (usuarios, err) in
            if let usuarios = usuarios{
                DispatchQueue.main.async{
                    self.usuarios = usuarios
                    self.adicionarCards()
                }
            }
        }
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
        
        
        deslikeButton.addTarget(self, action: #selector(deslikeClique), for: .touchUpInside)
        likeButton.addTarget(self, action: #selector(likeClique), for: .touchUpInside)
        superlikeButton.addTarget(self, action: #selector(superlikeClique), for: .touchUpInside)
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
            
            card.callback = { (data) in
              //  self.visualizarDetalhe(usuario: data)
                print(data)
            }
             
            let gesture = UIPanGestureRecognizer()
            gesture.addTarget(self, action: #selector(handlerCard))
             
            card.addGestureRecognizer(gesture)
                
            view.insertSubview(card, at: 1)
        }
    }
    
    
    func removerCard(card: UIView){
        card.removeFromSuperview()
        
        usuarios.removeAll { (usuario) -> Bool in
            usuario.id == card.tag
        }
    }
    
    func verificarMatch(usuario:Usuario){
        if usuario.match{
            print("Wooow!")
        }
    }
    
    func visualizarDetalhe(usuario:Usuario){
        let detalheVC = UIViewController()
        detalheVC.view.backgroundColor = .red
        detalheVC.modalPresentationStyle = .fullScreen
        
        self.present(detalheVC, animated: true, completion: nil)
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
                
                if card.center.x > self.view.bounds.width + 50{
                    animarCard(rotatingAngle: rotationAngle, acao: .like)
                    return
                }
                if card.center.x < -50{
                    animarCard(rotatingAngle: rotationAngle, acao: .deslike)
                    return
                }
                
                UIView.animate(withDuration: 0.2){
                    card.center = self.view.center
                    card.transform = .identity
                    
                    card.likeImageView.alpha = 0
                    card.deslikeImageView.alpha = 0
                }
            }
        }
    }
    
    
    @objc func deslikeClique(){
        self.animarCard(rotatingAngle: -0.4, acao: .deslike)
    }
    
    @objc func likeClique(){
        self.animarCard(rotatingAngle: 0.4, acao: .like)
    }
    
    @objc func superlikeClique(){
           self.animarCard(rotatingAngle: 0, acao: .superlike)
       }
       
    
    func animarCard(rotatingAngle: CGFloat, acao: Acao){
        
        if let usuario = self.usuarios.first{
            for view in self.view.subviews{
                if view.tag == usuario.id{
                    if let card = view as? CombineCardView{
                        let center: CGPoint
                        
                        var like:Bool
                        
                        switch acao {
                        case .like:
                            center = CGPoint(x: card.center.x + self.view.bounds.width, y: card.center.y + 50)
                            like = true
                        case .deslike:
                            center = CGPoint(x: card.center.x - self.view.bounds.width, y: card.center.y + 50)
                            like = false
                        case .superlike:
                            center = CGPoint(x: card.center.x, y: card.center.y - self.view.bounds.height)
                            like = true
                        }
                        
                        UIView.animate(withDuration: 0.3, animations: {
                            card.center = center
                            card.transform = CGAffineTransform(rotationAngle: rotatingAngle)
                            
                            card.likeImageView.alpha = like ? 1 : 0
                            card.deslikeImageView.alpha = like ? 0 : 1
                        }){ ( _ ) in
                            
                            if like{
                                self.verificarMatch(usuario: usuario)
                            }
                            self.removerCard(card: card)
                        }
                    }
                }
            }
        }
    }
}
