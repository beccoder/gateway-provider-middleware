# Gateway → Provider Middleware (Ruby on Rails)

## Overview

This project implements a **middleware** between a **Gateway** and a **Provider** for a redirect-based payment flow.

Flow:
1. Gateway calls `POST /gateway/transactions`
2. Middleware calls Provider `POST /transactions/init`
3. Middleware returns `redirect_url`
4. Gateway redirects user to `/transactions/auth/:id`
5. Middleware calls Provider `PUT /transactions/auth/:id`
6. User sees `success` or `failed`

All Provider calls are stubbed in tests.

---

## Limitations / Improvements

- No persistence (transactions are not stored)
- No idempotency for duplicate requests
- Minimal input validation
- No retries, logging, or metrics
- Simplified error handling 

---

## Security Issues

- No authentication between Gateway and Middleware and Provider
- No replay protection (same URL can be reused)
- Provider responses are fully trusted
- No rate limiting
- No input data validation
---

## Run

```bash
bundle install
bundle exec rails server
bundle exec rspec
```

Actually, after golang, I was going to learn one of high level, dynamic languages and I really liked Ruby on Rails. I see it as a good language to realise MVPs, start-up projects faster. So, I want to continue on this mini project. In the next versions, I want to do the improvements I mentioned above. 

Upcoming: Error handling and data validation. 