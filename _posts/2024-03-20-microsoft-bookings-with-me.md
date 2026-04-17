---
layout: post
title: Microsoft Bookings with me
date: 2024-03-20 08:29:25.000000000 +01:00
categories:
- How To Guides
tags:
- Bookings with me
- Microsoft 365
- Microsoft Bookings
- Productivity
permalink: "/microsoft-bookings-with-me/"
excerpt: How to guide describing setting up a Microsoft Bookings with me page and
  showing how the booking process looks from a customer perspective.
---
## Introduction

Recently, I have been thinking a lot about how to improve scheduling with my clients. Using [Scheduling Poll](https://strueber-it-consulting.de/microsoft-scheduling-poll/) improved the burden of multiple interruptions of my work because of back and forth emails to find an appointment. I had heard about Microsoft Bookings, but when I looked at the tool, it was a bit overkill for my frequent appointments with my clients, with whom I am in regular contact. Just recently I found the tool [Bookings with me](https://support.microsoft.com/en-au/office/bookings-with-me-setup-and-sharing-ad2e28c4-4abd-45c7-9439-27a789d254a2) and I would like to share this with you. With this tool you create a booking page where external users with access to the page can search for a free time slot in your calendar and schedule a meeting with you directly. After successful scheduling, an invitation with a link to a Teams meeting is sent to the attendee and the organizer receives a short notification.

## Prerequisites for Bookings with me

To use Microsoft Bookings, you need a mailbox in Exchange Online and a license that includes the service plan. Ensure that the service plan is enabled for your user. Refer to the Microsoft documentation for detailed prerequisites:

[Bookings with me | Microsoft Learn](https://learn.microsoft.com/en-us/microsoft-365/bookings/bookings-in-outlook?view=o365-worldwide)

## Create your Bookings with me page

To begin using Bookings with me, open the Outlook web app, switch to your calendar view, and click on 'Go to my booking page':

![]({{ '/assets/wordpress-import/2024/03/image-24-1024x534.png' | relative_url }})

It is recommended to create a new meeting type instead of altering the initial one. I encountered an issue when trying to modify the initial meeting type, which resulted in an inconsistent state. The issue was resolved only after deleting the initial meeting type. Please create a new meeting type:

![]({{ '/assets/wordpress-import/2024/03/image-25-1024x417.png' | relative_url }})

Configure your new meeting type settings:

![]({{ '/assets/wordpress-import/2024/03/image-26-1024x616.png' | relative_url }})
1. The name of the new meeting type will also serve as the title of the appointment that will be created.
Consider including your name in the title to ensure that the customer knows they have a meeting with you.
2. Provide a brief description of the meeting type and its duration.
3. You can choose whether or not to display the meeting type on your public Bookings with me page.
4. Consider removing the link to your personal Bookings with me page from your email signature, as it did not work well during testing.

You can customize the time window for scheduling meetings:

![]({{ '/assets/wordpress-import/2024/03/image-27-1024x693.png' | relative_url }})

You can specify buffer time before and after the meeting or limit the start time for scheduled appointments to 30-minute intervals or full hours. With a lead time of one day, you have enough time to prepare for a created appointment. Click 'Save' in the top right corner when you're done:

![]({{ '/assets/wordpress-import/2024/03/image-28-1024x690.png' | relative_url }})

This brings you back to your Bookings with me page. From here, you can choose to share a link to your specific meeting type or your entire Bookings with me page. Here, I am sharing the link to my newly created meeting type:

![]({{ '/assets/wordpress-import/2024/03/image-29-1024x441.png' | relative_url }}) ![]({{ '/assets/wordpress-import/2024/03/image-30.png' | relative_url }})

Now you can share the link with someone you want to schedule a meeting with.

## Booking an appointment

When a customer clicks on the provided link, they are directed to the following site. They can choose to log in with their M365 account or continue as a guest if they are not an M365 user:

![]({{ '/assets/wordpress-import/2024/03/image-31-1024x693.png' | relative_url }})

Choose the meeting type and select a day and time that suits you, then click continue:

![]({{ '/assets/wordpress-import/2024/03/image-32-1024x811.png' | relative_url }})

To schedule the appointment, please provide your name, email address, and a brief description:

![]({{ '/assets/wordpress-import/2024/03/image-33.png' | relative_url }})

Before scheduling the appointment, you must enter a verification code sent to your email address. If you use an M365 account, you can eliminate the need for additional verification because it uses your authentication.

The owner of the Bookings with me page receives an email verification for the successful booking. (Apologies for booking an appointment with the same name as the page owner.)

![]({{ '/assets/wordpress-import/2024/03/image-34.png' | relative_url }})

The appointment is scheduled in the calendar, and an invitation is sent out to the attendee with a link to a Teams meeting. As the organizer, you can directly cancel the meeting from your inbox or edit it:

![]({{ '/assets/wordpress-import/2024/03/image-35-1024x686.png' | relative_url }})
## Conclusion

The Booking service plan is included in almost every license, allowing you to use this service without any additional cost. This service reduces the back and forth of emails or Teams messages when finding an appointment, providing your customer with a link to book an appointment themselves. Recently, I received positive feedback from my customers regarding the usage of Bookings, indicating that they also benefit from this tool.

I hope you enjoyed this article!
