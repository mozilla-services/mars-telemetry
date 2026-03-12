# mars-telemetry

This repo contains the yaml files specifying the metrics collected by the Mozilla Ads Routing Service (MARS).

[MARS repo](https://github.com/mozilla-services/mars )

[MARS Glean dictionary](https://dictionary.telemetry.mozilla.org/apps/ads_backend)

# Background

MARS is a backend API service that functions as a privacy-preserving proxy bewteen Firefox and third party ad providers.

MARS handles requests for ads from the Firefox browser, processes them to redact or anonymize our users' information, forwards along these anonymized requests to third party ad providers, and returns privacy-respecting, tracker-free ads to Firefox.

Some examples of these ads are the Sponsored Shortcuts and Sponsored Stories found on Firefox's Home and New Tab.

An example of how MARS functions to preserve user privacy:
* Instead of passing the Firefox user's potentially fingerprintable User Agent string to ad partners, MARS sends along only the user's OS and whether they are on Desktop, Tablet, or Phone. The ad partner gets enough information to return an ad appropriate for the device, but has no way to identify, fingerprint, or track any user.

# Data Collection in MARS with Glean

MARS is a stateless service and doesn't collect or store any data itself. The only data it persists is via Glean ping to Mozilla's data warehouse. MARS also plays a privacy-preserving proxy role between Firefox users and our own data warehouse.

## Necessary data

MARS needs to collect some anonymized, agreggated data about user interactions with ads in order to do business with our third party ad partners and advertisers, and for our financial record keeping. This is because we are paid based on these interactions, for example by how many times we show an ad, or by how many times an ad gets clicked. This is Category 2 "Interaction" data, captured via our [interaction ping](https://dictionary.telemetry.mozilla.org/apps/ads_backend/pings/interaction).

MARS also collects some anonymized, agreggated data to ensure our systems are functioning correctly and our third party partners are meeting their contractual obligations. This is Category 1 "Technical" data, captured via our [request-stats](https://dictionary.telemetry.mozilla.org/apps/ads_backend/pings/request-stats) and [provider-request-stats](https://dictionary.telemetry.mozilla.org/apps/ads_backend/pings/provider-request-stats) pings.

## Server-side Glean

MARS's Glean integration is server-side, and all our pings are sent without any of the `client_info.*` fields that would be populated in a typical client-side Glean integration. This means no client info ever gets sent by default. Instead we pick a few coarse, non-identifying client fields to include for necessary reporting, and place them under [the `ad_client` category](https://dictionary.telemetry.mozilla.org/apps/ads_backend?page=1&search=ad_client.) of the ping's metrics.

## Opt-out

At Mozilla we always give users meaningful choice and control over data collection. To opt-out of Mozilla Ads data collection, a user must opt out of ads entirely by going to Preferences > Home and unchecking "Support Firefox", or unchecking both "Sponsored shortcuts" and "Sponsored stories".

This is because we invoice our third party ad partners and advertisers based on this data. So if we are showing ads, it is necessary to keep anonymized, agreggated data about user interactions with ads, for doing business and for our financial record keeping.

## Preventing Persistent Identifiers

Firefox clients that use MARS are required to send `ContextId`, a UUID, with their ad requests. The `ContextId` is used to enable features like users blocking specific ads they don't want to see again. The `ContextId` is one of the metrics we send in Glean pings and store under the `ad_client.` category.

Clients of the MARS API are required to rotate their `ContextId`s at least every 3 days to prevent it from becoming a persistent identifier within our data warehouse.

## Data Deletion

MARS is currently a stateless service, we do not store any data on the users' behalf. The only data we store is the Category 1 and Category 2 data that we send in our Glean pings. This data is necessary to retain for our business purposes, so we do not provide a way for users to delete it.

However, MARS does have a `/delete_user` endpoint set up, so if in the future we decided to store data on users' behalf, we have a mechanism ready that Firefox clients can use to give users the controls to delete their data.

# Making Changes to Collected Data

> At Mozilla, like at many other organizations, we rely on data to make product decisions. But here, unlike many other organizations, we balance our goal of collecting useful, high-quality data with our goal to give users meaningful choice and control over their own data. The Mozilla data collection program was created to ensure we achieve both goals whenever we make a change to how we collect data in our products.

[*Data Collection at Mozilla*](https://wiki.mozilla.org/Data_Collection)

Making changes to the metrics and pings in this repo requires review by a Data Steward, in addition to the usual Ads Engineering code review.

## Data Steward Review

1. Submit your PR to `mars-telemetry` (but do **not** merge it yet!)
2. Fill out a [data collection review form](https://github.com/mozilla/data-review/blob/main/request.md) ([examples](https://bugzilla.mozilla.org/show_bug.cgi?id=1900898) [here](https://bugzilla.mozilla.org/show_bug.cgi?id=2006440)).
3. Submit the request to Bugzilla.
4. Add a comment to your PR linking your Bugzilla request and a copy of your proposed measurements table (from the data collection review form).
5. Send a friendly message to [#data-stewardship-help](https://mozilla.enterprise.slack.com/archives/C07LMRQ5Q6B) to request a review. Make sure to give some brief context on the change, and include a link to the PR and Bugzilla request.

## Sensitive Data Review

If the data collection changes involve Category 3 or Category 4 data, or if it is initially unclear which Category the data might fall under, then the change will also need a [Sensitive Data Collection Review](https://wiki.mozilla.org/Data_Collection#Step_3:_Sensitive_Data_Collection_Review_Process), as outlined in the Data Collection wiki page.
