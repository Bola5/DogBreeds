#  Dog breeds app

## Onboarding
## Requirements
1 - Please use the last version from Xcode 13 or higher

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

## Project Structure (MVVM)
The project with MVVM structure
- Models - for parsing the response on it
- DataSources(Remote and Local) - for fetch the data from network or database
- Repositories - for handle the fetching from remote and local 
- LayoutViewModels - for the map from models to be ready to use for the UI
- ViewModels - for handle the business logic
- ViewContoller - for the present the data into the UI controllers
- Unit tests

## Version
1.0

