//
//  DogBreedTests.swift
//  DogBreedsTests
//
//  Created by Bola Fayez on 03/11/2022.
//

import XCTest
@testable import DogBreeds

class DogBreedTests: XCTestCase {

    // MARK: - Properties
    private var repository: DogBreedRepository!
    private var viewModel: DogBreedViewModel!
    private var remoteDataSource: DogBreedRemoteDataSource!
    private var localDataSource: DogBreedLocalDataSource!

    // MARK: - tearDown
    override func tearDown() {
        
        repository = nil
        viewModel = nil
        remoteDataSource = nil
        localDataSource = nil
        
        super.tearDown()
    }
    
    // MARK: - testFetchDogBreedImages
    func testFetchDogBreedImages() {
        
        repository = DogBreedRepository(remoteDataSource: MockRemoteDataSourceDogBreed(), localDataSource: MockLocalDataSourceDogBreed())
        
        repository.fetchDogBreedImages(breedName: "african", completion: { result in
            switch result {
            case .success(let bogBreedImages):
                XCTAssertNotNil(bogBreedImages.message)
                XCTAssertTrue(bogBreedImages.message.count > 0)
            case .failure(let error):
                XCTAssertNotNil(error.getStringError())
            }
        })
        
    }
    
    // MARK: - testLoadFavoriteBogBreed
    func testLoadFavoriteBogBreed() {
        
        repository = DogBreedRepository(remoteDataSource: MockRemoteDataSourceDogBreed(), localDataSource: MockLocalDataSourceDogBreed())
        
        XCTAssertNotNil(repository.getAllFavBreed())
    }
    
    // MARK: - testLoadDogBreed
    func testLoadDogBreed() {
        
        let breedImages = ["https://images.dog.ceo/breeds/african/n02116738_10024.jpg",
                           "https://images.dog.ceo/breeds/african/n02116738_10038.jpg"]
        
        viewModel = DogBreedViewModel(breed: "african", breeds: breedImages, dogBreedRepository: DogBreedRepository(remoteDataSource: MockRemoteDataSourceDogBreed(), localDataSource: MockLocalDataSourceDogBreed()))

        viewModel.fetchDogBreedImages(completion: { [weak self] result in
            
            switch result {
            case .success:
                
                XCTAssertEqual(self?.viewModel.countOfBreeds, 2)
                
                if let firstImage = self?.viewModel.breedImagesBy(name: "african")?.first {
                    XCTAssertEqual(firstImage.imageURL, "https://images.dog.ceo/breeds/african/n02116738_10024.jpg")
                } else {
                    XCTFail("This should not happen.")
                }
                
                if let lastImage = self?.viewModel.breedImagesBy(name: "african")?.last {
                    XCTAssertEqual(lastImage.imageURL, "https://images.dog.ceo/breeds/african/n02116738_10038.jpg")
                } else {
                    XCTFail("This should not happen.")
                }
                
                XCTAssertNotNil(self?.viewModel.breedAt(index: 0))
                
            case .failure:
                XCTFail("This should not happen.")
            }
            
        })
        
    }
    
    // MARK: - testRetrivedLocalData
    func testRetrivedLocalData() {
        
        localDataSource = DogBreedLocalDataSource()
        
        XCTAssertNotNil(localDataSource.loadBreeds())
    }
    
    // MARK: - testRetrivedRemoteData
    func testRetrivedRemoteData() {
        
        let mockData = DogBreedModel.parse(jsonFile: "dog_breed")
        let bogBreedAPI = BogBreedAPITests(data: mockData)
        remoteDataSource = DogBreedRemoteDataSource(communicationManagerProtocol: bogBreedAPI)

        remoteDataSource.fetchDogBreed(breedName: "african", completion: { result in
            switch result {
            case .success(let dogBreedsModel):
                XCTAssertNotNil(dogBreedsModel.message)
                XCTAssertTrue(dogBreedsModel.message.count > 0)
            case .failure(let error):
                XCTAssertNotNil(error.getStringError())
            }
        })

    }
    
}

// MARK: - Mocks
extension DogBreedTests {
    
    // MARK: - MockRemoteDataSourceDogBreed
    struct MockRemoteDataSourceDogBreed: DogBreedRemoteDataSourceProtocol {
        
        private let dogBreedModel = DogBreedModel(message: ["https://images.dog.ceo/breeds/african/n02116738_10024.jpg",
                                                            "https://images.dog.ceo/breeds/african/n02116738_10038.jpg"], status: "success")
        
        
        // MARK: - fetchDogBreed
        func fetchDogBreed(breedName: String, completion: @escaping (Result<DogBreedModel, ErrorManager>) -> Void) {
            completion(.success(dogBreedModel))
        }
        
    }
    
    // MARK: - MockLocalDataSourceDogBreed
    struct MockLocalDataSourceDogBreed: DogBreedLocalDataSourceProtocol {

        
        private let dogBreeds = [
            DogBreedLayoutViewModel.DogBreedImageLayoutViewModel(breedName: "african", imageURL: "https://images.dog.ceo/breeds/african/n02116738_10024.jpg", isFav: true),
            DogBreedLayoutViewModel.DogBreedImageLayoutViewModel(breedName: "african", imageURL: "https://images.dog.ceo/breeds/african/n02116738_10038.jpg", isFav: true)]
        
        
        func saveBreed(breedName: String, breed: DogBreedLayoutViewModel.DogBreedImageLayoutViewModel) {
            XCTAssertTrue(true)
        }
        
        func deleteBreed(dbBreed: DBDogBreed) {
            XCTAssertTrue(true)
        }
        
        func loadBreeds() -> [DogBreedLayoutViewModel.DogBreedImageLayoutViewModel] {
            return dogBreeds
        }
        
    }
           
}
