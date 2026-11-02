# RC3.2 routing label capture correction

Selected routing feedback uses numeric indices. The corrected capture path maps the confirmed index through the current options list to an exact label, then stores that label in the existing Blob parameter. On restore the opposite map resolves a saved label to its current index. No volatile routing index is persisted.

Numeric-address coll entries use numeric-leading lists; named-address entries use store. Lists can arrive before or after feedback, so the selected index is re-resolved once a map rebuild finishes. Startup capture stays closed to protect restored values. Silent set updates menus without routing-command recursion. Unknown labels require manual selection.

Synthetic regression fixtures exercise reordered choices, delayed feedback, unknown indices and typed symbol selector preservation. Original owner saved payloads, source names and extracted routing/input metadata are excluded from publication. Native functional outcomes are summarized in HOST_VALIDATION.json.

Primary references: https://docs.cycling74.com/reference/coll/ , https://docs.cycling74.com/reference/umenu/ , https://docs.cycling74.com/reference/zl.rev/ .
