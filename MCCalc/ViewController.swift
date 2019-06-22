//
//  ViewController.swift
//  MCCalc
//
//  Created by Stephane Carteaux on 28/6/18.
//  Copyright © 2018 SCLab. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    //MARK: Properties
    @IBOutlet weak var numeroPreguntasTextField: NSTextField!
    @IBOutlet weak var numeroOpcionesTextField: NSTextField!
    @IBOutlet weak var correctasTextField: NSTextField!
    @IBOutlet weak var incorrectasTextField: NSTextField!
    @IBOutlet weak var notaLabel: NSTextField!
    
    enum CalcularError: Error {
        case generalError
        case opcionesError
    }
    
    // fuccion para calcular la nota redondeada
    func calcular () throws {
        guard let preguntas:Float = Float(numeroPreguntasTextField.stringValue) else {
            throw CalcularError.generalError
        }
        guard let opciones:Float = Float(numeroOpcionesTextField.stringValue) else {
            throw CalcularError.generalError
        }
        guard opciones >= 2 else {
            throw CalcularError.opcionesError
        }
        guard let correctas:Float = Float(correctasTextField.stringValue) else {
            throw CalcularError.generalError
        }
        guard let incorrectas:Float = Float(incorrectasTextField.stringValue) else {
            throw CalcularError.generalError
        }
        guard correctas + incorrectas <= preguntas else {
            throw CalcularError.generalError
        }
        let resultado:Float = (Float((correctas - (incorrectas / (opciones - 1))) / preguntas * 10))
        let nota:Float
        if resultado < 0 {
            nota = 0
        } else {
            nota = round(resultado/0.25)*0.25
        }
        notaLabel.stringValue = String(format: "%.2f", nota)
        
        // despues de efectuar el calculo, focus al campo de respuestas correctas
        correctasTextField.becomeFirstResponder()
    }
    
    //funccion para resetear los campos de numeros de respuesta correctas e incorresctas
    func reset() {
        correctasTextField.stringValue = ""
        incorrectasTextField.stringValue = ""
        notaLabel.stringValue = ""
        correctasTextField.becomeFirstResponder()
    }
    
    //MARK: Actions
    @IBAction func calcularButton(_ sender: NSButton) {
        do {
            try calcular ()
        } catch CalcularError.opcionesError {
            notaLabel.stringValue = ("Error!")
        } catch {
            notaLabel.stringValue = ("Error")
        }
    }
    
    @IBAction func resetButton(_ sender: NSButton) {
        reset()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Recupera los valores guardados de numero de preguntas y opciones
        let numeroPreguntas = UserDefaults.standard.string(forKey: "Preguntas") ?? ""
        let numeroOpciones = UserDefaults.standard.string(forKey: "Opciones") ?? ""
        
        // Assigna los valores guardados de numero de preguntas y opciones
        numeroPreguntasTextField.stringValue = numeroPreguntas
        numeroOpcionesTextField.stringValue = numeroOpciones
        
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        // Focus al campo de texto de respuestas correctas
        correctasTextField.becomeFirstResponder()

    }
    
    override func viewWillDisappear() {
        
        //Guarda los valores de numero de preguntas y opciones
        UserDefaults.standard.set(numeroPreguntasTextField.stringValue, forKey: "Preguntas")
        UserDefaults.standard.set(numeroOpcionesTextField.stringValue, forKey: "Opciones")
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

}

