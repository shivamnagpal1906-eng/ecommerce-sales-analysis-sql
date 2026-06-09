\# Business Overview — Ecommerce Sales Analysis



**\*\*Author:\*\*** Shivam Nagpal

\*\*Date:\*\* June 2026



\---



\## 1. What This Business Does



This is a mid-to-premium multi-category lifestyle ecommerce platform serving Indian customers. The catalogue spans four verticals — Apparel, Electronics, Beauty, and Home — with 14 sub-categories ranging from Skincare and Headphones to Bedding and Jackets.



The average order value of ₹8,878 rules out budget positioning. This is not a price-war business. Customers are spending meaningfully, across categories, repeatedly.



\---



\## 2. Scale



| Metric                      | Value                          |

|-----------------------------|--------------------------------|

| Registered Customers        | 10,000                         |

| Total Orders                | 40,000                         |

| Data Window                 | 28 Sep – 27 Dec 2025 (3 months)|

| Average Order Value         | ₹8,878                         |

| Average Orders per Customer | 4.0                            |



40,000 orders from 10,000 customers over 3 months means every customer ordered, on average, once every three weeks. That is an unusually high repeat rate for ecommerce — most platforms consider 1.5–2 orders per customer per year a success. Either this business has built something genuinely sticky, or the festive season window is doing a lot of heavy lifting. We cannot tell which without a full year of data.



One number worth watching: 9,827 of 10,000 registered customers placed at least one order — a 98.3% conversion rate from registration to purchase. That figure is too high to reflect normal user behaviour and may indicate the dataset only captures already-active customers rather than the full registered base.



\---



\## 3. What I Noticed



\### 3.1 We Are Looking at Peak Season Data Only — and That Matters



The entire dataset falls within India's festive shopping window: Navratri, Diwali, and Christmas. Every metric here — volumes, order frequency, basket size — reflects the best three months of the retail calendar. Treating this as representative of annual performance would be a mistake.



The first priority before any strategic decision should be getting data from a non-festive quarter to establish a true baseline.



\---



\### 3.2 A Data Quality Issue That Will Corrupt Reporting if Left Unchecked



The order status column contains the same values in inconsistent formats — `delivered`, `DELIVERED`, and `Delivered` co-exist as separate entries, as do three variants of `shipped`. A raw count of delivered orders today would undercount by roughly 1%.



Small now, but this will compound as the dataset grows and will silently break any dashboard built on top of it. Recommend enforcing lowercase constraints at the data entry layer and running a one-time clean on existing records.



\---



\### 3.3 Skincare Leads, But No Category Dominates — and That Is the Real Story



With 6,510 orders, Skincare tops the sub-category rankings. But the gap between first (Skincare, 6,510) and last (Bedding, 5,029) is surprisingly narrow for a catalogue this broad.



In most multi-category platforms, one or two verticals carry the majority of volume. The even spread here either reflects disciplined catalogue management or a festive-season effect that lifts all categories uniformly. Worth revisiting once full-year data is available.



\---



\*This overview is based on 3 months of transactional data (Sep–Dec 2025).

All figures should be treated as peak-season snapshots until full-year data is available.\*

