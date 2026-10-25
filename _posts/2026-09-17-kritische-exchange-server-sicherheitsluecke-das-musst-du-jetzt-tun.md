---
layout: post
title: "Kritische Exchange Server Sicherheitslücke: Das musst du jetzt tun"
date: 2026-09-17 13:26:40.000000000 +02:00
categories:
- YouTube
tags:
- Exchange Server
- Exchange Online
- Microsoft 365
- Exchange Hybrid
- Security
- Patch Management
permalink: "/kritische-exchange-server-sicherheitsluecke-das-musst-du-jetzt-tun/"
excerpt: "Ungepatchte Exchange Server sind ein akutes Sicherheits- und Betriebsrisiko. Mit dem Exchange Health Checker prüfe ich den Patch-Stand und plane die nächsten Schritte."
image:
  path: "/assets/img/youtube-thumbnails/qPYRWEuwVuU.jpg"
  alt: "Kritische Exchange Server Sicherheitslücke: Das musst du jetzt tun"
---
Wer noch einen Exchange Server On-Premises betreibt, sollte jetzt den Patch-Stand prüfen. Laut einem [Heise-Bericht](https://www.heise.de/news/Exchange-Sicherheitsluecke-85-Prozent-der-On-Prem-Server-in-Deutschland-anfaellig-11434785.html) waren 85 Prozent der untersuchten On-Premises-Server in Deutschland nicht ausreichend geschützt. Ungepatchte Systeme sind damit ein erhebliches Sicherheitsrisiko – gerade in einer Exchange-Hybrid-Umgebung.

## Patch-Stand zuverlässig prüfen

Für die erste Bestandsaufnahme nutze ich den [Microsoft Exchange Health Checker](https://microsoft.github.io/CSS-Exchange/Diagnostics/HealthChecker/). Er zeigt mir, ob wichtige Security Updates fehlen und ob der Server auf einem aktuellen, unterstützten Stand ist. Neue Hinweise und Updates verfolge ich außerdem im [Microsoft Exchange Team Blog](https://techcommunity.microsoft.com/category/exchange/blog/exchange).

Regelmäßiges Patchen schützt nicht nur vor Sicherheitslücken. Veraltete Exchange Server können den laufenden Betrieb beeinträchtigen: Microsoft kann den Mailflow nicht ausreichend aktualisierter Hybrid-Server zu Exchange Online [drosseln oder blockieren](https://techcommunity.microsoft.com/blog/exchange/exchange-20162019-throttling-and-blocking-up-to-the-final-public-update-baseline/4552717).

{% include youtube-consent.html id="qPYRWEuwVuU" title="Kritische Exchange Server Sicherheitslücke: Das musst du jetzt tun" %}

## Exchange 2016 und 2019: Jetzt entscheiden

Bei Exchange Server 2016 und 2019 prüfe ich nicht nur das aktuelle Security Update, sondern auch die weitere Strategie. Die Exchange Server Subscription Edition ist inzwischen besonders relevant. Alternativ kann es sinnvoll sein, den lokalen Exchange Server vollständig abzulösen. Entscheidend ist, weder Migration noch Updates aufzuschieben.

## Kapitel

- [00:00 Exchange Server: Jetzt handeln](https://www.youtube.com/watch?v=qPYRWEuwVuU)
- [00:24 85 % der Exchange Server ungepatcht?](https://www.youtube.com/watch?v=qPYRWEuwVuU&t=24s)
- [01:04 Kritische Sicherheitslücke erklärt](https://www.youtube.com/watch?v=qPYRWEuwVuU&t=64s)
- [01:34 Patch-Stand mit dem Health Checker prüfen](https://www.youtube.com/watch?v=qPYRWEuwVuU&t=94s)
- [02:02 Aktuelles Exchange Security Update](https://www.youtube.com/watch?v=qPYRWEuwVuU&t=122s)
- [02:30 Exchange 2016 & 2019: Was jetzt?](https://www.youtube.com/watch?v=qPYRWEuwVuU&t=150s)
- [02:54 Exchange Server ablösen oder aktualisieren](https://www.youtube.com/watch?v=qPYRWEuwVuU&t=174s)
- [03:27 Microsoft throttelt veraltete Hybrid-Server](https://www.youtube.com/watch?v=qPYRWEuwVuU&t=207s)
- [04:20 Updates & Exchange News im Blick behalten](https://www.youtube.com/watch?v=qPYRWEuwVuU&t=260s)

Fragen zu Exchange Server, Exchange Online, Microsoft 365 oder Hybrid-Umgebungen greife ich gern auf. Passende Themen auf YouTube sind [#ExchangeServer](https://www.youtube.com/hashtag/exchangeserver), [#Microsoft365](https://www.youtube.com/hashtag/microsoft365) und [#ExchangeOnline](https://www.youtube.com/hashtag/exchangeonline).
