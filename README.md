# QuizMeUp App Test

I record the finished app.
Click the link of video to show the app flow
https://github.com/user-attachments/assets/d78d5531-ef31-4bfb-9ebe-3dc52425811a

<img src="https://i.ibb.co/gMN5zY2/Screenshot-2024-10-09-at-1-57-59-PM.png" alt="Screen-Shot-2021-08-13-at-5-10-31-PM" border="0" width="188">&nbsp;&nbsp;
<img src="https://i.ibb.co/bg246sy/Screenshot-2024-10-09-at-1-58-11-PM.png" alt="Screen-Shot-2021-08-13-at-5-10-38-PM" border="0" width="188">&nbsp;&nbsp;
<img src="https://i.ibb.co/KXY3MHK/Screenshot-2024-10-09-at-1-58-26-PM.png" alt="Screen-Shot-2021-08-13-at-5-11-32-PM" border="0" width="188">&nbsp;&nbsp;
<img src="https://i.ibb.co/KXY3MHK/Screenshot-2024-10-09-at-1-58-26-PM.png" alt="Screen-Shot-2021-08-13-at-5-11-39-PM" border="0" width="188">&nbsp;&nbsp;
<img src="https://i.ibb.co/42rMMbp/Screenshot-2024-10-09-at-1-58-33-PM.png" alt="Screen-Shot-2021-08-13-at-5-11-39-PM" border="0" width="188">&nbsp;&nbsp;
<img src="https://i.ibb.co/TLDB2c8/Screenshot-2024-10-09-at-1-58-41-PM.png" alt="Screen-Shot-2021-08-13-at-5-11-39-PM" border="0" width="188">&nbsp;&nbsp;
<img src="https://i.ibb.co/BPRf59C/Screenshot-2024-10-09-at-1-59-08-PM.png" alt="Screen-Shot-2021-08-13-at-5-11-39-PM" border="0" width="188">&nbsp;&nbsp;

# Design Pattern Used
- Architecture: MVVM with the use of Coordinators

# Features Implemented in QuizMeUp.

1. I created a network service for this. I used dummyjson.com to upload the json file you provide.
2. I made the screens dynamic that can cater Recap and Multiple choice. 
3. Add progress bar on the navigation bar to show the progress.
4. Add confetti to play the animation if answer is correct.
5. I have also implemented the loading of json.file but i comment it out to give way to network service demonstration. If you want to test it just got to MainController.swift and follow the code below.
```swift
 func setup() {
 //   fetchQuiz()
    loadJsonFile()
    populateData()
  }
```

