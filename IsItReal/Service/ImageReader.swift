//
//  ImageReader.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 14/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//
import UIKit
import Vision

class ImageReader {
    func perform(on url: URL?, recognitionLevel: VNRequestTextRecognitionLevel) -> String  {
        var stringResult = ""
        guard let url = url else { return "" }
        
        let requestHandler = VNImageRequestHandler(url: url, options: [:])
        
        let request = VNRecognizeTextRequest  { (request, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
            
            for currentObservation in observations {
                let topCandidate = currentObservation.topCandidates(1)
                if let recognizedText = topCandidate.first {
                    stringResult.append(recognizedText.string)
                }
            }
        }
        request.recognitionLevel = recognitionLevel
        
        try? requestHandler.perform([request])
        

        return stringResult
    }
}
