# Omni-Injector & Secret Validator

**100% client-side** secret scanner / impact classifier / verifier / env injector.

## Security model
- No backend. No telemetry server.
- Parsing & classification run in the browser only.
- Optional **Live Verify** calls go from *your browser* to the provider (OpenAI / xAI / Anthropic / Gemini).
- Stripe, DB, Discord, Firebase-class secrets use **terminal scripts** (CORS).
- Secrets can be saved to `sessionStorage` (tab-scoped) only if you click **Save**.

## Use
Open `index.html` in a browser, or:
```bash
npx serve .
```

## Live (CDN)
After push: `https://raw.githack.com/cantgetalonggta-png/omni-injector/main/index.html`
