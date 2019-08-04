# WeatherApp
A simple MVVM app with OpenWeather API

## Introduction
 - This app is developed based on Rx data flow, implementing MVVM pattern with RxSwift.
 - All the business logic is separated in ViewModels.
 - It is using keychain to make the secret key safe.

## UX design & How to use
The UX design is focusing on simplicity, so the operation required is reduced to the minimum.
#### Warning! Please remember to change the API secret key to your own one to make it work.
When you open this app, it will fetch your location automatically. And then
1. You can easily find current weather information of your location on the top of the main page as the default value.
2. On the top-right corner, you can tap the add button to add new cities in NZ to your favourite.
3. By selecting those tableViewCells, you can update the information on the top screen to the city you choose.
4. Click the info button on the right side of the cells, you can get the 5 day weather forecast on the detail screen.

## Features
#### Basics
Weather app shows you the current weather status (eg. temperature, wind direction and speed, min/max temperature) and you can get 5-day forecast for the city you choose.
#### Enhancements
- Master/detail Interface 
-- You can fetch 5-day forecast data on the detail view.
- City Search
-- You can search NZ cities to add it to the favourite list.
- Displaying Icons
-- You can see the weather icon on the info view.
- Favourite cities
-- You can add NZ cities to the favourite list.
- Localisation
-- The app will update the temperature unit to fit the system settings.
- Using the phone's location to detect the default city
-- When you open the app, it will use the location automatically.
- State restoration
-- You favourite list will stay even after you turn off the app.
- Offline city search
-- You won't use the slow API when searching cities.
- Surprise/delight:
    - Good sense of handling sensitive data
    - Rx data flow
    - MVVM structure
    - Unit Test
    - Simplicity UX design
    - Good sense of using tools by the scale of the project
## Future Improvement
- UI design
- Progress spin view when loading
- Replace to CoreData when project getting bigger
- Implement SwiftUI
