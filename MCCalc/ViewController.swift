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
        let nota:Float = (Float((correctas - (incorrectas / (opciones - 1))) / preguntas * 10))
        notaLabel.stringValue = String(format: "%.2f", round(nota/0.25)*0.25)
        
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

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        numeroPreguntasTextField.becomeFirstResponder()
    }


}

