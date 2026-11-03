# GAO Data

The row data has a `sheet` field.
The value changes according to where in the Army List the record appears.
It seem that each record is copied into a "99. All" sheet, with an `orig_sheet` set to the `sheet` value of the copied record.
I filter out just the "99. All" sheets, and use these to form putative service records.

Each record has a `fileyear` field.
I expect officers to appear in successive lists, so these numbers should (when the service records are sorted) increase by one each time.
There are some valid reasons why this might not be the case, but most will be due to mistakes in the entity linking.

There are two sorts of check I can perform:

1. Look for 'holes' where years are missing, suggesting there are records that still need to be linked to this set.

1. Look for duplicate years, suggesting records have been linked to the set when they shouldn't.

## Holes

It possible an officer moved out of the regiment at one time, then returned later, legitimately creating a hole in the regiment specific service record.
