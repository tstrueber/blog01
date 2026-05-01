---
layout: post
title: "EWS Abschaltung: So findest du betroffene Apps"
date: 2026-04-21 12:00:00.000000000 +02:00
categories:
- YouTube
tags:
- Microsoft 365
- Security
permalink: "/ews-abschaltung-so-findest-du-betroffene-apps/"
excerpt: "Ich zeige dir, wie du herausfindest, welche Anwendungen in deinem Microsoft 365 Tenant noch auf EWS (Exchange Web Services) zugreifen – und warum du jetzt..."
image:
  path: "/assets/img/youtube-thumbnails/XhNo_uC4G4o.jpg"
  alt: "EWS Abschaltung: So findest du betroffene Apps"
---
Ich zeige dir, wie du herausfindest, welche Anwendungen in deinem Microsoft 365 Tenant noch auf EWS (Exchange Web Services) zugreifen – und warum du jetzt handeln solltest.

Microsoft wird EWS in Exchange Online abschalten. Viele Unternehmen haben jedoch noch Anwendungen im Einsatz, die diese Schnittstelle nutzen. Genau hier wird es kritisch: Wenn du diese Apps nicht rechtzeitig identifizierst und umstellst, können Prozesse und Integrationen plötzlich nicht mehr funktionieren.

{% include youtube-consent.html id="XhNo_uC4G4o" title="EWS Abschaltung: So findest du betroffene Apps" %}

## Darum geht es

- wie du EWS-Nutzung in deinem Tenant analysierst
- welche Tools und Skripte du dafür verwenden kannst
- wie du App Registrations korrekt einrichtest
- welche Berechtigungen notwendig sind
- wie du aktive und inaktive Anwendungen unterscheidest
- Am Ende weißt du genau, welche Apps betroffen sind und wie du die Migration vorbereitest.

## Meine Einordnung

Ich zeige, worauf Administratoren jetzt achten sollten und welche nächsten Schritte sinnvoll sind. Mir geht es dabei nicht um Theorie, sondern um konkrete Erfahrungen, Learnings und Entscheidungen, die im Arbeitsalltag wirklich relevant werden.

## Links

- [https://techcommunity.microsoft.com/blog/exchange/notes-from-the-field-finding-and-remediating-ews-app-usage-before-retirement/4496469](https://techcommunity.microsoft.com/blog/exchange/notes-from-the-field-finding-and-remediating-ews-app-usage-before-retirement/4496469)
- [https://github.com/tstrueber/M365Public/blob/main/Exchange/EWS%20Usage%20Report/Execute_Find-EwsUsage.ps1](https://github.com/tstrueber/M365Public/blob/main/Exchange/EWS%20Usage%20Report/Execute_Find-EwsUsage.ps1)
