# Original App Design Project - APP

## Table of Contents
1. [Overview](#overview)
2. [Product Spec](#product-spec)
3. [Wireframes](#wireframes)
4. [Schema](#schema)

---

## Overview

### Description
Allows students to create assignment tasks under class categories and stay organized with their coursework. In order to complete tasks, students must submit a file as proof of completion.

### App Evaluation

#### Student Task Scheduler

- **Category:** Productivity / Education  
- **Mobile:** Mobile is essential for quickly adding tasks, uploading files, and accessing notes on the go. Students can use their phone camera to upload images or scan documents, and access materials anytime.  
- **Story:** Helps students stay organized by keeping assignments, notes, and resources all in one place. Encourages accountability by requiring proof of completion for tasks.  
- **Market:** Students in high school and college who want a more structured way to manage assignments and class materials would benefit from this app.  
- **Habit:** Students are using the app daily to check assignments, upload completed work, and review notes for their classes.  
- **Scope:**  
  - V1: Create tasks and upload files as proof of completion  
  - V2: Add class categories and note uploads  
  - V3: Add reminders and deadlines  
  - V4: Add integrations with school platforms and collaboration features  

---

## Product Spec

### 1. User Stories

#### Required (Must-have)
- User can view their courses on the home screen  
- User can select a course to see more details  
- User can navigate between main sections using the bottom tab bar  
- User can view scheduled study sessions or tasks  
- User can access the app dashboard after opening the app  

#### Optional (Nice-to-have)
- User can add or edit courses  
- User can persist user data across working sessions  
- User can receive reminders for scheduled study sessions  
- User can customize their study dashboard  

---

### 2. Screen Archetypes

#### Home Screen
- User can view a list of courses  
- User can select a course  

#### Course Detail Screen
- User can view detailed information about a selected course  

#### Schedule Screen
- User can view upcoming study sessions or tasks  

#### Navigation Bar
- User can switch between Home and Schedule screens  

---

### 3. Navigation

#### Tab Navigation
- Home Tab → Home Screen  
- Schedule Tab → Schedule Screen  

#### Flow Navigation
- Home Screen → Course Detail Screen  
- Course Detail Screen → Home Screen  
- Home Screen → Schedule Screen  
- Schedule Screen → Home Screen  

---

## Wireframes

[View Wireframes](https://drive.google.com/file/d/1bqAZzDngwQzbT9V23EwcM2BqGbZ70FNk/view?usp=share_link)

---

## Schema

### Models

[View Data Models](https://drive.google.com/file/d/1Ucx1QbooB1_1YrTMQhgX__RYMPpErvg0/view?usp=share_link)

---

### Networking

The application follows a Local-First Architecture using SwiftUI Data Bindings and System Frameworks to manage information flow without an external REST API.

### Network Requests by Screen

#### Hub (Main Dashboard)
- **GET** `vm.classes` — Retrieves all course objects from the local state  
- **POST** `vm.addClass(name)` — Creates and persists a new StudentClass  

#### Class Detail View (Dynamic Tabs)
- **GET** `studentClass.assignments` — Fetches tasks for the selected class  
- **POST** `studentClass.assignments.append(item)` — Adds a new task  
- **POST** `studentClass.books.append(item)` — Adds a book entry  
- **POST** `studentClass.notes.append(item)` — Adds a note  

#### Schedule (Calendar View)
- **GET** `Calendar.current` — Retrieves system date and locale  
- **GET** `assignments.filter(date)` — Returns tasks for selected date  

#### File System Integration
- **IMPORT** `UTType.pdf / .plainText` — Uses fileImporter to access iOS Files and iCloud Drive  
