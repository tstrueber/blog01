---
layout: post
title: Microsoft Scheduling Poll
date: 2024-02-01 08:50:14.000000000 +01:00
categories:
- How To Guides
- Productivity
tags:
- Exchange Online
- Microsoft 365
- Productivity
permalink: "/microsoft-scheduling-poll/"
excerpt: Description of the benefits of the Microsoft Scheduling Poll Tool over the
  scheduling assistant inlcuding a How To Guide.
---
## Introduction

This article is part of my productivity series where I go into detail about techniques & tools I use to increase my productivity. Today's tool is called Scheduling Poll (formerly known as FindTime). FindTime was available as a Microsoft add-in for Outlook, whereas Scheduling Poll is now natively integrated into the Outlook client. You can use this tool to reduce the back and forth of scheduling a meeting with external participants when you do not have access to their free/busy times.

## Limitations of the scheduling assistant

For meetings with colleagues in the same Exchange organization, you can usually access availability information to help you find a possible time slot for a meeting (see Megan Bowen's availability information in the screenshot below). For external attendees, you won't see their availability in the Schedule assistant (see timo.strueber@outlook.com in the screenshot below).

![Screenshot](/assets/wordpress-import/2024/01/image-4-1024x752.png)

In addition, just because a colleague does not have an appointment in their calendar does not guarantee that they will be available for the appointment you are asking them to attend.

## The process of scheduling an appointment by E-Mail

Without a tool to help you with this process, the steps involved in finding an appointment would be:

1. Find possible time slots in your calendar
2. Compose an email in which you
  - ask for the meeting
  - provide the time slots you are available
  - ask the participant to accept a specific time frame in the provided time slots
  - ensure to send the invitation to the team meeting as soon as the participant responds
  - You should block the time slots you provided in your calendar so that you are available when the participant accepts. (a step I have often forgotten)
  - You get the confirmation for a time slot
  - You send out the invitation for the Teams Meeting
  - You receive a message that the participant has accepted the meeting

This is the process in a perfect situation where everything went well. The attendee may not be able to accept any of the time slots you offered and may respond with time slots that would be available from their end, or they may request additional timeslots from your end. They may also accept a time slot, and because you failed to block that time in your calendar, you may actually be booked at that time. The whole process gets even more complicated when there is more than one external attendee involved.

## The benefit of the scheduling poll

Each step you take to schedule a meeting in the process described above takes a few minutes of your workday. On the one hand, the time adds up, and it gets complicated when you schedule many meetings with different attendees. On the other hand, every e-mail you receive and every step you have to take takes you away from what you are doing. This has a negative impact on your productivity because it takes time for your mind to switch from one task to another.

With a tool like the Scheduling Poll, you reduce the total time you spend on scheduling and reduce the time you are interrupted in the process. This results in more time for focused work. As I described in the review article of the book Deep Work, an important step in reducing interruptions is to [put more effort into composing your emails](https://strueber-it-consulting.de/deep-work/#put_more_effort_in_composing_your_emails). The scheduling query helps you with this process and automates the steps involved in the classic process of scheduling an appointment by e-mail.

## How to use the scheduling poll

To create a scheduling poll you compose a new E-Mail in your preferred client (Outlook / New Outlook or in this case the Outlook Web App):

![Screenshot](/assets/wordpress-import/2024/01/image-5-1024x631.png)
  1. specify the recipient of the email, who will also be the voter in the appointment poll that we will create
  2. define a subject that will also be used for the appointment that will later be created automatically
  3. Find a place in your E-Mail to put the Link to the created scheduling poll
  4. Expand the hidden controls
  5. Start the scheduling poll creation

The Scheduling Poll creation wizard opens and you start defining possible appointment times.

![Screenshot](/assets/wordpress-import/2024/01/image-6.png)
  1. define the duration for the appointment
  2. choose the date
  3. choose the possible appointment times on that day
You can skip between the days and tick timeslots on different days to provide your recipient with enough options to choose from.
  4. click next when you have chosen enough suggestions
![Screenshot](/assets/wordpress-import/2024/01/image-7.png)
    1. as overview of the scheduled times
    2. specify a location for the meeting
    3. choose if the meeting should be a Teams meeting as well
    4. As soon as the attendees reach consensus an appointment is automatically created in you calendar and the recipients are invited
    5. Scheduling Poll will automatically block the defined times in your calendar so you will be aware of the times you suggested
    6. You can get notified about every vote of your participants
(I have disabled this feature to minimize disruptions)
    7. All attendees must authenticate themselves to vote. When they are logged in on their client with the microsoft account that is the recipient of the E-Mail there will no additional logon nessessary.
    8. You may lock the poll for changes from your attendees. With this disabled your attendees may add new participants or suggest additional meeting times for the poll

Finally you create the poll and you are done!

The poll is created and you can send the email:

![Screenshot](/assets/wordpress-import/2024/01/image-8-1024x921.png)

When I open my calendar, I see that the suggested times are blocked in my schedule:

![Screenshot](/assets/wordpress-import/2024/01/image-9-1024x615.png)

When I open the calendar item, I can find the link to view the actual poll:

![Screenshot](/assets/wordpress-import/2024/01/image-10-1024x793.png)

In the scheduling poll, I can see details about the poll. The participant has not yet voted:

![Screenshot](/assets/wordpress-import/2024/01/image-12.png)
    1. If there is no response from my participants, I can send a reminder email.
    2. I can cancel the poll
    3. I can adjust my own availability if my schedule changes
    4. I can see how my attendees have voted
    5. I can schedule a meeting for a specific time regardless of the attendee vote.
(e.g. when you talk to them)

Here is the view from the participant's perspective. First, the attendee clicks on Vote:

![Screenshot](/assets/wordpress-import/2024/01/image-13.png)

Then the participant can choose his or her name (this is not necessary for a work or school account):

![Screenshot](/assets/wordpress-import/2024/01/image-14.png)

Now the attendee can vote for the times they are available:

![Screenshot](/assets/wordpress-import/2024/01/image-16.png)

Finally, he can cast his votes:

![Screenshot](/assets/wordpress-import/2024/01/image-17.png)

The organizer receives a notification that the poll has reached consensus and that an appointment has been automatically created:

![Screenshot](/assets/wordpress-import/2024/01/image-18.png)

The hold times in your calendar are removed and the meeting is scheduled:

![Screenshot](/assets/wordpress-import/2024/01/image-20.png)

Since we had multiple accepted times (the organizer proposed five times and the attendee accepted three of them), the next available time will be chosen.

## Complex Meetings

When the number of participants is larger, it may be difficult to get consensus for a meeting. Participants may not respond. Then you can send a reminder to vote. Maybe people vote for different times and there is no consensus. Then you can open the poll, manually select the best possible time, and schedule the meeting.

## Conclusion

The scheduling poll is a great tool for speeding up the scheduling process and significantly reducing the steps an organizer goes through (and gets disrupted) to schedule a meeting.

I use the tool daily to schedule Teams meetings with clients.

I hope you enjoyed this article, and I will be writing more about the tools I use to increase my productivity.
