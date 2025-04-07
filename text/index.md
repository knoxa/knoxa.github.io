# Knowledge from Text

I can extract information from a text corpus and present it to you, but in doing so I'll make assumptions and judgements, which means I'm making claims not stating facts.
I should provide references so you can relate my claims the original source and critically assess them.

I can also help you by sharing the intermediate results and workings on which I base claims, particularly data preparation that makes the source text more
amenable to machine processing. Sharing this, and encouraging common practice, opens up possibilites for collaboration in information extraction and
[text as a knowledge base](https://knoxa.github.io/linked-text/).

## War Diary 

These ideas are easier to get across in the context of a specific example. I'll use the [war-diary](https://knoxa.github.io/war-diary/) corpus, which contains
selected transcripts from the war diaries, held in The National Archive (TNA), of British units that fought in in the First World War.

Notes on my experiments with the War Diary corpus are [here](war-diary).

## Source References

Since all the source material comes from TNA, I use [their citation scheme](https://www.nationalarchives.gov.uk/help-with-your-research/citing-records-national-archives/) 
for any source material I transcribe. For example, the *series* for Western Front diaries is [WO 95](https://discovery.nationalarchives.gov.uk/browse/r/h/C14303). Below this is the record [WO 95/1486](https://discovery.nationalarchives.gov.uk/details/r/C4554637) covering the 1914 diaries for 11<sup>th</sup>Infantry Brigade.
I'll also call this level of record as a series, which makes the next level down a *piece*. The 1914 diary is then in 3 pieces:
[WO 95/1486/1](https://discovery.nationalarchives.gov.uk/details/r/C14016968), [WO 95/1486/2](https://discovery.nationalarchives.gov.uk/details/r/C14016969) and [WO 95/1486/3](https://discovery.nationalarchives.gov.uk/details/r/C14016970).
If I download a piece I get one or more PDF files, each of which is an *item*. If there's only one item, the PDF filename reflects the piece reference. If there's more 
than one item, each gets a one-up number added to the piece reference. I include these item numbers in any source reference I make. The page numbers in my references refer to the
pages of the item PDF file.

## Document Structure

Hereafter, I'll use the term *document* to refer to an original artefact or its transcript, and I'll say *source document* or *transcribed document* if the context doen't make that clear. 

The documents are [XHTML](https://en.wikipedia.org/wiki/XHTML). This is a well formed [XML](https://en.wikipedia.org/wiki/XML), so readily machine processable.
I use the [Dublin Core](https://www.dublincore.org/specifications/dublin-core/dcmi-terms/) *source* term to add the TNA reference to the HTML _head_ element of each transcribed document.

Larger documents may be composed of smaller ones. For example, signals, messages and reports for the same day may be collected together as an appendix.
When transcribing, I put each of these lowest-level (atomic) documents inside a HTML _article_. The idea is that these articles can be extracted separately 
and independently if desired. For that reason, I've adopted the practice of including a TNA reference inside each article.

### Forms

Many of the source documents are forms. These might have a tabular structure, or might have headers and footers for metadata fields. I use HTML _table_ elements
labelled with _class_ attributes to capture this structure.


## Semantic mark-up

I've incorporated [semantic mark-up](https://en.wikipedia.org/wiki/Semantic_HTML) into the the war diary pages I've transcribed to make it easier to extract information. 

I use HTML _span_ elements to delimit word and phrases and assign them a _class_ attribute.
For example, I pick out mentions of places in text as class "place", and colour them green in a CSS stylesheet.
I confer semantics by assuming that text of an HTML element with class "place" is always the mention of a place.
This isn't strictly semantic mark-up in the [semantic web](https://en.wikipedia.org/wiki/Semantic_Web) sense of the term.
I could use the [RDFa](https://www.w3.org/TR/rdfa-lite/) _typeof_ attribute instead to explicitly state that a span of text refers to a place,
but this means referring to an ontology that adds restraints that I don't want to deal with just yet.

With XHTML it's easy to convert from one semantic mark-up approach to the other with XSLT.
In the interests of keeping thigs simple, I'll start by ascribing semantics to a class attribute and switch to something more formal later if neccessary.

I transcribe source documents to XHTML directly. I add semantic mark-up later, as a separate stage, either directly in a text editor or applying some clever software to do it.
If you don't know about XHTML then you can create HTML and use one of the many available 'cleaner' utilities to convert it
to HTML. If you don't know about HTML then you can just transcribe source documents in your favourite word processor, and there will still be a way to get to XHTML ultimately.

I'm not going to be be rigourous about applying mark-up "rules". I'm probably not going to be comprehensive either.
I'll focus my efforts on the documents that interest me. I'll develop and extend mark-up iteratively as I explore the documents.
How I use semantic mark-up will likely change as I explore.

Notes on my use of semantic mark-up are [here](mark-up).
