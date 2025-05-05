# Movements

The 4th Infantry Division produced movement tables covering [the Retreat from Mons](https://knoxa.github.io/war-diary/11-Bde/1914/1914-08-Appendix10.xhtml)<sup> [1,2]</sup> 
and [the Advance to the Aisne](https://knoxa.github.io/war-diary/11-Bde/1914/1914-10-Appendix55.xhtml#movement)<sup> [3]</sup>.

In the 11 Bde war diary, the August movements<sup> [1]</sup> were photographed with a fold in the page that obscures a couple of lines.
Fortunately, exactly the same source document appears in the 4 Div diary<sup> [2]</sup>, clearly photographed in its entirety. This raises the question of what to do
when a corpus includes multiple copies of the same source document. I've chosen to use the 4 Div copy to fill in the missing lines when transcribing the 11 Bde copy.
I've justified this by added the TNA reference for both source documents to the transcript. A transcript with more than one TNA source reference is therefore
assumed to derive from more than one source document.

## Source Information

The movements tables give times and locations. The first<sup> [1,2]</sup> includes a series of timed arrival and departure events in the **Places** column. I can recover these and pair corresponding arrivals and depatures
to get a chronology. The **Notes** column also mentions some places in describing events that happen in transit. These events don't have precise timings, but I can assume that
the movements of a single concrete entity are totally ordered, and insert these events between the appropriate 'departure' and 'arrival' events.

The second movement table isn't quite as simple. The events are just arrivals and (sometimes) departures, and they may include the mention of more than one place.
Occasionally, departures and arrivals are recorded together as happening during the same day. In this case, I've 
added semantic markup to delimit the events in the **Places** column. Each of these events has the same date, so can't be ordered explicity, but I assume they
are presented in time order and add them to the chronology accordingly.

## Extracted information

I want to produce a chronology of 4 Div movements. This is a totally ordered [chronology](https://knoxa.github.io/reasoning/chronology/)  where each event
records the relationship between 4 Div and a place. I can produce this in stages:

1. I restrict the processing of source material to just the transcripts referenced below. If I know which files contain the transcripts (as I do)
I can just feed those into the process. If I don't, I can crawl all transcripts and look for the references. In general, a file may include a number
of transcribed documents. These are in separate HTML articles, so I select just those from an input file that match the references I want. For this example,
the two movement tables are contiguous. Instead of processing them separately, I can collect the relevant transcript data into a single file and process
them together to get a single chronology covering the whole period. I can run a pre-processing script that collects 'work' as XHTML, then treat this document
as my input.

2. I apply an XSL transform to create a structured output from the XHTML. This assumes there is enough structure in the XHTML to do so. The description
of the source above shows that there are some wrinkles to think about, but the only real difficulty is dealing with departure and arrival events being 
described in the same cell. I added a little semantic mark-up in the source XHTML to make this easier. I can then produce an XSLT stylesheet
that does the relevant information extraction. This is bespoke to this use case, and effectively documents the process. The output format feeds into 
tools for manipulating chronology.

3. This example includes a lot of explicit ordering based on timestamps, and a few 'in transit' events that aren't timestamped themselves 
but occur between timestamped events. The output format is a partial order of contiguous departure and arrival events, with a few explicitly
specified links for the in transit events. A utility stylesheet connects together the nodes. Another restricts the
ordering relationship to just covering relationships. The result should be (and is) a total order.

4. At this stage, everything in the chronology is an instant in time. A spell in one place is recorded as an arrival event followed some time later by a
departure event. I can link consecutive events that mention the same place to make an interval covering the time between arrival and departure.

## Notes

There is quite a lot of bespoke XSLT here for one use case. It may be that there are components of this processing that could be used across multiple use 
cases or semantic mark-up techniques that might simplify the XSLT.

There are trade-offs between adding semantic mark-up upstream, and NLP processing downstream.

What should the output be? It's possible to capture the final data structure from above, or transform to some presentation format. It would be possible, for example, to
take the final result and generate a rewritten XHTML movements table. This would capture the same information as the transcribed one, but with structural
wrinkles smoothed out. It would be both human readable, and machine readable to the extent of making the information extraction (at step 2 above) relatively trivial.

There's other information to be derived from these source documents. Notably, the geographic coordinates of the places mentioned. Also, perhaps, the 
relationship between 4 Div and the people and organizations mentioned. I'm taking the view that different structured data results can be got from the same source text
by applying different end-to-end processing, possibly by different parties. Seperate processes are potentially relatable if they start from the same source reference,
so it's important to record the source reference as metadata on the results.

The movement tables each relate to a single broader event: 'Retreat from Mons' and 'Advance to the Aisne'. Processing each separately gives information
about wider events that will be relevant to much other source material covering the same events.

## References

1. TNA: WO 95/1486/2/01, p 59, _Movements of the 4th Division_, 22 Aug 1914 - 5 Sep 1914, (11 Bde Copy)
2. TNA: WO 95/1439/1/2, p 61, _Movements of the 4th Division_, 22 Aug 1914 - 5 Sep 1914, (4 Div Copy)
3. TNA: WO 95/1487/5, p 255, _Movements of the 4th Division_, 6 Sep 1914 - 12 Oct 1914