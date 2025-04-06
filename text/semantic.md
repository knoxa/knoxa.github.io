# Structure and Semantics

I want to make the war diary transcripts readable by machines as well as humans.

I want to make it possible for different parties to share knowledge derived from the war diaries. The most basic point here is that you and I will both want
to be able to track each others claims back to the original source.
Since all the source material comes from The National Archive, I use [their citation scheme](https://www.nationalarchives.gov.uk/help-with-your-research/citing-records-national-archives/) 
for any source material I transcribe.

War Diaries are too big to be transcribed by a single person. Any approach to creating a corpus need to be robust, and as simple and easy to apply as possible.

TNA aren't completely clear in their terminology describing a record, but here's my interpretation for war diaries.

## Source References

The *series* is [WO 95](https://discovery.nationalarchives.gov.uk/browse/r/h/C14303). Below this, I can find the record [WO 95/1486](https://discovery.nationalarchives.gov.uk/details/r/C4554637) covering the 1914 diaries for 11<sup>th</sup>Infantry Brigade.
I'll also call this level of record as a series. This lets me refer to the next level down as a *piece*. The 1914 diary is then in 3 pieces:
[WO 95/1486/1](https://discovery.nationalarchives.gov.uk/details/r/C14016968), [WO 95/1486/2](https://discovery.nationalarchives.gov.uk/details/r/C14016969) and [WO 95/1486/3](https://discovery.nationalarchives.gov.uk/details/r/C14016970).
If I download a piece I get one or more PDF files, each of which is an *item*. If there's only one item, the PDF filename reflects the piece reference. If there's more 
than one item, each gets a one-up number added to the piece reference. I include these item numbers in any source reference I make. The page numbers in my references refer to the
pages of the item PDF document.


Hereafter, I'll use the term *document* to refer to an original artefact or its transcription. 

## Structure

The documents are [XHTML](https://en.wikipedia.org/wiki/XHTML). This is a well formed [XML](https://en.wikipedia.org/wiki/XML), so readily machine processable.

The [Dublin Core](https://www.dublincore.org/specifications/dublin-core/dcmi-terms/) *source* term is used to add the TNA reference to the HTML _head_ of each transcribed document.

Larger documents may be composed of smaller ones. For example, signals, messages and reports for the same day may be collected together as an appendix.
When transcribing, I put each of these lowest-level (atomic) documents inside a HTML _article_. The idea is that these articles can be extracted separately 
and independently if desired. For that reason, I've adopted the practice of including a TNA reference inside each article.

## Semantic mark-up

I've incorporated semantic mark-up into the the war diary pages I've transcribed to make it easier to extract information. 
If you don't want this mark-up, it's easy to strip out.

If you don't know how to create this mark-up, then you can just have a vanilla XHTML file and add it in later, or get 
some clever software to do it. If you don't know about XHTML then you can create HTML and use one of the many available 'cleaner' utilities to convert it
to HTML. If you don't know about HTML then you can transcribe into your favourite word processor, and there will still be a way to get to XHTML ultimately.

I'm using a mixture of strategies and experimenting as I go. 

---

The transcripts here are crafted to support machine readabilty. This requires some knowledge and experience of semantic mark-up. The idea is that ...

HTML _span_ elements can be used to delimit word and phrases, which can then be styled independently of the rest of the text by assigning them a _class_ attribute.
For example, I pick out mentions of places in text as class "place", and colour them green. I confer semantics by assuming that text of an HTML element with 
class "place" is always the mention of a place. This isn't stricly semantic mark-up. I could (perhaps should) instead use the RDFa _typeof_ attribute to explicitly
state that a span of text refers to a place. This would mean referring to an ontology that defined a place type. To be consistent, all transcribers would need to refer to 
the same ontology, or 

With XHTML it's easy to convert from one approach to the other with XSLT. My feeling is to leave things as simple as possible, ascribing semantics to a class attribute,
and convert to something more formal later if neccessary.

Dates and times are inside a [HTML _time_](https://www.w3schools.com/Tags/tag_time.asp) element with the _datetime_ attribute set if at all possible.

You can use the HTML _content_ attribute on any element to assert an alternative text content. I use this on HTML


-------------


## Many hands

I'm not going to be be rigourous about applying mark-up "rules". I'm probably not going to be comprehensive either.
I'll focus my efforts on the documents that interest me. I'll develop and extend mark-up iteratively as I explore the documents.
How I use semantic mark-up will may change as I explore.

Information extraction from text should therefore be viewed as being enabled by semantic mark-up rather than depending on it. 
If you don't want this mark-up, it's easy to strip out. If you do want this mark-up (or you're prepared to give it a go) then you want to be able
to assess it critically.


https://en.wikipedia.org/wiki/Semantic_HTML

Keep it simple
You're not the only one playing this game
Collaboration is a good thing
pass it rounf first, cut it up later

linked-text repository?
