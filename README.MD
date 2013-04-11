## Demo App for CloudFaker

A small app to show how to use CloudFaker to test your app.

It's a simple app that shows a collection of books, and then when you tap a book it will show you the author information for that book. 

To run, get CloudFaker.

Then run CloudFaker using the api_specs included:
`ruby cloudfaker.rb /path/to/api_specs/DemoAppAPI.yaml -g /path/to/api_specs/DemoAppGenerator.rb`

Compile and run the app in Xcode, then click "Refresh" to load items from the server.

Enjoy!