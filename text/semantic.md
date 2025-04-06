# Structure and Semantics

I want to make the war diary transcripts readable by machines as well as humans.

I want to make it possible for different parties to share knowledge derived from war diaries. I can extract information from war diaries and present it to you, but
I'll make jusdgements and assumptions in doing so that you might not agree with, or that might simply be wrong.
I'm therefore making a claim when presenting information rather stating a fact. You may want to critically assess my claims.
I provide references so you can track my claims back to the original source.

Since all the source material comes from The National Archive, I use [their citation scheme](https://www.nationalarchives.gov.uk/help-with-your-research/citing-records-national-archives/) 
for any source material I transcribe.

## Source References

TNA aren't completely clear in their terminology describing a record, but here's my interpretation for war diaries.

The *series* for Western Front diaries is [WO 95](https://discovery.nationalarchives.gov.uk/browse/r/h/C14303). Below this is the record [WO 95/1486](https://discovery.nationalarchives.gov.uk/details/r/C4554637) covering the 1914 diaries for 11<sup>th</sup>Infantry Brigade.
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

I've incorporated [semantic mark-up](https://en.wikipedia.org/wiki/Semantic_HTML) into the the war diary pages I've transcribed to make it easier to extract information. 

I use HTML _span_ elements to delimit word and phrases and assign them a _class_ attribute.
For example, I pick out mentions of places in text as class "place", and colour them green in a CSS stylesheet.
I confer semantics by assuming that text of an HTML element with class "place" is always the mention of a place.
This isn't strictly semantic mark-up in the [semantic web](https://en.wikipedia.org/wiki/Semantic_Web) sense of the term.
I could (perhaps should) use the RDFa _typeof_ attribute instead to explicitly state that a span of text refers to a place,
but this would mean referring to an ontology that potentially imposes restraints or complexities that I might not want to deal with just yet.

With XHTML it's easy to convert from one semantic mark-up approach to the other with XSLT.
In the interests of keeping thigs simple, I'll start by ascribing semantics to a class attribute and switch to something more formal later if neccessary.

I transcribe source documents to XHTML directly. I add semantic mark-up later, as a separate stage, either directly in a text editor or applying some clever software to do it.
If you don't know about XHTML then you can create HTML and use one of the many available 'cleaner' utilities to convert it
to HTML. If you don't know about HTML then you can just transcribe source documents in your favourite word processor, and there will still be a way to get to XHTML ultimately.

I'm not going to be be rigourous about applying mark-up "rules". I'm probably not going to be comprehensive either.
I'll focus my efforts on the documents that interest me. I'll develop and extend mark-up iteratively as I explore the documents.
How I use semantic mark-up will may change as I explore. See my notes [here](mark-up).

The advantage of semantic mark-up is that it captures analysis of natural language text in the context of the text itself. Further, the original text is recoverable 
by simply stripping out the mark-up. This means you can critically assess the process that created it in deciding whether to use it, or you can simply ignore it. 


linked-text repository?

