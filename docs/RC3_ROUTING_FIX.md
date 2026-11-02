# Routing parameter registration correction

The first persistence implementation registered unbound routing pattr objects incorrectly, producing default numeric parameters instead of Blob parameters. The correction registers parameter_enable and parameter_mappable in saved_object_attributes, sets Blob type and Stored Only visibility, and removes conflicting initial-value overrides.

This note describes implementation behavior only. Owner Live Set files and extracted diagnostic payloads are not distributed. Synthetic fixture tests cover numeric-fallback detection, Blob shape and label validation. See PERSISTENCE.md for current behavior and HOST_VALIDATION.json for public functional outcomes.
