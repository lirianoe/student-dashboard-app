#** _Original App Design Project - APP_

##** Table of Contents

1. Overview
2. Product Spec
3. Wireframes
4. Schema

##** Overview

###** Description

- Allows students to create assignment tasks under class categories and stay organized with their coursework. In order to complete tasks, students must submit a file as proof of completion.

###** App Evaluation

1. Student Task Scheduler
   - **Category:** Productivity / Education
   - **Mobile:** Mobile is essential for quickly adding tasks, uploading files, and accessing notes on the go. Students can use their phone camera to upload images or scan documents, and access materials anytime.
   - **Story:** Helps students stay organized by keeping assignments, notes, and resources all in one place. Encourages accountability by requiring proof of completion for tasks.
   - **Market:** Students in high school and college who want a more structured way to manage assignments and class materials would benefit from this app.
   - **Habit:** Students are using the app daily to check assignments, upload completed work, and review notes for their classes.
   - **Scope:** V1 would allow students to create tasks and upload files as proof of completion. V2 would add class categories and note uploads in different formats. V3 would include reminders and deadlines. V4 would add integrations with school platforms and collaboration features.


##** Product Spects

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

[User can view their courses on the home screen]  
[User can select a course to see more details]  
[User can navigate between main sections using the bottom tab bar]  
[User can view scheduled study sessions or tasks]  
[User can access the app dashboard after opening the app]  

**Optional Nice-to-have Stories**

[User can add or edit courses]  
[User can persist user data across working sessions]  
[User can receive reminders for scheduled study sessions]  
[User can customize their study dashboard]  


### 2. Screen Archetypes

[Home Screen]  
[Required User Feature: User can view a list of courses and select one]  

[Course Detail Screen]  
[Required User Feature: User can view detailed information about a selected course]  

[Schedule Screen]  
[Required User Feature: User can view upcoming study sessions or tasks]  

[Navigation Bar]  
[Required User Feature: User can switch between Home and Schedule screens]  


### 3. Navigation

**Tab Navigation (Tab to Screen)**

[Home Tab → Home Screen]  
[Schedule Tab → Schedule Screen] 


**Flow Navigation (Screen to Screen)**

[Home Screen]  
Leads to [Course Detail Screen]  

[Course Detail Screen]  
Leads to [Home Screen]  

[Home Screen]  
Leads to [Schedule Screen]  

[Schedule Screen]  
Leads to [Home Screen]  


##** Wireframes

https://drive.google.com/file/d/1bqAZzDngwQzbT9V23EwcM2BqGbZ70FNk/view?usp=share_link


##** Schema

####** Models

https://drive.google.com/file/d/1Ucx1QbooB1_1YrTMQhgX__RYMPpErvg0/view?usp=share_link

###** Networking

The application follows a Local-First Architecture using SwiftUI Data Bindings and System Frameworks to manage information flow without an external REST API.

Network Requests by Screen
Hub (Main Dashboard)

[GET] vm.classes – Retrieves all course objects from the local state to populate the main list.

[POST] vm.addClass(name) – Initializes a new StudentClass object and persists it to the view model.

Class Detail View (Dynamic Tabs)

[GET] studentClass.assignments – Fetches all tasks specifically linked to the selected class ID.

[POST] studentClass.assignments.append(item) – Updates the class reference with a new task.

[POST] studentClass.books.append(item) – Adds a new book entry with metadata.

[POST] studentClass.notes.append(item) – Appends a new text block to the class notes array.

Schedule (Calendar View)

[GET] Calendar.current – System request to fetch the user's current locale and date formatting for the graphical picker.

[GET] assignments.filter(date) – A computed request that scans all classes to return tasks matching the user's selected date.

File System Integration

[IMPORT] UTType.pdf / .plainText – System request via fileImporter to access the iOS Files App or iCloud Drive to retrieve document metadata.