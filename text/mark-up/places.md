# Places

Equating text spans in documents with the concept of [place](https://www.oxfordbibliographies.com/display/document/obo-9780199874002/obo-9780199874002-0159.xml).
 
## Semantic mark-up
 
I enclose mentions of places in HTML _span_ elements with _class_ set to "place". I'm happy to nest one place inside another.
For example: 

	300 yards North of road junction ¼ mile North of E of LA HUTTE	

contains,

    road junction ¼ mile North of E of LA HUTTE	

which in turn contains,

	LA HUTTE

The idea is that the outermost span for a place represents text that could replaced by a reference to the concept of place, with the remaining
(and now simpler) text still making sense. So, for example:

	Col Le Marchant marched to PONT L'ÉVÈQUE via main road through GUISCARD, and bivouaced there.

becomes

	Col Le Marchant marched to [PLACE] via [PLACE], and bivouaced [PLACE].
	
In this example, the word "there" is an anapahor for "PONT L'ÉVÈQUE". I can make its meaning explicit in the HTML by setting a _content_ attribute:

	... <span class="place" content="PONT L'ÉVÈQUE">there</span> ...

## Structure 

A Place span may have other Places nested inside it, implying a relationships between places. An outer span may include words or phrases,
such as "road junction", alongside the nested span. These describe attributes of places or the relationships between them.
