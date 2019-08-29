# Movie-DB
Movie listing app with MovieDB api.

## Note:
- Code is compiled on Xcode 10.1 with Swift 4.2 language.
- App does not uses any third party libraries.

## Architecture(MVVM) :
- Each module is devided into three parts :
1. Model : Contains model objects
2. View : Contains xibs and controller
3. View Model : Contains view model(which has business logic) & Repository(handles network call)
- For services, Resources, Utility created seperated folder.

## Network Service :
- For network service NetworkService class is used, which uses Apple's default URLSession class.

## Image Caching :
- For image caching, getImageWith() method is used which defined in UIImageView Extension.
- Downloaded images are stored in NSCache, and retrieved from same if exist.
- On low memory warning from iPhone OS, NSCache automatically removes the data from it. 

## Data Parsing :
- For api json parsing Codable is used.
- Generic Extension of Data class is created to decode model from Data.

## Search Caching :
- Cached search is saved in UserDefaults. Cache can be saved in other persistent data techniques like Core Data, Realm etch.

## Unit Testing :
- Test cases are written on View Models created in MVVM . 
- Test cases are written through default XCTest only.

## Additional Features To Add :
- Asynchronous binding between ViewModel & UI through RxSwift.
- Better persistence storage of search result, like Core Data, Realm.


