# rapor_lc

## Project Structure
This project uses flutter_clean_architecture.

This architecture consist of 4 main layers, which is:
1. Domain
    This is where you put your Business objects (entities), Use Cases and Base Repositories as your project foundation.
2. App
    This is where you put your UI at work and design how your app would look. 
3. Data
    This is where you interact with your database. All database interactions (e.g. fetch, create, read, update etc.) should be here.
4. Device
    This is where you put your external libraries. So your application won't abruptly affected should you change your library.

for more information, read: https://pub.dev/packages/flutter_clean_architecture

## Entity
This project uses json_serializable library. 

Everytime you CREATE any objects (entities), make sure to run the command down below to generate the missing .g.dart generated dart files.

With a Dart package, run **dart run build_runner build** in the package directory.
With a Flutter package, run **flutter pub run build_runner build** in your package directory.

If you make a CHANGE to any objects, make sure to add **--delete-conflicting-outputs** to the command as options.