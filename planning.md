# Planning

## Spec

- Facebook clone
- Users, profiles, posts, following, liking
- Authentication using Devise
- Optional - chat, realtime update of newsfeed, realtime notifications
- Integration tests (each page loading properly)
- Unit tests for associations - User.first.posts
- Run with Guard - info [here](https://www.learnenough.com/ruby-on-rails-4th-edition-tutorial/static_pages#sec-guard)

## Data architecture planning (models and associations)

### Facebook

First I'll look at Facebook and get as comprehensive a picture as possible of their user-facing data model. They actually fold this into a bigger "Meta" profile / account so I will not worry about that. I will also only do the top layer of profile information.

- User
  - string:email (unique)
  - string:password (hashed etc)
  - **has_many :profiles**

- Profile
  - **belongs_to :user**
  - Profile Information
    - Names:
      - string:profile_name (display name)
      - string:username (unique)
      - string:first_name
      - string:middle_name
      - string:last_name
      - **has_one :name_pronunciation**
      - **has_many :other_names**
    - About me:
      - **has_many :websites**
      - **has_one :bio**
      - **has_one :favorite_quotes**
      - **has_many :life_events** (a Life Event is a special kind of post I think)
      - ... tonnes of others - films, music, sports ... ...
    - Demographic:
      - datetime:date_of_birth
      - string:gender
      - string:pronouns
      - **has_many :languages**
    - Account Pictures:
      - (**has_one :profile_picture - add later**)
      - (**has_one :cover_photo - add later**)
    - Contacts:
      - **has_many :mobile_numbers**
      - **has_many :email_addresses**
    - Location:
      - **has_one :location_original - 'Home town'**
      - **has_one :location_current - 'Current town/city'**
      - **has_many :location_histories**
    - Histories:
      - **has_many :work_histories** (Surely refactor these three into one)
      - **has_many :university_histories**
      - **has_many :high_school_histories**
    - Relationships:
      - **has_one :relationship**
      - **has_many :family_members**
  - **has_many :posts**
  - **has_many :liked_posts (post_id as liked_post_id)**

- Post
  - datetime:date
  - string:body (this will be html or similar)
  - point:location
  - **has_one default_audience** (The way they manage audiences is super complicated... ok)
  - **has_one post_background**
  - **has_one :gif**
  - **has_many :media_items** (photos and videos - all of which are then in your account I assume)
  - **has_many :tagged_users - user_id**
  - **has_one :feeling_or_activity**
  - **has_one :audience**
  - **has_many :likes (user_id as like_id)**
  - **has_many :comments**
  - **has_many :shares (possibly a post_id as share_id?)**

- Comment
  - **belongs_to :user**
  - **belongs_to :post**
  - datetime:date
  - string:body
  - **has_many :replies (comment_id as reply_id)**

- MediaItem
  - string:type (photo or video)
  - blob:data (don't know how they would store this)

- MobileNumber (I think this is has_and_belongs_to_many, because can add many mobiles, and can associate each with multiple profiles.)
  - **belongs_to :profile**
  - string:mobile_number
  - **has_one :mobile_country_code**

- EmailAddress (I think this is has_and_belongs_to_many)
  - **belongs_to :profile**
  - string:email

- Audience
  - **belongs_to :profile**
  - boolean:active (if true, appears on profile for allowed users - if not, doesn't?)
  - string:include (an array of user id's or user lists to include)
  - string:exclude (an array of user id's or user lists to exclude)

- LocationHistory
  - **belongs_to :profile**
  - string:location - Town/City (Autocompletes with list of places)
  - datetime:moved_on (year and month only)
  - **has_one :audience**

- WorkHistory
  - **belongs_to :profile**
  - string:company (autocompletes with list of options - users I think)
    - **has_one :work_connection (user)**
  - string:position (autocompletes with list of options)
  - string:location - city/town (autocompletes with location)
  - string:description (free text)
  - boolean:current (Boolean)
  - datetime:start_year (year only - first available year is my birth year, last available year is next year)
  - datetime:finish_year (year only - first available year is my birth year, last available year is next year)
  - **has_one :audience**

- UniversityHistory
  - **belongs_to :profile**
  - string:university - 'school' (autocompletes with list of options - users I think)
    - **has_one :university_connection (user)**
  - datetime:start_year (year only - first available year is my birth year, last available year is next year)
  - datetime:finish_year (year only - first available year is my birth year, last available year is next year)
  - boolean:graduated
  - string:description
  - string:concentration_1 (autocompletes list of options, from those written by other users I think)
  - string:concentration_2
  - string:concentration_3
  - string:attended_for (2 options, University or University(postgraduate) not null)
  - **has_one :audience**

- HighSchoolHistory
  - **belongs_to :profile**
  - string:high_school - 'school' (autocompletes with list of options - users I think)
    - **has_one :high_school_connection (user)**
  - datetime:start_year (year only - first available year is my birth year, last available year is next year)
  - datetime:finish_year (year only - first available year is my birth year, last available year is next year)
  - boolean:graduated
  - string:description
  - **has_one :audience**

- Website
  - **belongs_to :profile**
  - string:website_url
  - **has_one :audience**

- Language
  - **belongs_to :profile**
  - string:language
  - **has_one :audience**

- Relationship
  - **belongs_to :profile**
  - string:status
  - datetime:start (year and month only shown)
  - **has_one :user_id as partner**
  - **has_one :audience**

- FamilyMember
  - string:relationship (restricted list of options)
  - **has_one :user_id as family_member**
  - **has_one :audience**

- Bio
  - **belongs_to :profile**
  - string:bio
  - **has_one :audience**

- NamePronunciation
  - **belongs_to :profile**
  - string:first_name
  - string:surname

- OtherName
  - **belongs_to :profile**
  - string:type (restricted list)
  - string:name
  - boolean:show_at_top_of_profile

- FavoriteQuote
  - **belongs_to :profile**
  - string:body
  - **has_one :audience**

- LifeEvent
  - **belongs_to :profile**
  - string:category
  - string:title
  - string:icon (not sure of format? url?)
  - datetime:date
  - **has_many :media_items**

### Odinbook

Reduce the model drastically to meet the spec. Documented in planning.dbml.

## Steps

### Core Steps from Odin

- DONE Use PostgreSQL for your database from the beginning (not SQLite3), that way your deployment will go much more smoothly.
- DONE Write your own seeds in the db/seeds.rb file, which gets run if you type $ rake db:seed.
- DONE Users must sign in to see anything except the sign in page.
- DONE User sign-in should use the Devise gem. Devise gives you all sorts of helpful methods so you no longer have to write your own user passwords, sessions, and #current_user methods. See the Railscast (which uses Rails 3) for a step-by-step introduction. The docs will be fully current.
- Users can send follow requests to other users.
- Users can create posts (begin with text only).
- Users can like posts.
- Users can comment on posts.
- Posts should always display the post content, author, comments, and likes.
- There should be an index page for posts, which shows all the recent posts from the current user and users they are following.
- Users can create a profile with a profile picture. You may be able to get the profile picture when users sign in using OmniAuth. If this isn't the case you can use Gravatar to generate the photo.
- A user's profile page should contain their profile information, profile photo, and posts.
- There should be an index page for users, which shows all users and buttons for sending follow requests to users the user is not already following or have a pending request.
- Set up a mailer to send a welcome email when a new user signs up. Use the letter_opener gem (see docs here) to test it in development mode.
- Deploy your App to a hosting provider.
- Set up an email provider and start sending real emails.

### My steps

- DONE Set up initial Rails project
- DONE Add Devise
- DONE Build Database Model
- DONE Seeds for Database
- post#index page (home page) - no styling or layout
  - Form to add a new post (Replace with a button and Turbo Frames later)
  - DONE Show all posts from current user, and followed users
    - DONE Author, Content, When, Like count, who has liked, comments, likes for comments
    - Button to add a comment to a post (takes to new page initially)
    - Button to like the post
    - Buttons to like each comment
  - List of followed users, click on them to view their profile#show
  - Pending follow requests, button to accept or reject
  - Replace with Turbo Streams functionality
- profile#new / #edit - linked from Home page
  - Create and edit profile including profile picture
- profile#show
  - Profile information
  - Profile photo
    - Add to model - Gravatar
  - Posts by that user (and comments and etc)
  - Button to request follow, if not already following and not that user.
- profile#index
  - List of all users, with buttons to send them follow requests
- Set up mailer for new users - welcome email
- Test mail using letter_opener Gem
- Set up email provider for deployment
- Deploy to fly.io

#### Extra credit

- Make posts also allow images (either just via a URL or, more complicated, by uploading one).
  - For an alternative to using AWS S3 for image storage take a look at this [cloudinary](https://github.com/GoGoCarl/paperclip-cloudinary)
- Use Active Storage to allow users to upload a photo to their profile.
- Make your post able to be either a text OR a photo by using a polymorphic association (so users can still like or comment on it while being none-the-wiser).
- Style it up nicely! We'll dive into HTML/CSS in the next course.

#### My own stretch goal

- Add ability to upload audio as a post or a comment (and again polymorphic?)

## Diagrams

### Post structure

```txt
For timing: it seems to go 30 m, 6 h, 1 d, 1 w, then the date and time e.g. 7 May at 16:21, then date and year e.g. 20 December 2023

--------------------------------------------------
 _____
|     | Author name
| PIC | 1 day · 📢/🔏
|_____|

Body body body ...
body body ...

👍9                                    10 comments
--------------------------------------------------
      |LIKE|                        |COMMENT|
--------------------------------------------------
____
|PIC| Commenter Name
|___| Body body body ...          |
      1 h  Like  Reply          👍
      ____  
      |PIC| Replier Name
      |___| Body body body ...                |
            30 m  Like  Reply               👍2
____
|PIC| Commenter Name
|___| Body body body ...          |
      10 m  Like  Reply          👍

  ...
  
  ...

____
|PIC| Comment as Your Name                  📷⏯
|___| 📷⏯                                   ▶
```

### New post form structure

```txt
______
|     | Author name
| PIC | Audience: Public / Private (drop-down)
|_____|

  What's on your mind, Firstname?

  Add to your post      📷⏯
  
             Post
```
