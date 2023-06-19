# 1. Introduction

This report provides a comprehensive account of our experiences during a project in our introduction to software engineering course. Our dual roles offered us a unique perspective – as a client commissioning the project 'EveryDraw' and as a developer team responsible for executing the project 'HobbyHive'. In the process, we developed a keen understanding of the intricate dynamics between clients and software development teams.

As a collective comprised of members from Sparcs and GDSC, our team was blessed with the advantage of basic development experience. This allowed us to shift our focus towards implementing advanced software engineering techniques. Emphasizing project management, we incorporated Kanban boards for task tracking and established a robust Continuous Integration/Continuous Deployment (CI/CD) process for efficient software delivery.

During our stint as clients, we realized the pivotal role of documentation and its potential areas for improvement. The project exposed us to the importance of clear and comprehensive documentation. This report details the improvements we have identified and proposed, aiming to enhance future software development projects.


# 2. Our Role as a Client
In our introductory software engineering class, we played dual roles - one of which was as a client commissioning the development of 'EveryDraw'. EveryDraw was envisaged as a platform to facilitate fair prize drawings for sharing events held at KAIST. These events typically involve participants sharing certain posts on social media platforms, and EveryDraw was conceived as an impartial tool to handle these sweepstakes.

While the final outcome was substantially aligned with our expectations, there were certain gaps identified. Here, we discuss these discrepancies and provide our insights on the corresponding improvements needed.

## 2.1 Managing Project Versions and Expectations
### 2.1.1 Problem
We initiated the project with a grand vision, a fully fleshed-out version of EveryDraw. At the same time, we also outlined an MVP (Minimum Viable Product) that was realistically scoped given the constrained timeframe. This dual-track vision served as a roadmap for the development team. However, during the course of the project, some miscommunications surfaced, leading to deviations from our expectations, particularly in the login method implementation.

### 2.1.2 Solution: Enhanced Version Control for Documentation
Our experience underscored the importance of version control, not just for the codebase, but equally for the SRS (Software Requirements Specification) documentation. It is not unusual for a project's functionality to be scaled down or up depending on the timeline and other constraints. Therefore, keeping a meticulous record of what was altered, added, or removed becomes paramount to avoid confusion and ensure all stakeholders are on the same page. Implementing such version control measures for the documentation would significantly enhance the overall project management.

## 2.2 Differing Service Focus and User Flow
### 2.2.1 Problem
As we delved deeper into the development process, we noticed a slight disconnect in the focus areas. While our main concern was the fairness of the lottery system, the development team placed significant emphasis on event registration and management. These different focal points created minor discrepancies, particularly visible in the user interface (UI).

### 2.2.2 Solution: Comprehensive and Detailed Documentation
This realization brought to light the critical need for comprehensive and detailed documentation. During the meetings, certain contexts and conversations that we considered 'understood' were not explicitly included in the documentation, leading to differences in understanding. Documenting all aspects, even those that appear obvious or trivial, would ensure a shared understanding among all stakeholders, minimizing the chances of misinterpretation or overlooked details.

## 2.3 Discrepancies in UI Design and HCI
### 2.3.1 Problem
Our vision for the UI design was captured through wireframes that we provided for certain pages. The development team did a commendable job implementing these. However, for the pages not covered by the wireframes, the implemented design deviated from our original vision.

### 2.3.2 Solution: Reference-Based UI Design
This experience highlighted the usefulness of using other successful services as references for ensuring a user-friendly UI. Standard pages such as login and profile management are universally similar across various services. By citing these as references, we could provide explicit examples and concrete guidance to the development team. This would increase the likelihood of the final product accurately reflecting our intended design and user flow.
