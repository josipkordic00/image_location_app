# Flutter Native Features App

This Flutter app utilizes native mobile features such as Location, Camera, and Storage to provide users with a streamlined experience. Below is an outline of the app's functionalities and the associated dependencies:

## Features

1. **Adding Items**
   - Users can add items to a list within the app.
   - Upon clicking the "Add Place" button, a form is submitted.

2. **Location Services**
   - Users can either capture their current location or select a location on the map.
   - This functionality is enabled using the `geocoding`, `location`, `flutter_map`, and `latlong2` packages.

3. **Camera Integration**
   - Users can capture photos within the app.
   - The `image_picker` package is used to enable this feature.

4. **Data Storage**
   - Submitted form data is stored locally on the device.
   - The `path`, `path_provider`, and `sqflite` packages facilitate efficient storage management.

## Dependencies

- **path**: Provides utilities for working with file and directory paths.
- **path_provider**: Offers access to commonly used locations on the file system.
- **sqflite**: Allows interaction with SQLite databases.
- **image_picker**: Enables image selection from the device's gallery or camera.
- **geocoding**: Converts addresses into geographic coordinates and vice versa.
- **location**: Retrieves location data using the device's GPS sensor.
- **flutter_map**: Renders interactive maps in Flutter.
- **latlong2**: Provides utilities for handling latitude and longitude coordinates.
- **flutter_riverpod**: A provider package for Flutter applications that makes state management simple and intuitive.
- **uuid**: Generates universally unique identifiers (UUIDs) for items within the app.
- **google_fonts**: Provides access to the entire Google Fonts library for use in Flutter apps.


## Usage

To use this app, follow these steps:

1. Clone this repository to your local machine.
2. Open the project in your preferred Flutter development environment.
3. Ensure that all dependencies are installed by running `flutter pub get`.
4. Build and run the app on your preferred device or emulator.

Feel free to explore the codebase and customize it according to your requirements!
