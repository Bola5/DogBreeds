//
//  DogBreedsTests.swift
//  DogBreedsTests
//
//  Created by Bola Fayez on 03/11/2022.
//

import XCTest
@testable import DogBreeds

class DogBreedsTests: XCTestCase {

    // MARK: - Properties
    private var viewModel: DogBreedsViewModel!
    private var dataSource: DogBreedsRemoteDataSource!

    // MARK: - tearDown
    override func tearDown() {
        
        viewModel = nil
        dataSource = nil
        
        super.tearDown()
    }
    
    // MARK: - testRetrivedRemoteData
    func testRetrivedRemoteData() {

        let mockData = DogBreedsModel.parse(jsonFile: "dog_breeds")
        let bogBreedsAPI = BogBreedsAPITests(data: mockData)
        dataSource = DogBreedsRemoteDataSource(communicationManagerProtocol: bogBreedsAPI)

        dataSource.fetchDogBreedsList(completion: { result in
            switch result {
            case .success(let dogBreedsModel):
                XCTAssertNotNil(dogBreedsModel.message)
                XCTAssertTrue(dogBreedsModel.message?.count ?? 0 > 0)
            case .failure(let error):
                XCTAssertNotNil(error.getStringError())
            }
        })

    }
    
    // MARK: - testFetchDogBreeds
    func testFetchDogBreeds() {
                
        viewModel = DogBreedsViewModel(dogBreedsDataSource: MockRemoteDataSourceDogBreeds())
        
        viewModel.fetchDogBreedsList(completion: { [weak self] result in
            switch result {
                
            case .success:
                
                XCTAssertEqual(self?.viewModel.countOfBreeds, 2)
                
                if let firstDogBreedName = self?.viewModel.breedAt(index: 0) {
                    
                    XCTAssertEqual(firstDogBreedName, "Affenpinscher")
                    
                } else {
                    XCTFail("This should not happen.")
                }
                
                
                if let lastDogBreedName = self?.viewModel.breedAt(index: 1) {
                    
                    XCTAssertEqual(lastDogBreedName, "Bulldog")
                    
                    if let dogBreeds = self?.viewModel.breedsBy(name: lastDogBreedName.lowercased()) {
                        
                        if let firstDogBreedName = dogBreeds.first {
                            
                            XCTAssertEqual(firstDogBreedName, "boston")

                        } else {
                            XCTFail("This should not happen.")
                        }
                        
                        if let lastDogBreedName = dogBreeds.last {
                            
                            XCTAssertEqual(lastDogBreedName, "french")

                        } else {
                            XCTFail("This should not happen.")
                        }
                        
                        
                    } else {
                        XCTFail("This should not happen.")
                    }
                    
                } else {
                    XCTFail("This should not happen.")
                }
                
            case .failure:
                XCTFail("This should not happen.")
            }
        })
        
    }

}

// MARK: - Mocks
extension DogBreedsTests {
    
    // MARK: - MockRemoteDataSourceDogBreeds
    struct MockRemoteDataSourceDogBreeds: DogBreedsRemoteDataSourceProtocol {

        private let dogBreedsModel = DogBreedsModel(message: ["affenpinscher":[""],
                                                              "bulldog":["boston", "english", "french"]],
                                                    status: "success")
        
        // MARK: - fetchDogBreedsList
        func fetchDogBreedsList(completion: @escaping (Result<DogBreedsModel, ErrorManager>) -> Void) {
            completion(.success(dogBreedsModel))
        }
        
    }
           
}
