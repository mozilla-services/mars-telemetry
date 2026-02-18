# mars-telemetry

Contains the metrics.yaml file documenting the metrics collected by the Unified API. 

Used by https://github.com/mozilla-services/mars 

## Making Changes to Collected Data

> At Mozilla, like at many other organizations, we rely on data to make product decisions. But here, unlike many other organizations, we balance our goal of collecting useful, high-quality data with our goal to give users meaningful choice and control over their own data. The Mozilla data collection program was created to ensure we achieve both goals whenever we make a change to how we collect data in our products.

[*Data Collection at Mozilla*](https://wiki.mozilla.org/Data_Collection)

Making a change to our data collection practices requires additional review by one of our Data Stewards.

1. Submit your PR to `mars-telemetry` (but do **not** merge it yet!)
2. Fill out a [data collection review form](https://github.com/mozilla/data-review/blob/main/request.md) ([examples](https://bugzilla.mozilla.org/show_bug.cgi?id=1900898) [here](https://bugzilla.mozilla.org/show_bug.cgi?id=2006440)).
3. Submit the request to Bugzilla.
4. Add a comment to your PR linking your Bugzilla request and a copy of your proposed measurements table (from the data collection review form).
5. Send a friendly message to [#data-stewardship-help](https://mozilla.enterprise.slack.com/archives/C07LMRQ5Q6B) to request a review. Make sure to give some brief context on the change, and include a link to the PR and Bugzilla request.

Please note that any data collection modifications involving category 3 or 4 data will also need to follow the [Sensitive Data Collection Review Process](https://wiki.mozilla.org/Data_Collection#Step_3:_Sensitive_Data_Collection_Review_Process) outlined in the Data Collection wiki page.