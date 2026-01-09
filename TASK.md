# Junior Ruby on Rails Task – Gateway / Provider Middleware

## Intro 

Our system is a **middleware** that sits between the Gateway and the Provider. The user always interacts with the Gateway.
When the user starts a payment or similar flow, the Gateway sends a `POST` request to our system.
Our system forwards this request to the Provider’s init endpoint, and the Provider responds with a **transaction id** and **status**, not a `redirect_url`.
Our system then builds **its own URL** (for example `https://our-app.test/transactions/auth/:transaction_id`) and returns this URL to the Gateway as `redirect_url` in the response.
The Gateway uses this URL to redirect the user into our system; when the user follows this URL, they reach that route in our app. Once the user is on that URL, our system calls the Provider’s `PUT /transactions/auth/:id` to authorize the payment and then shows “success” or “failed” depending on the Provider’s response. [conversation_history:1]

---

## Task description

Build a small Ruby on Rails application that sits between a **Gateway** system and a **Provider** system. [conversation_history:1]

The app must: [conversation_history:1]

- Expose an endpoint that the Gateway calls to start a transaction.  
- Call the Provider’s API to initialize a transaction and receive a transaction id and status.  
- Construct and return a `redirect_url` in our own system back to the Gateway.  
- Handle the redirected user by calling the Provider again to authorize and then displaying “success” or “failed”.  
- Be fully covered by tests that stub the Provider; no real HTTP calls may be made.  

---

## Functional requirements

### 1. Gateway → Our system (init)

1. Implement an endpoint, for example:  
   `POST /gateway/transactions`  

   - This simulates the call **from the Gateway to our system** when the user initiates a payment or similar flow.  
   - Request body can be simple JSON, e.g.  
     ```json
     { "amount": 1000, "currency": "EUR", "id": "unique_id"}
     ```  
   [conversation_history:1]

2. When the Gateway calls this endpoint, the application must: [conversation_history:1]

   - Forward the call to the Provider’s init endpoint, for example:  
     `POST https://provider.example.com/transactions/init`  
   - Assume the Provider returns JSON like:  
     ```json
     { "transaction_id": "123", "status": "pending" }
     ```  
   - Construct a URL in **our** system using this `transaction_id`, for example:  
     ```text
     https://our-app.test/transactions/auth/123
     ```  
   - Respond to the Gateway with JSON containing this URL as `redirect_url`, for example:  
     ```json
     { "redirect_url": "https://our-app.test/transactions/auth/123" }
     ```  
   - The Gateway will later redirect the user to this `redirect_url` (second step).  

---

### 2. User redirected → Our system → Provider (auth)

1. Implement a user-facing endpoint, for example:  
   `GET /transactions/auth/:id`  

   - This represents the URL contained in the `redirect_url` from step 1.  
   - The user reaches this endpoint after the Gateway redirects them using the `redirect_url`.  
   [conversation_history:1]

2. When a user reaches this endpoint, the application must: [conversation_history:1]

   - Call the Provider’s **auth** endpoint:  
     `PUT https://provider.example.com/transactions/auth/:id`  
   - Based on the Provider’s response:  
     - If successful (e.g. HTTP 200 and JSON `{ "status": "success" }`), render a simple response saying **“success”**.  
     - If failed (e.g. non-2xx or JSON `{ "status": "failed" }`), render a simple response saying **“failed”**.  

## Acceptance criteria

- Please use Ruby On Rails 
- Develop the app according which solves the problem described above.
- All HTTP calls to the Provider must be stubbed in tests (no real external HTTP).  
- The test suite passes and the code is reasonably clear and maintainable.  
- Identify security issues 
[conversation_history:1]

