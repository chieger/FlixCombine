# Flix: Combine + SwiftUI + MVVM
A project to explore using Combine + SwiftUI frameworks with MVVM architecture to create a simple movie browsing app with data from [The Movie Database API](https://developers.themoviedb.org/3/getting-started/introduction)

## 1. Fetch Movies and display titles in List
### Goal
Fetch a list of movie's now playing from [The Movie Database API - Now Playing Endpoint](https://developers.themoviedb.org/3/movies/get-now-playing) and display them in a SwiftUI list view.

### Steps
1. Reorganize project into a few basic groups, "View", "Network", "App", "Model".
1. Create API struct .
   1. Handle URL creation for endpoint .
   1. Basic network request using URLSessionDataTask publisher provided by Combine framework.
1. Create `MoviesListViewModel` for the movies list view.
   1. `ObservableObject` with a few `@Published` properties we want to expose to the view.
1. Create basic `MoviesListView` to display movie title in a list view.
   1. Embed in `NavigationView` + set nav title.
   1. Add `List`, `Section` + set section title.
   1. Use `ForEach` to return a `Text` view for each movie in the view model's `movies` array and display each movies's title.

### Images
![flix_1 1](https://user-images.githubusercontent.com/11927517/79384844-76f80900-7f1c-11ea-9cf0-3bab4c084ef3.gif)

## 2. Create custom view for Movie Row in List
### Goal
Create a custom SwiftUI view to encapsulate a placeholder image, movie title and overview text. Apply basic styling to image and text.

### Steps
1. Create a custom SwiftUI view. (RowView.swift using SwiftUI View template)
1. Arrange views to get desired layout.
   1. Add HStack to body (to separate image from text horizontally)
   1. Add Image (with SFSymbol) to HStack.
   1. Add VStack to HStack (to separate text title from text overview, vertically)
1. Style Image
   1. Modifiers: `.resizeable` + `frame(width:, height:)`
1. Style Text views
   1. Modifiers: `.font()`, `.lineLimit()`, `.minimumScaleFactor(0.6)`

### Images
![flix_1 2](https://user-images.githubusercontent.com/11927517/79396200-3609ef80-7f30-11ea-88bf-7f6abb9cf08c.gif)

## 3. Display movie poster images
### Goal
Fetch movie poster images asynchronously and display in movie rows.

### Steps
1. Create ImageLoader class.
   1. Observable Object with `@Published` image property.
1. Create Custom AsyncImage view that utilizes ImageLoader.
   1. Add property for ImageLoader with `ObservedObject` wrapper to observe when image updates.
   1. Takes an optional Placeholder of type `View`. This allows the caller to pass in any view for placeholder, for instance placeholder could be Text vs. Image.
1. Update API with Endpoint to fetch images.
   1. Image fetching url has different `host` as well as `path`.
1. Create MovieRowViewModel initialized my a movie object.
   1. Add computed property for image url.
   1. Update MovieListView to initialize MovieRow with in MovieRowViewModel.

### Images
![flix_1 3](https://user-images.githubusercontent.com/11927517/79494526-031b3680-7fd8-11ea-813b-eea89e7c7930.gif)
