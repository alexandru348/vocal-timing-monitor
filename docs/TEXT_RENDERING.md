# Native text rendering — RC1.2

The owner reported pixelated-looking text in the native Windows monitor. Screenshots alone do not establish the active Windows scale, Max version or High DPI setting. Fractional display scaling or disabled HiDPI is a possible cause, not a confirmed diagnosis.

RC1.3 uses Segoe UI explicitly on every displayed text/control in the monitor and device panel. Point sizes are integral, small captions are enlarged, and text rectangles have extra vertical room. Text remains native; no rasterized labels, custom runtime painter, external font or image is added. Other OSes may substitute a font. Offline images use DejaVu Sans and cannot prove actual Segoe UI rendering or pixel sharpness.

## Native check

In Live 12, right-click the VTM device header and choose Edit in Max. In the Max application, open Options → Preferences (Ctrl+,), then Patching → High DPI Rendering. Record whether it is enabled. Cycling '74 documents this Windows option as enabling higher-resolution rendering for fonts/graphics. It is an application preference, not a per-device font quality setting. If disabled, enabling it can be tested after saving the Live Set and fully restarting Live/Max. Confirm the monitor's apparent size and text in both themes after reopening. Keep the currently working display scale while inspecting this first.

Do not treat Live's VST Auto-Scale Plug-in Window guidance as a verified Max-for-Live fix. No reset of preferences or audio configuration is part of this workflow. The AMXD does not change any global application/Windows preferences.

## Zoom units

Two native live.numbox fields use appearance 4 (LCD), Stored Only Float parameters with range 1–8, parameter_unitstyle 9 (Custom), and parameter_units `%g×`. Expected examples are 1×, 2×, 2.5×, 8×. Their left outlets remain numerical and feed only the existing drawing multipliers. The right normalized outlets are unwired. Neither text formatting nor zoom changes detection, compensation, routing or stop intent. The owner confirmed unit display/fractional editing and retained values after full application restart. Revised native text was accepted for the tested Windows setup. Global High DPI settings were not inspected or changed; objective pixel sharpness is not established by this acceptance.

Primary documentation:

- https://docs.cycling74.com/reference/live.numbox/
- https://docs.cycling74.com/userguide/preferences_and_settings/
- https://docs.cycling74.com/legacy/max8/vignettes/docnew
- https://help.ableton.com/hc/en-us/articles/209774245-How-to-reset-Max-for-Live (Edit in Max entry point only; no reset is requested)
