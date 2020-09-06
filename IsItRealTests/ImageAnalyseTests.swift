//
//  ImageAnalyseTests.swift
//  IsItRealTests
//
//  Created by Vinicius Mesquita on 19/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import XCTest
@testable import IsItReal

class ImageAnalyseTests: XCTestCase {
    
    let imageReader = ImageReader()
    
    let textFromImageMock1 =
    " C. Conselho do FGTS aprova distribuiGao de R$ 7,5bilhoes para trabalhadores. Recursos serao depositadosaté 31 de agosto nas contas vinculadas. @MinEconomia .Translate Tweet7:22 AM . Aug 13, 2020 Twitter for iPhoneJair M. Bolsonaro•@jairbolsonaroDetalhes: bit.ly/3kDaTGz"
    
    let textFromImageMock2 =
    " Steve Troughton-smith •\"But this is just App Review's normal response\"should it be, though? None of this should be normal.We're numb to it as developers in the ecosystem, butApple completely cutting developers off from tooling &distribution, beyond malware reasons, is insane4:08 PM . Aug 17, 2020 . Twitter for Mac13\" @stroughtonsmith"
    
    let textFromImageMock3 =
    " Donald J. Trump • More Testing, which is a good thing (we have the most in the world), equals more Cases, which is Fake News Gold. They use Cases to demean the incredible job being done by the great men & women of the U.S. fighting the China Plague! 9:33 AM . Aug 11, 2020 Twitter for iPhone 2.6K Retweets and comments 9.7K Likes @realDonaldTrump"
    
    func test_getImageUrl_imageUrl()  {
        let url = imageReader.getUrlFromImage(forImageNamed: "ImageMock1")
        XCTAssertNotNil(url)
    }
    
    func test_getNotImageUrl_expectNil()  {
        let url = imageReader.getUrlFromImage(forImageNamed: "")
        XCTAssertNil(url)
    }
    
    func test_imageReader_textFromMockImage1() throws {
        // given
        let image = UIImage(named: "ImageMock1")
        // when
        let textFromImage = try imageReader.perform(on: image!, recognitionLevel: .fast)
        // then
        XCTAssertEqual(textFromImage, textFromImageMock1)
    }
    
    func test_imageReader_textFromMockImage2() throws {
        // given
        let image = UIImage(named: "ImageMock2")
        // when
        let textFromImage = try imageReader.perform(on: image!, recognitionLevel: .fast)
        // then
        XCTAssertEqual(textFromImage, textFromImageMock2)
    }
    
    func test_imageReader_textFromMockImage3() throws {
        // given
        let image = UIImage(named: "ImageMock3")
        // when
        let textFromImage = try imageReader.perform(on: image!, recognitionLevel: .fast)
        // then
        XCTAssertEqual(textFromImage, textFromImageMock3)
    }
    
    func test_impossibleToRead_error() throws {
        // given
        let image = UIImage(named: "LightSampleImage")
        // when
        let performSearchImage = { try self.imageReader.perform(on: image!, recognitionLevel: .fast) }
        // then
        XCTAssertThrowsError(try performSearchImage())
    }
    
    func test_createQuery_queryResultsSequence() throws {
        // given
        let queryResul = try imageReader.createQuery(text: textFromImageMock1, completion: { (tweet) in
            
        })
        
        // XCTAssertEqual(sequece, queryResul.keySearch)
    }
}
