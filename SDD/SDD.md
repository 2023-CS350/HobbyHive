# Software Design Document

## Table of Contents
- [Software Design Document](#software-design-document)
  - [Table of Contents](#table-of-contents)
  - [Introduction](#introduction)
  - [Architectural Design](#architectural-design)
    - [Main components](#main-components)
      - [Client-side Application](#client-side-application)
      - [Server-side Application](#server-side-application)
      - [Firebase](#firebase)
    - [Design Patterns](#design-patterns)
      - [Model-View-ViewModel (MVVM)](#model-view-viewmodel-mvvm)
      - [Repository Pattern](#repository-pattern)
      - [Dependency Injection](#dependency-injection)
      - [Observer Pattern](#observer-pattern)
      - [Singleton Pattern](#singleton-pattern)
      - [Factory Method Pattern](#factory-method-pattern)
  - [Data Design](#data-design)
    - [ER Model](#er-model)
      - [Entities](#entities)
        - [Events](#events)
        - [Users](#users)
        - [Chatrooms](#chatrooms)
        - [Message](#message)
        - [Contents](#contents)
        - [Requests](#requests)
        - [Interests](#interests)
      - [Relations](#relations)
    - [Concretized data model for firebase(NoSQL)](#concretized-data-model-for-firebasenosql)
      - [Event document](#event-document)
      - [User document](#user-document)
      - [Chatroom and message document](#chatroom-and-message-document)
      - [Interest](#interest)
      - [Request](#request)
      - [Overall structure](#overall-structure)
      - [Constraints](#constraints)


## Introduction

HobbyHive is a mobile application that provides a safe environment for people to explore new hobbies and connect with others who share their interests. The app allows users to set up meeting times or join groups of like-minded individuals who are interested in the same hobbies.

HobbyHive offers fully customizable user experiences, including distance filters, personalized tags, individual ratings, and a familiar interface of swiping left and right. The app is designed to be easy to use and intuitive, making it accessible to users of all ages and skill levels.

Some of the key features of HobbyHive include sign up, new profile set up, password retrieval, search bar, arranging an event, chatting among users, and a rating system. These features are described in detail in the Software Requirements Specification (SRS) document and are implemented according to the design outlined in the Software Design Document (SDD).

Overall, HobbyHive is designed to help people explore new hobbies and connect with others who share their interests. By providing a safe and welcoming environment for hobbyists of all kinds, HobbyHive aims to help people expand their horizons and discover new passions.

## Architectural Design

### Main components

HobbyHive is a mobile application developed using the Flutter framework and Firebase cloud platform. The system architecture consists of three main components: the client-side application, the server-side application, and the Firebase database.

#### Client-side Application

Client-Side Application: We will use Flutter, a mobile app development framework, to build the client-side application. Flutter allows us to create high-performance, cross-platform apps for both iOS and Android using a single codebase. The client-side application will communicate with the server-side application and Firebase using HTTP/2 and HTTPS protocols.

1. User Authentication: The client-side application will allow users to sign up and log in using email/password, Google, Facebook, or other third-party providers. Once authenticated, users will be able to create and join events.
2. New Profile Setup: After signing up, users will be prompted to set up their profile by providing their name, profile picture, bio, and interests/hobbies.
3. Retrieve Password: The client-side application will allow users to retrieve their password if they forget it by sending a password reset link to their registered email address.
4. Search Bar: The client-side application will allow users to search for events or other users using keywords or filters such as date/time, location, activity type, etc.
5. Event Creation: The client-side application will allow users to create new events by specifying the event name, date/time, location (including map integration), description, activity type (e.g., hiking), and any associated media files (e.g., images). Users will also be able to specify the maximum number of attendees for each event and set privacy settings such as approval of incoming members.
6. Event Discovery: The client-side application will allow users to discover nearby events based on their current location or search for events by keyword or category. Users will be able to view event details such as the event name, date/time, location (including map integration), description, activity type (e.g., hiking), and any associated media files.
7. Event Management: The client-side application will allow users to manage their own events by editing or deleting them as needed. Users will also be able to view a list of attendees for each event and remove attendees if necessary.
8. Chat Messaging: The client-side application will allow users to communicate with each other using a chat messaging system associated with each event. Users will be able to send text messages and share media files (e.g., images) within the chat messaging system.
9. Rating System: The client-side application will allow users to rate events and other users based on their experience. Users will be able to rate events on a scale of 1-5 stars and leave comments, as well as rate other users based on their behavior during the event.

#### Server-side Application

We will use Google Cloud Functions, a serverless compute platform, to build the server-side application. Cloud Functions allows us to write small pieces of code that can be triggered by events such as HTTP requests or changes in Firebase data. The server-side application will communicate with the client-side application and Firebase using HTTP/2 and HTTPS protocols.

1. Event scheduling: Cloud Functions can be used to schedule events at specific times or intervals. This feature will be used to automatically close events after they have ended.
2. Geolocation: Cloud Functions can be used to perform geolocation-based queries on the real-time database. This feature will be used to find nearby events based on the user's location.
3. Image processing: Cloud Functions can be used to process images uploaded by users before storing them in cloud storage. This feature will ensure that images are properly formatted and optimized for display on different devices.
4. Data validation: Cloud Functions can be used to validate data before it is stored in the real-time database or cloud storage. This feature will ensure that only valid data is stored in the system.

#### Firebase

We will use Firebase as our backend infrastructure for data storage, authentication, and messaging. Firebase provides a suite of tools that make it easy to build scalable apps without managing servers or infrastructure. The client-side and server-side applications will communicate with Firebase using the Firebase SDKs, which provide APIs for accessing data in real-time.

1. Real-time database: Firebase provides a real-time database that can be used to store and synchronize data across multiple clients in real-time. This feature will be used to store user data, event data, and chat messages.
2. Authentication: Firebase provides authentication services that can be used to authenticate users using email/password, Google, Facebook, or other third-party providers.
3. Cloud Messaging: Firebase provides cloud messaging services that can be used to send push notifications to users when new events are created or when existing events are updated.
4. Storage: Firebase provides cloud storage services that can be used to store images and other media files associated with events.

In terms of protocols used for communication between these components:

1. HTTP/2: This is a protocol used for communication between the client-side and server-side applications as well as between the server-side application and Firebase. HTTP/2 is an optimized version of HTTP that reduces latency by allowing multiple requests/responses to be sent over a single connection.
2. HTTPS: This is a protocol used for secure communication between the client-side and server-side applications as well as between the server-side application and Firebase. HTTPS encrypts all data sent over the network to prevent eavesdropping or tampering.
3. Real-time Database Protocol: This is a protocol used by Firebase's real-time database service to synchronize data in real-time between clients and servers. The protocol uses WebSockets to establish a persistent connection between clients and servers, allowing data to be pushed to clients in real-time.
4. Firebase Cloud Messaging Protocol: This is a protocol used by Firebase's cloud messaging service to send push notifications to clients. The protocol uses HTTP/2 to send messages from the server-side application to Firebase, which then delivers the messages to clients using platform-specific protocols such as APNs (Apple Push Notification Service) or FCM (Firebase Cloud Messaging).

### Design Patterns

To ensure scalability and maintainability of HobbyHive's architecture, we will use several design patterns:

#### Model-View-ViewModel (MVVM)

In MVVM, the Model represents the data and business logic of the application, the View represents the user interface, and the ViewModel acts as an intermediary between the Model and View. The ViewModel exposes data from the Model to the View in a way that is easy to bind to, and it also handles user input from the View and updates the Model accordingly.

To implement MVVM in HobbyHive, we can use Flutter's built-in support for reactive programming with streams and observables. We can create a separate ViewModel class for each screen in our app, which will handle all of the business logic for that screen. The ViewModel will expose streams of data to the View, which can be easily bound to using Flutter's StreamBuilder widget.

For example, let's say we have a screen that displays a list of events. We would create an EventListViewModel class that would handle fetching event data from Firebase and exposing it as a stream to our EventListScreen. The EventListScreen would then use a StreamBuilder widget to listen to changes in this stream and update its UI accordingly.

The MVVM pattern provides several benefits, including:

1. Separation of Concerns: MVVM separates the concerns of data, business logic, and user interface into separate components. This makes it easier to maintain and modify each component independently without affecting the others.
2. Testability: Because the ViewModel is responsible for all of the business logic in MVVM, it can be easily tested in isolation from the View and Model. This makes it easier to write unit tests for our application's business logic.
3. Reusability: By separating our application's components into distinct layers, we can reuse them more easily across different screens or even different applications.
4. Scalability: As our application grows in complexity, MVVM makes it easier to manage that complexity by keeping each component focused on its specific responsibilities.
5. Improved User Experience: By using reactive programming with streams and observables, MVVM can provide a more responsive user experience by updating the UI automatically as data changes.

#### Repository Pattern

The Repository Pattern is a design pattern that abstracts data access by providing an interface between data sources (Firebase database) and business logic. In HobbyHive's architecture, we will use repositories to encapsulate data access logic and provide a consistent interface for accessing data.

The Repository Pattern provides several benefits, including:

1. Separation of concerns - By separating data access logic from business logic, it becomes easier to maintain and modify each component independently.
2. Testability - Repositories can be tested independently of other components in the system.
3. Flexibility - Repositories can be easily swapped out with other implementations without affecting other parts of the system.

#### Dependency Injection

Dependency Injection is a design pattern that allows for the decoupling of components by providing a mechanism for injecting dependencies into objects. In HobbyHive's architecture, we will use dependency injection to provide components with the dependencies they need to function.

The Dependency Injection pattern provides several benefits, including:

1. Decoupling of components - By providing dependencies through injection, components become less tightly coupled, making it easier to modify and maintain them.
2. Testability - Components can be tested independently of their dependencies by providing mock objects during testing.
3. Flexibility - Dependencies can be easily swapped out with other implementations without affecting other parts of the system.

#### Observer Pattern

The Observer Pattern is a design pattern that allows objects to subscribe to events and receive notifications when those events occur. In HobbyHive's architecture, we could use the Observer Pattern to notify users when new events are created or when existing events are updated.

#### Singleton Pattern

The Singleton Pattern is a design pattern that ensures that only one instance of a class exists in the system. In HobbyHive's architecture, we could use the Singleton Pattern to ensure that only one instance of the Firebase database connection exists.

#### Factory Method Pattern

The Factory Method Pattern is a design pattern that provides an interface for creating objects but allows subclasses to decide which class to instantiate. In HobbyHive's architecture, we could use the Factory Method Pattern to create different types of events based on user input.

## Data Design

### ER Model

![ER Model](./ER_Model.png)

#### Entities

There are 7 entities for the system: events, users, chatrooms, messages, contents, requests, interests. Following table describe each attributes of entity.

##### Events

| Attribute name | Type | Description |
| --- | --- | --- |
| id | integer | The primary key of the event entity |
| event_name | string | The name of the event |
| host_id | integer | The id of host hosting the event |
| participant_id | array | The id of participants participating the event |
| event_image | reference | The background image of the event |
| address | string | The place holding the event |
| latitude | float | Latitude of the place holding the event |
| longitude | float | Longtitude of the place holding the event |
| interest_id | int | The id of the area of interest that the event targets |
| day | datetime | Date and time the event starts |
| description | string | Short description about the event |
| is_private | boolean | Whether it is a private event |

##### Users

| Attribute name | Type | Description |
| --- | --- | --- |
| id | integer | The primary key of the user entity |
| user_name | string | The displayed name of the user |
| email | string | The email of the user |
| age | integer | The age of the user |
| profile_image | reference | The profile image of the user |
| biographie | string | The biographie of the user |
| interest_id | array | The id of the area of interest that the user interested in |
| chatroom_id | array | The id of the chatroom that the user is participating |
| host_score | float | The score of the user as a host |
| participant_score | float | The score of the user as a participant |

##### Chatrooms

| Attribute name | Type | Description |
| --- | --- | --- |
| id | integer | The primary key of the chatroom entity |
| room_name | string | The name of the chat room |
| room_photo | reference | The profile photo of the chat room |
| messages | array | The messages in the chat room |
| user_id | array | The users participating in the chat room |

##### Message

| Attribute name | Type | Description |
| --- | --- | --- |
| id | integer | The primary key of the message entity |
| sender_id | integer | The id of sent the message |
| content | map | The profile photo of the chat room |
| sent_time | timestamp | Time the message was sent |

##### Contents

| Attribute name | Type | Description |
| --- | --- | --- |
| id | integer | The primary key of the content entity |
| text | string | Text content |
| image | reference | Image content |
| video | reference | Video content |

##### Requests

| Attribute name | Type | Description |
| --- | --- | --- |
| id | integer | The primary key of the request entity |
| event_id | integer | The id of the event to join |
| participant_id | integer | The id of the user to participate |

##### Interests

| Attribute name | Type | Description |
| --- | --- | --- |
| id | integer | The primary key of the message entity |
| name | string | The id of sent the message |

#### Relations

| Attribute1 | Attribute2 | Mapping cardinality | Description |
| --- | --- | --- | --- |
| events.host_id | users.id | 1:1 | Host |
| events.participants_id | users.id | 1:M | Participants |
| interests.id | events.ineterest_id | 1:M | Event’s interest area |
| chatrooms.messages | messages.id | 1:M | Messages in chat room |
| chatrooms.users | users.id | 1:M | Users particiapting in the room |
| messages.sender_id | users.id | 1:1 | User who sent the message |
| messages.content | contents.id | 1:1 | The content of the message |
| users.interest_id | interests.id | 1:M | The interests of the user |

### Concretized data model for firebase(NoSQL)

#### Event document

```json
event {
	id: integer [PK]
  event_name: string
  host_id: integer
  participants_id: array<integer>
	event_image: reference
  address: string
  latitude: float
  longitude: float
  interest_id: integer
  day: datetime
  description: string
  is_private: boolean
}
```

#### User document

```json
user {
  id: integer [PK]
  user_name: string
  email: string
  age: integer
  profile_image: reference
  biographie: string
  interest_id: array<integer>
  host_score: float
  participant_score: float
	hosting_events: array<map{id: integer, event_name: string}>
	participating_events: array<map{id: integer, event_name: string}>
	participating_chatrooms: array{map<id: integer, room_name: string}>
}
```

#### Chatroom and message document

message is subcollection of the chatrooms

```json
chatroom {
  id integer: [primary key]
  room_name: string
  room_photo: reference
  user_id: array<integer>
	messages: collection
}

message {
	id: integer [primary key]
  sender_id: integer
  content: map{text: string, image: reference, video: reference}
	sent_time: timestampㄹㄹ
}
```

#### Interest

```json
interest {
  id: integer [primary key]
  name: string
}
```

#### Request

```json
request {
  id integer: [primary key]
  event_id: integer
  participant_id: integer
	participant_name: string
	participant_profile_image: reference
	participant_interests: array<integer>
	participant_biographie: string
	participant_score: float
}
```

#### Overall structure

```json
-- events collection
 |
 |--- event document1
 |
 |--- event document2
 |
 |--- ...

-- users collection
 |
 |--- user document1
 |
 |--- user document2
 |
 |--- ...

-- chatrooms collection
 |
 |--- chatroom document1
 |      |-- messages collection
 |        |
 |        |-- message document1
 |        |-- message document2
 |        |-- ...
 |--- chatroom document2
 |      |-- messages collection
 |        |
 |        |-- message document1
 |        |-- message document2
 |        |-- ...
 |--- ...

-- interests collection
 |
 |--- interest document1
 |
 |--- interest document2
 |
 |--- ...

-- requests collection
 |
 |--- request document1
 |
 |--- request document2
 |
 |--- ...

```

#### Constraints

Here, we try to clarify the constraints for attributes that did not appear in the previous er data model. These attributes are introduced for reduce the joins and faster queries.

1. hosting_events, participating_events, and participating_chatrooms in the user document should satisfy the referential constraint. Each id and name must keep consistent with event documents and chatroom documents
2. participant_name, participant_profile_image, participant_interests, participant_biographie, and participant_score in request doesn’t need to keep consistency. If the cost of maintaining consistency is too high, it is okay to keep the information when the corresponding document is added.