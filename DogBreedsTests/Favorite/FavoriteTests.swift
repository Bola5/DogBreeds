//
//  FavoriteTests.swift
//  DogBreedsTests
//
//  Created by Bola Fayez on 04/11/2022.
//

import XCTest
@testable import DogBreeds

class FavoriteTests: XCTestCase {

    // MARK: - Properties
    private var viewModel: FavoriteViewModel!

    // MARK: - tearDown
    override func tearDown() {
        
        viewModel = nil
        
        super.tearDown()
    }
    
    // MARK: - testLoadFavorite
    func testLoadFavorite() {
        
        viewModel = FavoriteViewModel(dataSource: MockLocalDataSourceDogBreed())
        
        viewModel.loadFavoriteBreedsName(completion: { [weak self] in
            
            XCTAssertEqual(self?.viewModel.countOfBreedNames, 1)
            XCTAssertEqual(self?.viewModel.countOfImagesByBreedName(), 2)
            
            if let name = self?.viewModel.breedNameAt(index: 0)?.breedName {
                XCTAssertEqual(name, "african")
            } else {
                XCTFail("This should not happen.")
            }
            
            if let imageURL = self?.viewModel.breedImageAt(index: 0) {
                XCTAssertEqual(imageURL, "https://images.dog.ceo/breeds/african/n02116738_10024.jpg")
            } else {
                XCTFail("This should not happen.")
            }
            
        })
        
    }

}

// MARK: - Mocks
extension FavoriteTests {
    
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
