# Service histories

The [service histories](results.xhtml) are in an XHTML file.
The body of the document is a collection of HTML `article` elements that each capture the service history of single officer. 
Where I can positively identify the officer, I'll add an `@about` attribute to the HTML article with a URI as its value.
In the absence of a clear identity, I can used the `@id` attribute on the HTML artivle as a temporary identifier.
This value is unique within a single HTML file, but is randomly generated each time service histories are generated, so is not a persistent.

## Per officer

The structure of each article is always the same:

- A header that is the name of the officer (HTML `h4`).

- A paragraph of links to army list records in the Georgian Army Officers database. The link text is the `fileyear` for the record.

- An unordered list (HTML `ul`) of ranks, together with associated dates if found, drawn from the records listed above.

- Comments on the service history from critical agents. See below.

## Critique

Each critical agent produces a HTML `div` element with `@class` attribute set to "comment".
Any claims made by the agent appear inside this as HTML `p` elements with `@class` set to "claim".

There is scope for changing this structure in due course.
For example, should I have empty `div` elements if the agent makes no claims?
Should I add an agent identifier to claims that might let other critical agents assess its credibility?
I'll aim to answer these sorts of questions in the light of experience, and keep the format as simple as possible for the time being.
