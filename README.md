# UrlLockBox

HotReads is a site an index for a user's favorite websites. Users can sign in and create new links that will either mark as read or unread. Links that are marked as read will be sent over to a third party application, HotReads, which will then aggregate the most popular links.

## Functionality
### Sign In
Users can visit the index page and either create an account or log in with an existing account. Users must provide an email address to create an account.

### Index
The index page will have a form to create a new link as well as the user's current list of links. Links that are read will have a strikethrough the text. Links can be marked as read or unread. URL's must be valid.

The page can also be filtered by text or by read status. The filter is case insensitive and will search for any of the fields. Users can click the Filter by Read or Filter by Unread buttons to filter the page accordingly.

### API
UrLockBox has two internal API endpoints, one for updating links and one for creating new links.

Top Link:
```shell
/api/v1/links
```

Top Ten Links:
```shell
/api/v1/links/:link_id
```

Endpoints will return as JSON and will display the link for the endpoints.

## Testing
Message queues were mocked through BunnyMock. Testing is done in RSpec and Capybara, and Poltergeist for the JavaScript client side tests. 

## Technology
The application is currently using the following technlogies:

* Server: Ruby On Rails 5.0.1
* Client-side: ERB, JavaScript
* Database: PostgreSQL
* Libraries: JQuery, BunnyMQ

