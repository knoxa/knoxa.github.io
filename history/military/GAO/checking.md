# Service histories

I'll call a set of GAO records (rows from the GAO row data file) that refer to the same officer a _service history_.
Entity linking produces _putative_ service histories. The entity linking is not guaranteed to be correct, and its results need validating.

## GAO Data

Each record has a `fileyear` field.
I expect officers to appear in successive lists, so these numbers should (when the service records are sorted) increase by one each time.
There are some valid reasons why this might not be the case, but most will be due to mistakes in the entity linking.

There are two sorts of check I can perform:

1. Look for 'holes' where years are missing, suggesting there are GAO records that still need to be linked to this set.

1. Look for duplicate years, suggesting records have been linked to the set when they shouldn't.

## Ambiguity

As things stand, I'm copying ambiguous records into more than one putative service history.
Only one of these assignments is correct.
Both repeats and holes may appear when a record is incorrectly assigned, so ambiguity is one possible explanation.

## Holes

It's possible an officer moved out of the regiment at one time, then returned later, legitimately creating a hole in the regiment specific service record.

It's possible that a hole is due to an omission in the Army List.
For example, **John Butcher** appears as a Captain in the 1804 list, and Paymaster in the 1806 list.
He doesn't appear as a printed entry in the 1805 list.
The 1805 list does have a handwritten annotation that mentions him though.
It says "John Butcher (late Capt.) 6 Feb. 1805", and is written beside the _Paymaster_ entry.
These details match the 1806 list.

It might be that a record either side of the hole is ambiguous.
In most cases, I know when a record is ambiguous because I've made it so by copying it into more than one service record.
Another possiblity is that I have a record with a surname only, that is unambigous within the 1790-1820 timeframe, but would be assigned to a different officer if records outside the transcribed range were considered.

## Repeats

An officer may appear in more than one section of an army list, so may generate more than one record with the same `fileyear`.
The row data has a `sheet` field and the value changes according to where in the Army List the record appears.
It seems that each record is copied into a "99. All" sheet, with an `orig_sheet` set to the `sheet` value of the copied record.
In looking for duplicate years, I filter out just the "99. All" sheets for comparison.

There are often cases where the army list has a printed entry that is crossed out, and a handwritten entry added concerning the same officer.
This generates two records in the GAO database, one with the `deleted` field set, and one with the `handwritten` field set.

Where a handwritten entry includes rank and date, it's not clear if the date refers to the 'rank in Regiment' or 'rank in Army'.
It's possible to get conflicting values this way.

It's possible that an officer is promoted, or assigned a role such as Adjutant or Paymaster, and ends up in more than one section.
There a "35. Alterations While Printing" value of the `sheet` field that may occur in such cases. (Further work needed here ...)

Ambiguous records will cause repeats when two officers with the same surname serve together.
It may be possible to distinguish between them through consideration of ranks and dates.

## Checking

I convert GAO data to XML and apply XSLT to check for the sort of issues oulined above.
I posit each check as being performed by a different agent that is giving its own particular view of the results.
Agents make claims, that I append to the service histories.

I can then review the collected set of claims and make judgements.
Lots of claims about the same service history suggest a mistake in the entity linking.
A few claims might be due to errors in entity linking, or may be due to transcription errors.
I may need to go back to the source data to decide.

It may be that the claim is in error.
For example the agent that claims 'a dubious change in rank' isn't aware, for example, that posts such as Adjutant are in addition to a rank.
I can make this agent more sophisticated, or I can provide another agent that checks the claim of the first and accepts or rejects them.
The critical anaysis of the servce histories is than a dialogue.
Having the claims attached to each service record as text allows human agents to take part in this dialogue.

See the **all** target in the project [build file](https://github.com/knoxa/linked-text/blob/master/projects/gao/build.xml).

I can find holes and repeats and then check them against the GAO database.