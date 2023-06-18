# Report

# 1. Introduction

## 1.1 Project Overview

This report is about the development of Flutter app as a team project in Introduction to Software Engineering course. Our team was tasked to develop an app that works on iOS and Android using Flutter and Firebase based on the client's needs.

## 1.2 Project Goals

Our team aimed to develop an app that supports database and signup features using a combination of firebase and flutter to meet the client's expectations. We also utilized Kanban, GitHub-Flow, and CI/CD for an efficient development process and collaboration.

## 1.3 Team Composition

Our team consisted of 5 students who were taking an introductory software engineering course. All of the team members had developer skills and participated with enthusiasm and interest in developing the Flutter app. The team members were assigned different roles and responsibilities to realize an efficient division of labor.

## 1.4 Expected outcomes

Through this project, our team was able to gain hands-on experience by applying the principles of software engineering and real-world development tools. We were also able to improve our cooperation and communication skills among team members, learn the importance of the software development process and how to manage it efficiently. This gave us valuable experience to prepare for development projects in the real world.

# 2. Product Specification

## 2.1 Communicating with the client and analyzing the SRS documentation

In the early stages of the project, we worked with the client. We analyzed the SRS (Software Requirements Specification) document provided by the client and used it to refine the product specification. We regularly exchanged views via email and answered questions to clarify the product requirements.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/b1baa1ba-76cd-4f72-97fc-205884ac1c87/Untitled.png)

## 2.2 Product requirements specification

To meet the client's expectations, we decided to develop an app that works on iOS and Android. For the app, we chose a combination of Firebase and Flutter for user data management, and used Firestore and Storage provided by Firebase to implement the database and signup features. This allowed us to build a stable and scalable app.

## 2.3 Target platforms: iOS and Android

Our team set up the app to be developed for both iOS and Android platforms. By doing so, we ensured that the app would be available to a wide range of users, even if they were using different operating systems. By utilizing Flutter's cross-platform development capabilities, we were able to easily deploy the app to multiple platforms.

## 2.4 Deciding to use Firebase + Flutter for database and user registration functionality

Among the client's requirements, we needed to implement a database and user registration functionality. For this, we decided to develop with a combination of Firebase and Flutter. Firebase is an easy-to-use and scalable cloud-based platform, which made it easy to implement database management and user authentication. The combination of Flutter and Firebase provided us with the functionality we wanted and an efficient development process.

## 2.5 Developing with Firebase Firestore and Storage

We implemented data management for the app using Firebase's database service, Firestore, and file storage, Storage. Firestore provides real-time data synchronization and scalability, and we were able to store and retrieve user data efficiently. Storage provided the ability to securely store and access user resources such as images and files. These features of Firebase allowed us to develop a reliable and flexible data management solution.

# 3. Design Process

## 3.1 Using Flutterflow, a no-code tool to streamline design work

Since we were a team of developers without a designer, we used a no-code tool called Flutterflow to streamline our design work. Flutterflow gives you the ability to configure the design of your app through a visual interface. This made it easy for developers without design expertise to place UI elements and organize the overall layout of the app.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/12466430-5574-435a-a363-1bcafb6619d3/Untitled.png)

## 3.2 Prototype development with Flutterflow

We used Flutterflow to prototype the app. Flutterflow provides the ability to visually assemble user interface elements to simulate the behavior and flow of the app. This allowed us to better communicate with the client, and we were able to quickly demonstrate early looks of the app and get feedback.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/8872dae4-882e-4a0b-8a94-b1237ac49b1b/Untitled.png)

## 3.3 Integrating Flutter design components into front-end development

The design of the prototype created in Flutterflow was compatible with Flutter's design components, which made it easy for us to integrate the design components created in Flutterflow during the front-end development phase. By utilizing Flutter's various UI elements and design patterns, we were able to apply a consistent design to our app, and our developers were able to focus more on design work.

# 4. Project Management

## 4.1 Consider Kanban and Scrum for project management

Our team considered Kanban and Scrum to effectively manage our project. Kanban is a good way to visually track tasks and manage priorities, while Scrum is a project management method based on more rigorous iterations and planning. We wanted to compare the two methods and choose the one that best suited our team's style of working.

## 4.2 Adopting Kanban due to difficulties with strict iterations

We anticipated that our team would have difficulty following strict iteration due to the high variability of team members' work, so we adopted Kanban for project management to account for this difficulty. Kanban was better suited to our team's collaborative work, as it is a fluid way of managing tasks as flows, with the flexibility to add or remove tasks as needed.

## 4.3 Setting Work-in-Progress limits for collaborative and fluid work

To keep our work collaborative and flexible, we set Work-in-Progress (WIP) limits. By limiting the number of tasks that can be in progress at one time, WIP limits create an environment where team members can stay focused and complete their work. This allowed us to maintain efficient collaboration and clearly prioritize tasks.

# 5. Development Process

## 5.1 Using GitHub-Flow, a simpler branching strategy than Git-Flow

During the development of our project, our team used GitHub-Flow, a simpler and more flexible branching strategy than Git-Flow. GitHub-Flow is organized into main and protected branches, and tasks such as feature development or bug fixes are performed in each branch. This approach provided developers with a free flow of work while ensuring the stability of the code.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/ab214ae2-ef35-4d01-be37-fb377d8dca8c/Untitled.png)

## 5.2 Establish commit message guidelines

To ensure efficient collaboration and streamline code review processes, our team implemented commit message guidelines. These guidelines played a crucial role in maintaining clear communication among team members and facilitating a comprehensive understanding of code changes.

For branch naming, we followed the convention of {feature|main}/[pages|logic]/[feature_name]. This convention helped us organize our branches effectively, making it easier to identify and locate specific features or sections of the codebase. An example of a branch name would be "feature/pages/sign_in_page."

In terms of commit messages, we established a structured format: {Type}: {Description}. The Type represented the nature of the commit, such as Design, Add, Delete, Fix, and more. By categorizing our commit messages, we were able to quickly grasp the purpose of each change. For instance, a commit message could be "Design: Implemented sign-in page."

Adhering to these commit message guidelines proved highly beneficial. They enhanced our ability to track modifications, understand the context of changes, and conduct efficient code reviews. The clarity and conciseness of the commit messages ensured effective collaboration throughout the development process.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/a0a6c22e-f80e-49d9-a100-82ada4600ba7/Untitled.png)

## 5.3 Collaborative development with GitHub-Flow

Our team utilized GitHub-Flow for collaborative development. Each feature or task that needed to be fixed was developed in a separate branch, and once the task was completed, that branch was merged into the main branch. This allowed multiple developers to work simultaneously and ensured efficient development while maintaining consistency and stability of the code.

# 6. CI/CD

## 6.1 Implementing CI/CD with GitHub Actions

Our team utilized GitHub Actions for continuous integration and deployment. GitHub Actions are used to automate the development process by automatically performing tasks such as build, test, and deploy whenever a source code change occurs. We set up a GitHub Actions workflow by defining the build, test, and required deployment steps for our app. This allowed us to automatically go through the development process whenever there was a code change and maintain a stable app.

## 6.2 Ensure code review efficiency by ensuring adherence to the style guide and leaner

Our team adopted a style guide and a linter to maintain consistency and quality in our code. Developers wrote code according to the style guide, and the linter detected potential errors or anti-patterns in the code. GitHub Actions automatically checked code for compliance with the requirements of the style guide and leaner, which increased efficiency in the code review process. Developers could see the results of the style guide and leaner's checks when reviewing code changes, making their feedback more focused.

# 7. Conclusion

## 7.1 Successful development of an app based on Flutter and Firebase

Our team successfully developed an app based on Flutter and Firebase. We created a multi-platform app that met the client's needs and effectively utilized Firebase's Firestore and Storage to support the database and signup features. We achieved the goals of the app in terms of functionality and user experience, and achieved a successful outcome through good communication and collaboration with the client.

## 7.2 Summary of key achievements and challenges faced

During the course of the project, our key achievements were: 1) We refined the product specification through email communication with the client and developed an app that met the client's expectations; 2) We utilized Flutterflow to streamline design work in the absence of a designer and built prototypes quickly; 3) We adopted Kanban for project management and set Work-in-Progress limits to ensure collaborative and fluid work.

But they also faced some challenges. We chose Kanban because it was difficult to apply strict iterations, and project management needed to be coordinated in the beginning. We also faced some challenges in front-end development due to the absence of a designer. To overcome these challenges, team members actively communicated and worked together to solve problems.

## 7.3 Lessons learned and recommendations for future projects

Our team learned several lessons from this project. First, we realized the importance of clear communication and requirements analysis with the client at the beginning of the project. Second, we found it effective to leverage the no-code tool Flutterflow during the design phase to quickly develop prototypes. Third, we learned that applying Kanban and Work-in-Progress limits for efficient project management can increase collaboration and flexibility.

We make several recommendations for future projects. First, it is important to clearly define project goals and requirements early on and maintain good communication with the client. Second, we recommend utilizing no-code tools or prototyping tools to streamline design efforts. Third, you should choose an appropriate methodology for project management and explore ways to flexibly organize your workflow.