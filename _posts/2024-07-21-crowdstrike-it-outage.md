---
layout: post
title: CrowdStrike Update leads to global IT-Outage
date: 2024-07-21 15:40:50.000000000 +02:00
categories:
- Architecture
- Review
tags:
- Availability
- IT-Processes
permalink: "/crowdstrike-it-outage/"
excerpt: Learn about the recent global IT outage caused by a CrowdStrike update. Discover
  key principles to avoid such incidents in the future and ensure your company’s IT
  resilience.
---
## Introduction

I think it'd be a good idea to write a new blog article about the recent, declared greatest IT outage of all time. I was chatting with my father-in-law about this last afternoon. In this article, I'll share my thoughts on the incident and what companies should focus on to reduce the likelihood of being hit by such an outage. I'm not going to get into the nitty-gritty of how to fix the systems or get into the weeds about what caused the problem.
If you want to know more about the outage, CrowdStrike has published an article explaining why it happened and how to get around it:
[Falcon Content Update Remediation and Guidance Hub | CrowdStrike](https://www.crowdstrike.com/falcon-content-update-remediation-and-guidance-hub/)

## CrowdStrike Falcon

CrowdStrike is a cybersecurity tech company that provides endpoint protection, threat intelligence, and incident response services. The company was founded in 2011 and has grown to become a leader in cybersecurity - it is known for its innovative and effective solutions to protect against advanced cyber threats. CrowdStrike Falcon is the company's main software platform, designed to offer comprehensive endpoint protection. It offers Next-Generation Antivirus, Endpoint Detection and Response, and more. CrowdStrike and its Falcon platform are highly regarded in the cybersecurity industry for their effectiveness in protecting against modern cyber threats through innovative technology and expert services. That's why so many companies are using this software.

## What happened?

CrowdStrike dropped a new update for the Falcon platform endpoint sensor on Friday, July 19, 2024. As soon as the Windows clients installed the update, the operating system crashed and the system shut down (bluescreen).

Since it was so deeply integrated into the operating system, you couldn't get the affected system to start up again afterwards. CrowdStrike got a fix out pretty quickly, but it has to be implemented by an administrator. You can either boot the system in safe mode and modify some files or use a prepared USB stick to boot from. Another thing to keep in mind is that Bitlocker—Microsoft's disk encryption technology—might get in the way of the administrator doing the workaround.

![Image from freepik.com](/assets/wordpress-import/2024/07/3970289-1024x1024.jpg)

There is also a official information from the BSI regarding the incident: [BSI - Weltweite IT-Ausfälle (bund.de)](https://www.bsi.bund.de/DE/Themen/Unternehmen-und-Organisationen/Cyber-Sicherheitslage/Analysen-und-Prognosen/Threat-Intelligence/Krisen-Grosslagen/Crowdstrike_Microsoft/Crowdstrike_Microsoft_node.html)

## How can you as a company avoid such problems in the future?

I'd like to talk about a few key principles in IT that can help you as a company to avoid comparable disasters in the future. You have no control what updates a software vendor publishes but you can do some testing before you roll it out in your company or you can have a fallback plan.

### Test Updates prior to rollout / rollout in waves

When a new version gets released from a distributor, it's not usually a good idea to roll it out across your whole company all at once. It's a good idea to test the update on a few test endpoints and run some basic functionality tests, like your most business-critical applications. Once you've got everything up and running smoothly, you can start enrolling the update in waves. You might want to try enrolling the update first to a small group of users. Once you've got it working well, you can enroll it in as many waves as you need to. It's important to remember that you should differentiate between feature updates and security updates. Security updates should be enrolled as fast as possible, but you still need to follow the enrollment process. You should try to reduce the time between each step, but stick to the procedure.

### Have a fallback plan / redundant system

This one's a bit more complex than the first one. If something goes wrong with the critical system, you need to have a backup system ready to take over and keep things running smoothly. This could be a system that's set up exactly the same, but you've somehow separated from the main system. In the recent case, this could be a system that's on a different update wave than the productive system. If the productive system goes down, you've got a plan in place to switch over to the backup system and get the critical business process up and running again.

## Conclusion

This recent incident shows why it's a good idea for companies to think about putting processes and fallback plans in place to protect themselves from such a widespread outage. It's not just cyber threats that we need to watch out for. Over the past few years, we've been pretty focused on security, but we've kind of forgotten about other potential risks like installing updates to our systems.

If you liked this article, please leave a comment. Thanks!
