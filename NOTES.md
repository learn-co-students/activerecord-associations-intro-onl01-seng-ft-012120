How do we use AR Associations?
Active Record makes it easy to implement the following relationships between models:

-belongs_to
-has_one
-has_many
-has_many :through
-has_one :through
-has_and_belongs_to_many

We don't need to worry about most of these right now. We'll concern ourselves with relationships that should sound familiar:

-belongs to
-has many
-has many through

In order to implement these relationships, we will need to do two things:

Write a migration that creates tables with associations. For example, if a cat belongs to an owner, the cats table should have an owner_id column.
Use Active Record macros in the models.

"
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


**Our Code in Action: Working with Associations**

Go ahead and run the test suite and you'll see that we are passing all of our tests! Amazing! Our associations are all working, just because of our migrations and use of macros.

Let's play around with our code.

In your console, run rake console. Now we are in a Pry console that accesses our models.

Let's make a few new songs:

<!-- [1]pry(main)> hello = Song.new(name: "Hello") -->
=> #<Song:0x007fc75a8de3d8 id: nil, name: "Hello", artist_id: nil, genre_id: nil>

<!-- [2]pry(main)> hotline_bling = Song.new(name: "Hotline Bling") -->
=> #<Song:0x007fc75b9f3a38 id: nil, name: "Hotline Bling", artist_id: nil, genre_id: nil>

Okay, here we have two songs. Let's make some artists to associate them to. In the same PRY sessions as above:

<!-- [3] pry(main)> adele = Artist.new(name: "Adele") -->
=> #<Artist:0x007fc75b8d9490 id: nil, name: "Adele">

<!-- [4] pry(main)> drake = Artist.new(name: "Drake") -->
=> #<Artist:0x007fc75b163c60 id: nil, name: "Drake">

So, we know that an individual song has an artist_id attribute. We could associate hello to adele by setting hello.artist_id= equal to the id of the adele object. 
BUT! Active Record makes it so easy for us. The macros we implemented in our classes allow us to associate a song object directly to an artist object:

<!-- [5] pry(main)> hello.artist = adele -->
=> #<Artist:0x007fc75b8d9490 id: nil, name: "Adele">

Now, we can ask hello who its artist is:

<!-- [6] pry(main)> hello.artist -->
=> #<Artist:0x007fc75b8d9490 id: nil, name: "Adele">

We can even chain methods to ask hello for the name of its artist:

<!-- [7] pry(main)> hello.artist.name -->
=> "Adele"

Wow! This is great, but we're not quite where we want to be. Right now, we've been able to assign an artist to a song, but is the reverse true?

<!-- [7] pry(main)> adele.songs -->
=> []

In this case, we still need to tell the adele Artist instance which songs it has. We can do this by pushing the song instance into adele.songs:

<!-- [7] pry(main)> adele.songs.push(hello) -->
=> [#<Song:0x007fc75a8de3d8 id: nil, name: "Hello", artist_id: nil, genre_id: nil>]

Okay, now both sides of the relationships are updated, but so far all the work we've done has been with temporary instances of Artist and Song. 
To persist these relationships, we can use Active Record's save functionality:

<!-- [8] pry(main)> adele.save -->
=> true

<!-- [9] pry(main)> adele -->
=> #<Artist:0x007fc75b8d9490 id: 1, name: "Adele">
Notice that adele now has an id. What about hello?

<!-- [10] pry(main)> hello -->
=> #<Song:0x007fc75a8de3d8 id: 1, name: "Hello", artist_id: nil, genre_id: nil>

Whoa! We didn't mention hello when we saved. However, we established an association by assigning hello as a song adele has. 
In order for adele to save, hello must also be saved. Thus, hello has also been given an id.

Go ahead and do the same for hotline_bling and drake to try it out on your own.