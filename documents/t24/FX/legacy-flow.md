1. Get exchange rate

2. Get Holidays

3. Get Working Schedules

4. /payments/v4/id

    4.1 Generate paymentSessionId
    
    4.2 

5. /payments/v3/payment-profiles/extends

6. FxCountries

=> Get from config service. Don't need to change

7. /payments/v3/inquiry -> /bookings/inquiry

    7.1 Find booking (from VIETJET or OTHER airplane)

    7.2 Destination country and currency

    7.3 Booking validation

        7.3.1 VIETJET only: customer passport

        7.3.2 InternalFxTradingInquiryController.java:33 POST /bookings/inquiry

        7.3.3 VietJet only: the booking must be PAID	

        7.3.4 Must be after today (VN time)

        7.3.5 Today must not be an FCC holiday

    7.4 FCC Inquiry Order

        7.4.1 The remaining limit for this passport

        7.4.2 The current rate and multiplier

        7.4.3 ListBranch: where the cash can be collected

        7.4.4 EligibleCollectionDates

{
  “timestamp”: “2026-11-05T06:00:57.202Z”,
  “durationMs”: 1467,
  “request”: {
    “method”: “post”,
    “url”: “/payments/v3/inquiry”,
    “headers”: {
      “Accept”: “application/json, text/plain, */*“,
      “Content-Type”: “application/json”,
      “GTW-Authorization”: “Bearer eyJraWQiOiI3LzgxcFMvTmU5OEpCWUJSYm5SWm1aTUFpTHU4NHdxSmthMU1GaktSd0pJPSIsImFsZyI6IlJTMjU2In0.eyJzdWIiOiI1NWJkMjUyOC1lMDUxLTcwODQtNTMxNi1jNTUxYzYyMTEwYjIiLCJpc3MiOiJodHRwczovL2NvZ25pdG8taWRwLmFwLXNvdXRoZWFzdC01LmFtYXpvbmF3cy5jb20vYXAtc291dGhlYXN0LTVfb0h2Z1NRQ1ZJIiwiY2xpZW50X2lkIjoiNms5NG5laHZmYjM1aGFubDZsM3ZsbmFiMWMiLCJvcmlnaW5fanRpIjoiMDE5NmU3M2ItYTYxZi00NTQ0LTk3OTMtNWMzNWM4ODYxMDZjIiwiZXZlbnRfaWQiOiJhZmZiZTNmNi05YzI3LTRlNWEtYTMwYy04ZGIxYmMyOTkzNGEiLCJ0b2tlbl91c2UiOiJhY2Nlc3MiLCJzY29wZSI6ImF3cy5jb2duaXRvLnNpZ25pbi51c2VyLmFkbWluIiwiYXV0aF90aW1lIjoxNzkzODU4NDE1LCJleHAiOjE3OTM4NTkzMTUsImlhdCI6MTc5Mzg1ODQxNSwianRpIjoiNGM2OGY1OTItNmUxMC00NzRjLTlhMDktOTAwNTY1NGZjM2NhIiwidXNlcm5hbWUiOiI2NzY2MTEzMCJ9.RyjVAblUoTUtD3xlRoNgcbw4VJVLJc5UFeSEClBd1IHkn5CPAjF54UVF6SJXqOpGih4NW_0BYgwYGv7SvuBXL6h0WvBzE47EO4oGD7VT-HNOCyDj2p03Keo-45HIG7dY8mpWWbtSeFeGEEl-dQyv7fzEJStJfUWpPkFD7GfM2wBKbiAMazqmpjbJadsRwI5hQZk5miAPoct_geG7bWTkI3c2Nr1mcdMxjahe1Teloxik_XpcvgBw0OxAx37gzYRJO0MKIgQ7lEcTqHpsW9KOsb8KgUzrwg95kzZQUNtZ2guFM8vx2aiDbutP_-KA8WrsI6Oh3ga-9Tims26M2Ixhmg”,
      “OBD-Authorization”: “”,
      “X-Request-ID”: “68ed35b4-8962-4cb8-bb2c-ed612157a444",
      “X-Open-ID”: “59fefcda-cde6-4081-8c78-e09513d5f38c”,
      “X-Platform”: “android”,
      “device-id”: “c8ec4903a41fe64d”,
      “device-version”: “12",
      “device-manufacturer”: “samsung”,
      “app-version”: “3.6.2",
      “x-app-route-config”: “”,
      “x-session-id”: “75ea2523-7467-4788-a59d-5ede6e2a9bda”,
      “x-amz-request-id”: “59fefcda-cde6-4081-8c78-e09513d5f38c”,
      “Cache-Control”: “no-store”,
      “traceparent”: “00-dff940ac83514b8692f1c5ee1e21a937-85706d90ed603d11-01",
      “X-Timestamp”: “2026-11-05T06:00:56.000Z”,
      “X-Payload-Signature”: “RZKIVfv3tetGVj5M2VmpKbt2qmEUMoWJ4mf4et0iDKRLRYQ9H10rne7NxnJREXxIbz9mBTW7YEpM96VF+rzLDA==“,
      “X-Nonce”: “a404c410-f41b-442a-a8ec-73ebfc4f7168",
      “X-Payload-Signature-Version”: “v2"
    },
    “data”: {
      “paymentSessionId”: “gIbPbRDWLZmtXfqfWILX7sDmnP8”,
      “transactionType”: “PMNT_IRCT_FXSE”,
      “fxTrading”: {
        “transactionType”: “PMNT_IRCT_FXSE”,
        “bookingId”: “123",
        “exchangeAmount”: 100,
        “currency”: “USD”,
        “airline”: “OTHER”,
        “arrivalCountryCode”: “DEU”,
        “departureTimestamp”: “2026-11-30T00:00:00.000Z”,
        “passportNumber”: “111”
      }
    }
  },
  “response”: {
    “status”: 200,
    “url”: “/payments/v3/inquiry”,
    “data”: {
      “status”: {
        “code”: “SUCCESS”,
        “message”: null,
        “errors”: null
      },
      “payload”: {
        “bookingId”: “123",
        “fullName”: “TRUONG GIAI HUNG”,
        “nid”: “079202014435",
        “phoneNumber”: “0977867830",
        “dob”: “2002-08-28",
        “gender”: “Male”,
        “departureTimestamp”: “2026-11-30T00:00:00Z”,
        “arrivalTimestamp”: null,
        “departureAirportName”: null,
        “arrivalAirportName”: null,
        “departureCountryCode”: null,
        “arrivalCountryCode”: “DEU”,
        “bookingStatus”: null,
        “chargedAmount”: null,
        “paidAmount”: null,
        “remainingLimit”: 130750000,
        “remainingExchangeLimit”: 5000,
        “fxWorkingHours”: {
          “startHour”: “08:30:00",
          “endHour”: “23:30:00"
        },
        “passportNumber”: “111",
        “eligibleCollectionDates”: [
          “2026-11-05",
          “2026-11-06”,
          “2026-11-07"
        ],
        “currencyRate”: {
          “currency”: “USD”,
          “description”: “United States Dollar”,
          “currencyRate”: 26150,
          “limit”: null,
          “symbol”: null,
          “image”: null,
          “exchangeCurrencyMultiplier”: 100,
          “maxExchangeAmount”: 5000,
          “minExchangeAmount”: 100
        },
        “collectAtBranches”: [
          {
            “locationCode”: “094”,
            “locationName”: “PGD NGUYỄN OANH”,
            “locationAddress”: “101 Nguyễn Oanh”,
            “provinceCode”: “79”,
            “provinceName”: “Hồ Chí Minh”,
            “districtCode”: “26884”,
            “districtName”: “Gò Vấp”,
            “workingHourStart”: null,
            “workingHourEnd”: null,
            “latitude”: “10.8319212”,
            “longitude”: “106.6067537”
          },
          {
            “locationCode”: “109”,
            “locationName”: “PGD HẠNH THÔNG TÂY”,
            “locationAddress”: “7B/3B Quang Trung”,
            “provinceCode”: “79”,
            “provinceName”: “Hồ Chí Minh”,
            “districtCode”: “26898”,
            “districtName”: “Thông Tây Hội”,
            “workingHourStart”: null,
            “workingHourEnd”: null,
            “latitude”: “10.8350518”,
            “longitude”: “106.6548967”
          }
        ],
        “airline”: “OTHER”,
        “fxCountry”: {
          “nationEn”: “Germany”,
          “nationVn”: “Đức”,
          “currencyName”: “Euro”,
          “logo”: “https://vikki-cdn.sit.galaxyfinx.cloud/flag_icon/v1.0.0/de.png”,
          “mainCurrency”: “EUR”,
          “supportedCurrencies”: [
            “EUR”,
            “USD”
          ],
          “countryCode”: “DEU”,
          “default”: false,
          “europe”: false
        }
      },
      “meta”: {
        “requestId”: “9d64ba1a-df9b-43d2-9a22-07585202c527",
        “nextCursor”: null
      }
    }
  }
}

Cash branch mapping

![alt text](image.png)

Current inquiry flow gap

![alt text](image-1.png)

8. Check the quote

FxTradingBookingValidatorImpl.validateFxBill (line 45)

Amount exists	MISSING_EXCHANGE_AMOUNT
FCC returned a remaining limit	MISSING_REMAINING_LIMIT
FCC returned a rate	MISSING_EXCHANGE_RATE
The rate has a min, max and multiplier	INVALID_RATE
Amount ≤ remaining limit	EXCEED_LIMIT
Amount ≥ minimum	INVALID_EXCHANGE_AMOUNT
Amount is a multiple of the multiplier (e.g. 50)	INVALID_MULTIPLIER
FCC’s currency = the requested currency	CURRENCY_MISMATCH
At least one branch	NO_ELIGIBLE_BRANCH
At least one collection date	NO_ELIGIBLE_COLLECTION_DATES

9. /payments/v4/init

9.1 Year-end validation block check: The system triggers the TransactionAtEoyValidator to check if the incoming transaction type is permitted during the year-end closure period, blocking unauthorized transaction types immediately.

9.2 Factory routing and source account validation: The BaseTransactionFactory dispatches the transaction by its transactionType. For FX_PAYMENT_BANK_SELL (where the bank sells and the customer buys foreign cash), it routes the processing to FxTradingTransactionService. Simultaneously, the system validates the payment source, rejecting any accounts that are not CASA (Current Account Savings Account) or a credit card.

9.3 Load cached inquiry result: The service retrieves the FxBill details from Redis. This data was previously stored by the /v4/inquiry endpoint under a composite key consisting of the paymentSessionId and the customer's cif.

9.4 Core network isolation confirmation: The initialization phase explicitly bypasses any external network communication, calling neither the core banking system nor the bill-payment module again, relying strictly on the cached data.

9.5 Multi-tier amount and limit validation: The system performs comprehensive validation on the transaction amount against the cached bill parameters:
• The transaction amount must exactly match the amount specified during the initial inquiry.
• The amount must be equal to or greater than the defined multiplier threshold.
• The amount must be a whole multiple of that same multiplier.
• The amount must not exceed the remainingExchangeLimit associated with the customer's passport profile.

9.6 VND Pricing and debit calculation: The system calculates the local currency value where billedAmount = exchangeAmount × sellRate, rounded to the nearest whole VND. This final figure is set as the transaction's paid amount in VND, which will be debited from the designated CASA account.

9.7 Transaction metadata population: The transaction object is populated with the source account details, channel identifier (VIKKI_BANK), limit type code (PMNT_IRCT_FXSE), the selected branch (exchangeLocationCode), the transaction purpose, and a localized Vietnamese narrative string (formatted as “<name> <nid> mua 1000 USD, …”).

9.8 Core transaction ID generation: The system ensures that both the source account and the customer CIF are fully populated. Upon verification, the transaction-service issues a unique transaction ID.

9.9 Challenge generation and Redis caching: The authentication service evaluates security parameters to determine the required verification method (e.g., OTP, biometrics) and generates an authentication challenge. The system then caches the complete transaction data structure back into Redis and returns the transactionId, paymentSessionId, and the generated challenge payload to the client.

10. /payments/v3/confirm

At confirm, payments-order only places a hold on the customer's VND. Bill-payment creates the FX order later, when two Kafka events from the core arrive: a posting event and a balance event. Those events, which today come from Thought Machine (TM), are the biggest T24 risk in this part of the flow.

## How confirm works today (customer buys foreign cash)

**1. payments-order `/payments/v4/confirm`** (your request, synchronous)
- Loads the cached transaction, checks the challenge, and validates the transaction and `FxBill` (`FxTradingPaymentConfirm.validate`).
- Answers `SUCCESSFUL` right away. The rest runs in the background (`@Async`).

**2. payments-order `PostFxTradingPaymentService`** (background)
- Uses up the customer's transaction limit (`PMNT_IRCT_FXSE`).
- **Authorises (holds)** the VND amount on the customer's CASA through payment-execution, `postTransactionAuthorized`. The posting carries the FX details as metadata: booking id, currency, amount, rate, limit, purpose, passport, and `CREDIT_BRANCH_CODE` / `FX_EXCHANGE_LOCATION_CODE`, which are the chosen branch.
- On failure it marks the transaction failed and rolls the limit back. On timeout it reverses the hold.

**3. Core, then Kafka.** The core publishes a posting event and a balance event:
- `integration.postings_api.interbank_transfer_high.response` (`KAFKA_FX_BILL_POSTING_TOPIC`)
- `vault.core_api.v1.balances.account_balance.events` (`KAFKA_BALANCE_TOPIC`)

**4. bill-payment `FxBillPostingConsumer`**
- Waits until **both** events for the transaction have arrived (a counter in Redis must reach 2). For an `AUTHORIZED` posting with code `FX_PAYMENT_BANK_SELL`, it then calls `createFxTradingBill`.

**5. bill-payment `createFxTradingBill`**
- **Runs the whole inquiry again** (booking, country, validations, FCC inquiry, T24 rate, T24 branches). Then it merges in the booking details but **keeps the rate, amount and branch the customer paid with** (`mergeBookingDetail` ignores those).
- Saves the bill as HELD, then calls **FCC `create-fx-order`** with the bill's sell rate and the branch `locationCode`.
- Stores the FCC payment code and sends the "confirmed" and "authorised" notifications. On error, `fxBillCreationErrorHandler` takes over.

**6. Later, at the branch or by scheduled job** (`InternalFxTradingAtBranchController`, `InternalFxTradingBillController`)
- **Settle** when the cash is handed over, **release** when the order is cancelled or rejected, and **settle the fee**. These go through payment-execution `/v1/internal/transactions/settlement`, `/release` and `/settlement/outbound-hard`.
- They first check the order's status in FCC (`get-list-bill`). Cancellations use `update-order-status`.

## What the T24 migration touches

| # | Area | Today | T24 impact | What's needed |
|---|---|---|---|---|
| 1 | **What triggers order creation** | TM posting event and TM balance event, both required | 🔴 **Highest risk.** cbi publishes only one event after a T24 posting (`cbi.api.v1.postings.posting_instruction_batch.processing-event`), and there is no T24 balance event. If the counter never reaches 2, **no order is created after the customer has paid.** cbi's own code says it waits for "T24 CDC" to feed posting events. | Decide the T24 trigger: consume the cbi event with the counter lowered to 1, have T24 CDC events, or have payments-order call bill-payment directly. Also confirm the cbi event has the same shape and FX metadata (`transaction_code`, `fx_*`) that `mapToFxBillFromAuthorizationPosting` reads. |
| 2 | **Hold, settle, release, reverse** | payment-execution → TM | 🟡 Owned by the payments team. cbi already has a T24 authorise/settlement handler (`T24AuthSettlementHandler`). | Confirm with payments that `FX_PAYMENT_BANK_SELL` authorise, settle, release and reversal reach T24 through cbi, including the timeout and reversal path. |
| 3 | **Branch code in the posting** | `CREDIT_BRANCH_CODE` = FCC branch code (e.g. `094`) | 🟡 Now a T24 `companyId` (`VN0010002`) | Confirm which branch or company T24 should credit, and whether cbi expects `companyId` or `subDivisionCode`. |
| 4 | **Re-inquiry after payment** | FCC inquiry | 🟡 Already covered by the inquiry migration (T24 rate and branches). | It must not fail after the money is held. For example, if the branch's vault cash runs out between confirm and this step, the branch check fails and the bill goes to the error handler. Decide whether this step should skip the cash and limit checks. |
| 5 | **FCC order calls** (`create-fx-order`, `get-list-bill`, `update-order-status`) | FCC | ❓ No T24 equivalent | Is FCC staying as the FX order system, or does T24 replace it? If it stays: will FCC accept a T24 rate and a T24 `companyId`? If it's replaced: T24 needs order, status and cancel APIs. |
| 6 | **Limit after the order** | FCC lowers the passport's remaining limit when the order is created | 🔴 Tied to the inquiry gap | Whatever replaces FCC's `remainingLimit` must count this order, or the next inquiry will show the old limit. |
| 7 | payments-order confirm code | — | ✅ No change | It only validates the cached bill and posts through payment-execution. |

## Summary
- **payments-order:** no code change, provided payment-execution routes FX postings to T24.
- **bill-payment:** the event trigger (#1) is the critical change. Without it, customers are charged and no FX order is ever created.
- **For the BA:** #5 and #6 decide how much of FCC goes away. #3 and #4 are smaller confirmations.


11. /cancel/inquiry

1. Checks the EOD restriction: cancellation inquiry is rejected during the configured end-of-day window.
2. Checks eligibility: the local bill must be HELD, and the FCC order must be BOOK.
3. Gets the current exchange rate and calculates:Fee = max(original VND hold − foreign amount × current bank buy rate, 0)
4. Returns the preview for the mobile confirmation screen.

12. /cancel/confirm

When the customer confirms cancellation, the system:
1. Checks eligibility: the local FX bill must still be held, and the FCC order must remain booked.
2. Recalculates the cancellation fee using the current bank buy rate, with a minimum fee of zero.
3. Cancels the FX order in FCC, recording the customer’s reason and cancellation reference.
4. Releases the original held funds back into the customer’s available balance.
5. Restores the daily transaction limit if the booking was created today.
6. Charges the cancellation fee, if greater than zero.
7. Saves the result and sends notifications for cancellation, released funds, and any fee.
Customer outcome: the FX booking is cancelled, and the original held amount becomes available again, minus any cancellation fee.



| Identifier | Business purpose | Where it originates |
|---|---|---|
| `paymentSessionId` | Connects the mobile inquiry, initialization, and confirmation steps; identifies cached payment state | Payment-service generates it when the payment session starts |
| `bookingId` / `booking_id` | Identifies the travel/airline booking supporting the FX purchase | Supplied in the inquiry; looked up with the booking provider. For `OTHER` airline, retained from customer input |
| `transactionId` / `authorization_transaction_id` | Main bank-side reference for the FX purchase and its initial money hold | Transaction-service generates it during payment initialization |
| `referenceNumber` | Another payment-message reference | In this FX initialization flow, assigned the **same value as `transactionId`** |
| `client_batch_id` | Carries the bank’s transaction reference into the core posting request | Payment-execution sets it to `transactionId` |
| `client_transaction_id` | Identifies an individual instruction within that payment | Payment-execution derives it as `<transactionId>_<instruction index>` |
| Posting batch `id` | Identifies the particular posting batch processed by the core | Returned in the core posting result |
| Posting instruction `id` | Identifies one instruction inside the core batch | Returned in the core posting result |
| `request_id` / `create_request_id` | Identifies the request to perform a particular posting operation | Payment-execution constructs it from posting type, transaction ID, and sometimes a timestamp |
| `fx_bills.id` | Local bill-payment database primary key | PostgreSQL sequence when the bill is inserted |
| `paymentCode` / `payment_code` | Reference used to identify the FX order for collection, status queries, and cancellation | **Vikki:** returned by FCC as `refCode` when create FX order
| `cancellation_ref_code` | External reference for cancellation of the FX order | Returned by the FCC update-order-status call |
| `fee_transaction_id` | Bank-side reference for the separate cancellation-fee debit | Transaction-service generates a new ID when a positive fee is charged |

Charge request flow
T24PaymentAdapter -> T24ChargeHandler -> T24ChargeRequestStrategy.call() -> T24PaymentClient
