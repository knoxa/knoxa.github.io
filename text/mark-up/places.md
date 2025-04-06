# Places

See [tigersmuseum](https://tigersmuseum.github.io/history/docs/places.html)
 
## Semantic mark-up
 
I enclose mentions of places in HTML _span_ elements with _class_ set to "place". I'm happy to nest one place inside another.
For example: 

	300 yards N of road junction ¼ mile N of E of LA HUTTE	

contains

    road junction ¼ mile N of E of LA HUTTE	

which in turn contains 

	LA HUTTE

The idea is that the outermost span for a place represents text that could be substitued for a reference to the concept of place, with the remaining
(and now simpler) text still making sense. So, for example:

	Col Le Marchant marched to PONT L'ÉVÈQUE via main road through GUISCARD, and bivouaced there.

becomes

	Col Le Marchant marched to [PLACE] via [PLACE], and bivouaced [PLACE].
	
In this example, the word "there" is an anapahor for "PONT L'ÉVÈQUE". I can make its meaning explicit in the HTML by setting a _content_ attribute:

	... <span class="place" content="PONT L'ÉVÈQUE">there</span> ...

A Place may have other Places nested inside it. These capture parent-child and sibling relationships between places. A container span will include words or phrases,
such as "main road", alongside nested span. These give context, or attributes of one or other of the places, or describe a relationship between them.

A CSS stylesheet colours these green. 

The advantage of semantic mark-up is that it captures analysis of natural language text in the context of the text itself. Further, the original text is recoverable 
by simply stripping out the mark-up. This means you can critically assess the process that created it in deciding whether to use it, or you can simply ignore it. 
