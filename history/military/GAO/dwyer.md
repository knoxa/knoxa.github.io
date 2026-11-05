# Dwyer

Entity linking of the GAO data gives 3 officers named **Dwyer**:

- **James Dwyer** appears in [65-52-10-006018](https://www.georgianarmyofficers.org/record/65-52-10-006018) (1802).
- **John Dwyer** appears in [65-52-10-006022](https://www.georgianarmyofficers.org/record/65-52-10-006022) (1802) and [65-55-10-005968](https://www.georgianarmyofficers.org/record/65-55-10-005968) (1805).
- **M. B. Dwyer** appears in [65-55-35-000380](https://www.georgianarmyofficers.org/record/65-55-35-000380) (1805).

and there are lots of records for "\_\_\_\_ Dwyer".

As things stand, the records for just "Dwyer" are ambiguous and appear in all 3 sets of records.
I want to try and identify which Dwyer each belongs to, and apportion them accordingly.

I can look at the `reg_rank` and `reg_date` fields.
If both are set, then this is the date the officer attained the rank.
I compare ranks and dates in the ambiguous records with ranks and dates in the unambigous (fully named) records.
There are 3 ranks amongst all the Dwyer records: Ensign, Lieutenant and Captain.
The Ensign date is always 1797-07-06 and the Lieutenant date is always 2 August 1797.
There is no date on the Captaincy.

The Captain is **M. B. Dwyer**. This name and rank only appears on the [65-55-35-000380](https://www.georgianarmyofficers.org/record/65-55-35-000380) record.
This is straightforward enough.
The problem is that the Lieutenant is both **James Dwyer** (65-52-10-006018) and **John Dwyer** (65-55-10-005968).
I can't resolve this with just the GAO data, so I go back to the source and download the 1802 and 1805 Army Lists from TNA.

I notice that in all three cases for "John" or "James", the name in the source is actually "\_\_\_\_ Dwyer".
It seems that the transcriber has treated "\_\_\_\_" as a ditto, and assigned the given name that appears in the entry above.
A further confusion is that "\_\_\_\_ Dwyer" appears as both Ensign and Lieutenant in the 1802 list.
However, the Ensign entry has the handwritten annotation "promoted" next to it.

It's possible that there is actually just **M. B. Dwyer**, and that he was only an Ensign for a month before being promoted to Lieutentant.

Having merged all the Dwyer records into one set, I check for duplicated entries and find that I have a record for Ensign (date) and Lieutenant
over several years, not just 1802.
It seem there is more than one Dwyer after all.
However, I can't corroborate this definitely by searching the Gazette, or by widening the search in GAO to include "Dwyer" in any regiment.
It seem that the Lieutentant is **M B Dwyer**, and there is no other trace of the Ensign "promoted" in 1802.
GAO has **M B Dwyer** as an Ensign in the 81st Foot, with a different date from the Ensign in the 67th, so was presumably transferred from there to the 67th Foot.

Looking at the 1799 Army List, there is an **Ensign M B Dwyer** with date 1 August 1796 listed in the 81st Foot. It has the annotation "67" next to it.
There is also an **Ensign \_\_\_\_ Dwyer** listed in the 67th Foot, with the annotation "81" next to it.
There's also an annotation that same something like "Col. Br. letter 21 Dec 99".
It seem that **M B Dwyer** moved from the 81st to 67th in 1799.
Unfortunately, the dates don't match. The Ensign in the 67th has date 6 July 1797.

A [1799 list of the British Army in Jamaica](https://www.jamaicanfamilysearch.com/Members/a/a1799_06.htm) has **Lieutentant M B Dyer** with a date of 2 August 1797, and no Ensign Dwyer.