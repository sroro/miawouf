//
//  FormViewController.swift
//  miawouf
//
//  Created by Rodolphe Schnetzer on 07/03/2020.
//  Copyright © 2020 Rodolphe Schnetzer. All rights reserved.
//

import UIKit

class FormViewController: UIViewController, UIPickerViewDataSource , UIPickerViewDelegate {
    
    var dog: Pet!
    
    
    
    // MARK: - IBActions
    @IBAction func validate(_ sender: UIButton) {
        createPetObject()
        checkPetStatus()
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
            nameText.resignFirstResponder() // ferme le clavier au toucher de lecran
            numberText.resignFirstResponder() // ferme le clavier au toucher de lecran
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var numberText: UITextField!
    @IBOutlet weak var genderChoice: UISegmentedControl!
    @IBOutlet weak var age: UISwitch!
    @IBOutlet weak var race: UIPickerView!
    
    // MARK: - Functions
    
    // PickerviewDataSource. cette func informe le nombre de colone
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        // PickerviewDataSource. cette func informe le nombre d'éléments par colone
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dogRaces.count
    }

        // PickerviewDelegate. cette func informe quoi afficher
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dogRaces[row]
    }

    
    private func createPetObject() {
        let name = nameText.text // text est de type String? si rien est entrée ça renvoi nil
        let phone = numberText.text
        let hasMajority = age.isOn
        let genderIndex = genderChoice.selectedSegmentIndex // Cette propriété est un entier, qui représente l'index du segment sélectionné. Comme n'importe quel index, il commence à zéro. Donc si le premier segment est sélectionné, la propriété renvoie 0.
        var gender: Pet.Gender
        if genderIndex == 0 {
            gender = .male
        } else {
            gender = .female
        }
        let raceIndex = race.selectedRow(inComponent: 0)
        let race = dogRaces[raceIndex]
        
        dog = Pet(name: name, hasMajority: hasMajority, phone: phone, race: race, gender: gender)
   
    }
    // envoyer les données à un autre controller en 3 étapes
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToSuccess" { // 1: identifier le segue
            let successVC = segue.destination as! SuccessViewController //2: récupérer le controller de destination
            successVC.dog = dog // 3: envoyer au controller voulu les données
        }
    }
    
    private func checkPetStatus() {
        
        switch dog.status {
        case .accepted:
            performSegue(withIdentifier: "segueToSuccess", sender: self)
        case .rejected(let error):
           presentAlert(with: error)
        }
    }
    
    private func presentAlert(with error: String){
        let alertVC = UIAlertController(title: "Erreur", message: error, preferredStyle: .alert) // créer l'alerte
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil) // créer l'action
        alertVC.addAction(action) // ajout de l'action dans l'alerte
        present(alertVC, animated: true, completion: nil) // présenter l'alerte
    }
   
}
