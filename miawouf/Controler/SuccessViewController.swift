//
//  SuccessViewController.swift
//  miawouf
//
//  Created by Rodolphe Schnetzer on 07/03/2020.
//  Copyright © 2020 Rodolphe Schnetzer. All rights reserved.
//

import UIKit

class SuccessViewController: UIViewController {
    
    var dog: Pet!
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var labelSuccess: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        labelSuccess.text = """
        Wouf de bienvenue à \(dog.name!) !
        Vous avez bien été ajouté à notre base de données ! Nous vous enverrons un SMS dès que nous avons une âme sœur à vous proposer !
        """
    }
    

   
}
