*iFrame tab skeleton*

A Sinatra template to quickly configure new iFrame tab applications.

The signed_request is decoded and used by the /pathfinder route to decide if a user is a fan or not and displaying the correct template. The functionality is similar to (deprecated) <fb:visible-to-connection>. Additionally, unlike <fb:visible-to-connection>, only one view is rendered at a time and can't simply be unhidden by modifying the visibility.