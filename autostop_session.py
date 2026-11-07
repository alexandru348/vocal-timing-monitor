"""Session Auto Stop intent with a separate, transient per-attempt latch.

No onset or calibration DSP changes. The user toggle is never cleared by a
runtime Stop/clock/API/config event. Native guards drive the engine's effective
autostop parameter instead. A low DSP stop snapshot is required after every
invalidation before a fresh detector request can be accepted. A consumed attempt
stays spent until observed transport Stop or explicit user OFF, preventing a
failed host Stop from producing repeated commands. Deferred requests carry a
generation, so OFF/ON, Stop/Start and loss/recovery cannot revive old requests.
"""


def apply_session_autostop(p):
    def disconnect(src, dst, outlet=None, inlet=None):
        p.p['lines'] = [w for w in p.p['lines'] if not (
            w['patchline']['source'][0] == src
            and w['patchline']['destination'][0] == dst
            and (outlet is None or w['patchline']['source'][1] == outlet)
            and (inlet is None or w['patchline']['destination'][1] == inlet))]

    # Keep the startup/init OFF path inside the popup. Remove only runtime
    # writers of the visible toggle; no saved parameter identities change.
    p.p['lines'] = [w for w in p.p['lines'] if
                    w['patchline']['source'][0] != 'disarm-ui'
                    and w['patchline']['destination'][0] != 'disarm-ui']
    p.p['boxes'] = [w for w in p.p['boxes'] if w['box']['id'] != 'disarm-ui']
    disconnect('control-route', 'autostop-tag', 2)
    disconnect('stop-select', 'stop-defer')
    disconnect('stop-defer', 'stop-finalize')
    disconnect('control-route', 'disarm-reason-gate', 2)

    # The six original guards still use user intent, NOT the effective DSP
    # parameter: consuming a request must not cancel its own deferred commit.
    # fields: original safety, known playing, spent attempt, observed DSP low.
    p.obj('as-state', 'pak 0 -1 0 0', 4, 1)
    p.obj('as-unpack', 'unpack 0 0 0 0', 1, 4)
    p.obj('as-ready', 'expr ($i1 > 0) && ($i2 > 0) && ($i3 == 0) && ($i4 > 0)', 4, 1)
    p.wire('as-state', 'as-unpack')
    for i in range(4):
        p.wire('as-unpack', 'as-ready', i, i)
    p.wire('safety', 'as-state')
    p.obj('as-effective-change', 'change -1', 3, 3)
    p.wire('as-ready', 'as-effective-change')
    p.wire('as-effective-change', 'autostop-tag')
    p.obj('as-request-gate', 'gate 1 0', 2, 1)
    p.wire('as-ready', 'as-request-gate')
    # Preserve specific refusal diagnostics without dispatching an unsafe Stop.
    p.obj('as-note-gate', 'gate 1 0', 2, 1)
    p.wire('stop-select', 'as-note-gate', 0, 1)
    p.wire('as-note-gate', 'stop-reason-store')
    p.wire('stop-select', 'as-request-gate', 0, 1)

    p.msg('as-spent', '1')
    p.msg('as-unspent', '0')
    p.wire('as-spent', 'as-state', 0, 2)
    p.wire('as-unspent', 'as-state', 0, 2)
    p.msg('as-low-clear', '0')
    p.msg('as-low-seen', '1')
    p.wire('as-low-clear', 'as-state', 0, 3)
    p.wire('as-low-seen', 'as-state', 0, 3)
    p.obj('as-low-select', 'sel 0', 1, 2)
    p.wire('snapshot-2', 'as-low-select')
    p.wire('as-low-select', 'as-low-seen')

    p.obj('as-invalidate', 't b b', 1, 2)
    p.wire('as-invalidate', 'as-low-clear', 1)
    p.obj('as-generation', 'counter 1 1000000000', 5, 4)
    p.obj('as-generation-store', 'i 0', 2, 1)
    p.wire('as-invalidate', 'as-generation')
    p.wire('as-generation', 'as-generation-store', 0, 1)
    p.obj('as-commit', 'expr ($i1 == $i2) && ($i3 > 0) && ($i4 > 0)', 4, 1)
    p.wire('as-generation', 'as-commit', 0, 1)
    p.wire('safety', 'as-commit', 0, 2)
    p.obj('as-commit-select', 'sel 1', 1, 2)
    p.wire('stop-defer', 'as-commit')
    p.wire('as-commit', 'as-commit-select')
    p.wire('as-commit-select', 'stop-finalize')
    p.obj('as-request', 't b b', 1, 2)
    p.wire('as-request-gate', 'as-request')
    # Close the per-attempt gate synchronously before queuing the token.
    p.wire('as-request', 'as-spent', 1)
    p.wire('as-request', 'as-generation-store')
    p.wire('as-generation-store', 'stop-defer')

    # Distinguish actual Song Stop from a momentary audio clock/safety loss.
    # Only observed stopped transport (or explicit OFF) replenishes an attempt.
    p.obj('as-play-observer', 'live.observer is_playing', 2, 2)
    p.wire('bind-id', 'as-play-observer', 0, 1)
    p.obj('as-api-select', 'sel 0 1', 1, 3)
    p.wire('api-valid', 'as-api-select')
    p.msg('as-play-unknown', '-1')
    p.msg('as-play-query', 'property is_playing')
    p.wire('as-api-select', 'as-play-unknown')
    p.wire('as-api-select', 'as-play-query', 1)
    p.wire('as-play-query', 'as-play-observer')
    p.obj('as-play-change', 'change -2', 3, 3)
    p.wire('as-play-observer', 'as-play-change')
    p.wire('as-play-unknown', 'as-play-change')
    p.obj('as-play-update', 't i b', 1, 2)
    p.wire('as-play-change', 'as-play-update')
    p.wire('as-play-update', 'as-invalidate', 1)
    p.wire('as-play-update', 'as-state', 0, 1)
    p.wire('as-play-update', 'as-commit', 0, 3)
    p.obj('as-play-select', 'sel 0 1', 1, 3)
    p.wire('as-play-update', 'as-play-select')
    p.wire('as-play-select', 'as-unspent')
    # A delayed confirmation belongs to the previous attempt; cancel at Start.
    p.wire('as-play-select', 'stop-check-cancel', 1)

    p.obj('as-safety-change', 'change -1', 3, 3)
    p.obj('as-unsafe', 'sel 0', 1, 2)
    p.wire('safety', 'as-safety-change')
    p.wire('as-safety-change', 'as-unsafe')
    p.wire('as-unsafe', 'as-invalidate')
    # Invalidate pending events on actual edits, not repeated UI readbacks.
    for i in range(7):
        id = 'as-control-' + str(i)
        p.obj(id, 'change -999999.', 3, 3)
        p.wire('control-route', id, i)
        p.wire(id, 'as-invalidate')
    p.obj('as-user-off', 'sel 0', 1, 2)
    p.wire('as-control-2', 'as-user-off')
    p.wire('as-user-off', 'as-unspent')
    p.msg('as-user-off-note', '7')
    p.wire('as-user-off', 'as-user-off-note')
    p.wire('as-user-off-note', 'stopnote-ui-tag')
    # A requested Stop keeps its result despite the resulting clock loss.
    p.obj('as-reason-unpack', 'unpack 0 0 0 0', 1, 4)
    p.obj('as-reason-allowed', 'expr ($i1 > 0) && ($i2 == 0)', 2, 1)
    p.wire('as-state', 'as-reason-unpack')
    p.wire('as-reason-unpack', 'as-reason-allowed', 2, 1)
    p.wire('control-route', 'as-reason-allowed', 2)
    # Re-evaluate after spent changes, including when the user leaves ON.
    p.obj('as-intent-store', 'i 0', 2, 1)
    p.wire('control-route', 'as-intent-store', 2, 1)
    p.obj('as-reason-bang', 't b')
    p.wire('as-reason-unpack', 'as-reason-bang')
    p.wire('as-reason-bang', 'as-intent-store')
    p.wire('as-intent-store', 'as-reason-allowed')
    p.wire('as-reason-allowed', 'disarm-reason-gate')
    p.wire('as-reason-allowed', 'as-note-gate')

    # Local initialization is independent of popup visibility and never saved.
    p.wire('ready-trigger', 'as-play-unknown', 2)
    p.wire('ready-trigger', 'as-unspent', 2)
    p.wire('ready-trigger', 'as-invalidate', 2)
    popup = next(w['box']['patcher'] for w in p.p['boxes'] if w['box']['id'] == 'popup')
    toggle = next(w['box'] for w in popup['boxes'] if w['box']['id'] == 'autostop')
    toggle['hint'] = ('Rămâne ON între take-uri. Oprește la prima abatere peste toleranță. '
                      'La redeschiderea proiectului pornește OFF.')
