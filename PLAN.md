# 0.8 RC1.3 Studio — owner acceptance, 2026-11-03

Completed: compact/basic/advanced native monitor, readable system-font text, visual zoom fields with × units, saved theme, synchronized embedded device body, existing DSP/routing/automatic-stop protocol retained.

Development validation: 155 automated checks passed. Gen source and the historical audio/API graph remain pinned; AMXD container is deterministic. Eight approximate illustrations have no estimated text overflow. These checks do not execute native Max.

Owner acceptance: the RC1.3 light device body and monitor match; the saved light body restores before opening the monitor; controls/fractional zoom/compensation/instrumental selection survive full application restart; playback/recording show both waves; automatic stop retains the clip with Live confirmation. Final test saved Auto Stop ON and reopened OFF with themes and other controls retained. Current bounded results are in docs/HOST_VALIDATION.json. RC1.2 speech/silence and layout observations remain separately archived.

Publication: update main with RC1.3 source, documentation and the byte-identical tested AMXD. Preserve the 0.7 RC3.3 tag, checkpoint, release and old AMXD as rollback points. No private Live Sets, raw diagnostics, saved input/routing payloads, owner screenshots or recordings are included.

Future work is driven by new reports or requested features. No repeated owner test cycle is required for this documentation-only publication. Other hosts/OSes, native dark-body restart, exhaustive parameter combinations and sample-accurate stop timing are outside the completed acceptance scope.
