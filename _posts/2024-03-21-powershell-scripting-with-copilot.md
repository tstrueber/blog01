---
layout: post
title: Powershell Scripting with Copilot
date: 2024-03-21 09:27:42.000000000 +01:00
categories:
- How To Guides
tags:
- AI
- Artificial Intelligence
- Copilot for Microsoft 365
- Powershell
permalink: "/powershell-scripting-with-copilot/"
excerpt: How to guide that shows the usage of Copilot for Microsoft 365 for creating
  a Powershell Script to solve a problem.
---
## Introduction

Recently, I was decommissioning an Exchange Server that had several devices configured to relay emails through it. To identify the devices connecting to the server and sending emails, I checked the SMTP receive logs. I will provide more details about this process in a separate article. I used [Log Parser](https://www.microsoft.com/en-us/download/details.aspx?id=24659) to extract the relevant data from the log files. The result was a poorly formatted text file. I aimed to extract the necessary information using Powershell, but I faced difficulties with the appropriate commands. Since LLMs are well-versed in scripting, I decided to rely on Copilot for Microsoft 365 instead of searching the web for useful commandlets.

This article is part of my [Copilot Blog series](https://strueber-it-consulting.de/copilot-blog-series/). You can find additional use cases for Copilot for Microsoft 365 [here](https://strueber-it-consulting.de/copilot-for-microsoft-365-use-cases/).

## The csv file

The original txt file looked like this:

    remote-endpoint Hits
    192.168.0.10:64355 27
    192.168.0.10:52327 26
    192.168.0.10:60594 26
    192.168.0.10:51907 25
    192.168.0.15:64677 25
    192.168.0.15:60575 24
    192.168.0.15:52522 22
    192.168.0.15:56471 22
    192.168.0.15:56595 21
    192.168.0.17:64381 21
    192.168.0.20:64281 20

## remove the blank characters

My first step was to remove the blank spaces. I chose to use Copilot within Teams because it is the most convenient option for me. I asked Copilot the following:

![]({{ '/assets/wordpress-import/2024/03/image-36-1024x452.png' | relative_url }})

The command worked as intended. I exported the output to a new file for further use.

    remote-endpoint Hits
    192.168.0.10:64355 27
    192.168.0.10:52327 26
    192.168.0.10:60594 26
    192.168.0.10:51907 25
    192.168.0.15:64677 25
    192.168.0.15:60575 24
    192.168.0.15:52522 22
    192.168.0.15:56471 22
    192.168.0.15:56595 21
    192.168.0.17:64381 21
    192.168.0.20:64281 20

## Delete the Port from the table

I imported the txt file using the import-csv command and set the delimiter option to 'space'. Then, I removed the port from the remote-endpoint column:

![]({{ '/assets/wordpress-import/2024/03/image-37-1024x880.png' | relative_url }})

The final result looks like this. It is displayed only in Powershell and has not been exported:

![]({{ '/assets/wordpress-import/2024/03/image-38.png' | relative_url }})
## Add up everytime you find a similar value

I want to count hits for each IP address that occurs multiple times.

![]({{ '/assets/wordpress-import/2024/03/image-39-1024x937.png' | relative_url }})
## Export the result

And I was satisfied with the result:

![]({{ '/assets/wordpress-import/2024/03/image-40.png' | relative_url }})

The export failed. I then verified the object's type:

![]({{ '/assets/wordpress-import/2024/03/image-41-1024x478.png' | relative_url }})

I asked Copilot for help because I am unfamiliar with working with this type of object.

![]({{ '/assets/wordpress-import/2024/03/image-42.png' | relative_url }})

This was exactly what I needed. I was able to export the information to a CSV file:

![]({{ '/assets/wordpress-import/2024/03/image-43.png' | relative_url }})
## Conclusion

Copilot assisted me in finding a solution to a problem I encountered. I had to make minor adjustments to the commandlets provided to make them fit into my complete script. But it helped me a lot to make progress. While there may have been alternative approaches to the solution, I am currently satisfied with the outcome.

I hope you enjoed this article!
