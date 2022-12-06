# BogBreeds

## Onboarding
## Requirements
1 - Please use the last version from Xcode 13 or bigger

## Acceptance Criteria
1. List of Breeds
• Shows the list of breeds
• Navigates the app to Breed Pictures when the user taps any of the breeds • Has “favorites” button that navigates the app to Favorite

2. Breed Pictures
• Shows all the available pictures of a given breed
• Allows users to like/unlike specific images by tapping the image or a like button

3. Favorite Pictures
• Shows the images that the user liked
• Shows which breed a particular image belongs to • Allows user to filter images by selecting a breed.

## Description "PR description"
1 - Remove the storyboard.
2 - Build the core part of the app. "Network, Loading, Codable, Error".
3 - Add the EndPoints.
4 - Start building the dog breeds list start with building the model for the response, building the dataSource for the endPoint and parsing the response on the model, and building the layout view model which is used for the data that will be present, building the viewModel with fetch the data from the data source and add the dataSource methods will be used for the present the data, create the viewController with the tableView to present the bog breeds with scroll to top button.
5 - Build the database manager and the schema to handle the fav part.
6 - Start to build the dog breed list with sections for every single breed, starting to build the remote data source for fetch the images for the breed, build and schema and core data model, and the local dataSource to handle the fav and save, read and delete from core data, build the repo to handle the use for remote and local, build the layout view model with some logic for the present the data, build the ViewModel with the fetch from remote and methods to handle the fav, build the viewController and the tableView cell and collectionView cell with handle the add and remove from fav
7 - Start building the fav screen, start with building the layout view model for the names, build the ViewModel to get the save fav from the core data, split between the name and images and build the view controller to present the data
8 - Adding the unit tests

## Project Structure (MVVM)
The project with MVVM structure
- Models - for parsing the response on it
- DataSources(Remote and Local) - for fetch the data from network or database
- Repositories - for handle the fetching from remote and local 
- LayoutViewModels - for the map from models to be ready to use for the UI
- ViewModels - for handle the business logic
- ViewContoller - for the present the data into the UI controllers
- Unit tests

## Project Diagram
[Diagram](https://lucid.app/lucidchart/2f79dd1b-cd4c-4f80-b303-ab64ef619f95/edit?viewport_loc=-11%2C-11%2C2048%2C1203%2C0_0&invitationId=inv_81b6f980-83f1-41b3-903a-1530b7335265#)

## Video record for the app in run time
[Video](https://www.mediafire.com/file/pgcjkx1rfk4u53g/Simulator+Screen+Recording+-+iPhone+12+-+2022-11-04+at+01.36.16.mp4/file)

## Version
1.0
