# Timos Blog

Ein einfacher Blog-Starter mit **Jekyll** und **GitHub Pages**.

## Enthalten

- Jekyll-Konfiguration
- GitHub Pages Workflow
- Startseite
- About-Seite
- Beispiel-Post
- kleine CSS-Anpassung

## Lokal starten

Voraussetzung: Ruby + Bundler

```bash
bundle install
bundle exec jekyll serve
```

Dann öffnen:

```text
http://127.0.0.1:4000
```

## Auf GitHub Pages deployen

1. Lege ein neues GitHub-Repo an.
2. Kopiere den Inhalt dieses Ordners (`blog/`) in das Repo.
3. Push auf `main`.
4. Aktiviere in GitHub unter **Settings → Pages** die Quelle **GitHub Actions**.

Der Workflow liegt hier:

```text
.github/workflows/pages.yml
```

## Wichtige Dateien

- `_config.yml` → Titel, Beschreibung, URL
- `_posts/` → Blogposts
- `about.md` → Über-mich-Seite
- `assets/css/style.scss` → kleine Design-Anpassungen

## Nächste sinnvolle Schritte

- Blogtitel anpassen
- Beschreibung anpassen
- erstes echtes Posting schreiben
- optional: eigene Domain verbinden
