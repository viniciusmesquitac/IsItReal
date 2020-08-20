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
    "Jair M. Bolsonaro 1@jairbolsonaroC. Conselho do FGTS aprova distribuicao de R$ 7,5bilhoes para trabalhadores. Recursos serao depositadosaté 31 deagosto nascontas vinculadas. @MinEconomia .Detalhes: bit.ly/3kDaTGzTranslate Tweet7:22 AM • Aug 13, 2020Twitter for iPhone"
    
    let textFromImageMock2 =
    "Steve Troughton-Smith o@stroughtonsmith\"But this is just App Review's normal response\"...should it be, though? None of this should be normal.We're numb to it as developers in the ecosystem, butApple completely cutting developers off from tooling &distribution, beyond malware reasons, is insane4:08 PM • Aug 17, 2020Twitter for Mac"

    let textFromImageMock3 =
    "Donald J. Trump@realDonaldTrumpMore Testing, which is a good thing (we have the most inthe world), equals more Cases, which is Fake News Gold.They use Cases to demean the incredible job being doneby the great men & women of the. fighting the ChinaPlague!9:33 AM • Aug 11, 2020Twitter for iPhone2.6K Retweets and comments9.7K Likes"
    
    func test_getImageUrl_imageUrl()  {
        let url = imageReader.getUrlFromImage(forImageNamed: "ImageMock1")
        XCTAssertNotNil(url)
    }
    
    func test_imageReader_textFromMockImage1() throws {
        // given
        let imageUrl: URL? = imageReader.getUrlFromImage(forImageNamed: "ImageMock1")
        // when
        let textFromImage = try imageReader.perform(on: imageUrl, recognitionLevel: .accurate)
        // then
        XCTAssertEqual(textFromImage, textFromImageMock1)
    }
    
    func test_imageReader_textFromMockImage2() throws {
        // given
        let imageUrl: URL? = imageReader.getUrlFromImage(forImageNamed: "ImageMock2")
        // when
        let textFromImage = try imageReader.perform(on: imageUrl, recognitionLevel: .accurate)
        // then
        XCTAssertEqual(textFromImage, textFromImageMock2)
    }
    
    func test_imageReader_textFromMockImage3() throws {
        // given
        let imageUrl: URL? = imageReader.getUrlFromImage(forImageNamed: "ImageMock3")
        // when
        let textFromImage = try imageReader.perform(on: imageUrl, recognitionLevel: .accurate)
        // then
        XCTAssertEqual(textFromImage, textFromImageMock3)
    }
}
