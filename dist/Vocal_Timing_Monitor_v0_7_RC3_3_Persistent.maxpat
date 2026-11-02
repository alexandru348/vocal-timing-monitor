{
  "patcher": {
    "fileversion": 1,
    "appversion": {
      "major": 8,
      "minor": 6,
      "revision": 0,
      "architecture": "x64",
      "modernui": 1
    },
    "classnamespace": "box",
    "rect": [
      100.0,
      100.0,
      360.0,
      169.0
    ],
    "openinpresentation": 1,
    "default_fontname": "Arial",
    "default_fontsize": 12.0,
    "bgcolor": [
      0.055,
      0.071,
      0.098,
      1.0
    ],
    "editing_bgcolor": [
      0.055,
      0.071,
      0.098,
      1.0
    ],
    "locked_bgcolor": [
      0.055,
      0.071,
      0.098,
      1.0
    ],
    "toolbarvisible": 0,
    "boxes": [
      {
        "box": {
          "id": "title",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            20.0,
            460.0,
            185.0,
            22.0
          ],
          "fontsize": 17.0,
          "textcolor": [
            0.29,
            0.79,
            0.91,
            1.0
          ],
          "fontface": 1,
          "text": "VOCAL TIMING MONITOR",
          "presentation": 1,
          "presentation_rect": [
            16.0,
            11.0,
            330.0,
            26.0
          ]
        }
      },
      {
        "box": {
          "id": "version",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            220.0,
            460.0,
            185.0,
            22.0
          ],
          "fontsize": 11.0,
          "textcolor": [
            0.59,
            0.67,
            0.77,
            1.0
          ],
          "text": "0.7 RC3.3 Persistent | fereastra separata",
          "presentation": 1,
          "presentation_rect": [
            16.0,
            40.0,
            330.0,
            18.0
          ]
        }
      },
      {
        "box": {
          "id": "open",
          "maxclass": "textbutton",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            420.0,
            460.0,
            185.0,
            22.0
          ],
          "texton": "OPEN MONITOR",
          "mode": 1,
          "parameter_enable": 0,
          "rounded": 7.0,
          "fontsize": 12.0,
          "fontface": 1,
          "textcolor": [
            0.29,
            0.79,
            0.91,
            1.0
          ],
          "textoncolor": [
            0.91,
            0.94,
            0.98,
            1.0
          ],
          "bgcolor": [
            0.12,
            0.17,
            0.22,
            1.0
          ],
          "bgoncolor": [
            0.12,
            0.17,
            0.22,
            1.0
          ],
          "usegradient": 0,
          "usebgoncolor": 1,
          "outputmode": 1,
          "text": "OPEN MONITOR",
          "presentation": 1,
          "presentation_rect": [
            16.0,
            69.0,
            328.0,
            34.0
          ]
        }
      },
      {
        "box": {
          "id": "note1",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            620.0,
            460.0,
            185.0,
            22.0
          ],
          "fontsize": 11.0,
          "textcolor": [
            0.59,
            0.67,
            0.77,
            1.0
          ],
          "text": "Setari salvate in proiect / AUTO STOP OFF",
          "presentation": 1,
          "presentation_rect": [
            16.0,
            113.0,
            330.0,
            18.0
          ]
        }
      },
      {
        "box": {
          "id": "note2",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            820.0,
            460.0,
            185.0,
            22.0
          ],
          "fontsize": 11.0,
          "textcolor": [
            0.59,
            0.67,
            0.77,
            1.0
          ],
          "text": "Iesire muta cat timp dispozitivul este activ.",
          "presentation": 1,
          "presentation_rect": [
            16.0,
            135.0,
            330.0,
            18.0
          ]
        }
      },
      {
        "box": {
          "id": "open-bang",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            1020.0,
            460.0,
            185.0,
            22.0
          ],
          "text": "t b"
        }
      },
      {
        "box": {
          "id": "open-message",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            20.0,
            505.0,
            185.0,
            22.0
          ],
          "text": "open"
        }
      },
      {
        "box": {
          "id": "pcontrol",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            220.0,
            505.0,
            185.0,
            22.0
          ],
          "text": "pcontrol"
        }
      },
      {
        "box": {
          "id": "popup",
          "maxclass": "newobj",
          "numinlets": 4,
          "numoutlets": 1,
          "patching_rect": [
            420.0,
            505.0,
            185.0,
            22.0
          ],
          "patcher": {
            "fileversion": 1,
            "appversion": {
              "major": 8,
              "minor": 6,
              "revision": 0,
              "architecture": "x64",
              "modernui": 1
            },
            "classnamespace": "box",
            "rect": [
              60.0,
              50.0,
              600.0,
              340.0
            ],
            "openinpresentation": 1,
            "default_fontname": "Arial",
            "default_fontsize": 12.0,
            "bgcolor": [
              0.055,
              0.071,
              0.098,
              1.0
            ],
            "editing_bgcolor": [
              0.055,
              0.071,
              0.098,
              1.0
            ],
            "locked_bgcolor": [
              0.055,
              0.071,
              0.098,
              1.0
            ],
            "toolbarvisible": 0,
            "boxes": [
              {
                "box": {
                  "id": "in",
                  "maxclass": "inlet",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    20.0,
                    25.0,
                    25.0
                  ],
                  "index": 1
                }
              },
              {
                "box": {
                  "id": "out",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    20.0,
                    460.0,
                    185.0,
                    22.0
                  ],
                  "text": "outlet"
                }
              },
              {
                "box": {
                  "id": "route",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 20,
                  "patching_rect": [
                    220.0,
                    460.0,
                    185.0,
                    22.0
                  ],
                  "text": "route state delta count level tests raw sync maxdev disarm init api hasdelta stopnote wave_type wave_channel wave_types wave_channels wave_samples beatlevel"
                }
              },
              {
                "box": {
                  "id": "load",
                  "maxclass": "newobj",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    460.0,
                    185.0,
                    22.0
                  ],
                  "text": "loadbang"
                }
              },
              {
                "box": {
                  "id": "window-config",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    620.0,
                    460.0,
                    185.0,
                    22.0
                  ],
                  "text": "window flags float nogrow nozoom, window size 60 50 660 390, window exec"
                }
              },
              {
                "box": {
                  "id": "window",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "patching_rect": [
                    820.0,
                    460.0,
                    185.0,
                    22.0
                  ],
                  "text": "thispatcher"
                }
              },
              {
                "box": {
                  "id": "title",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    1020.0,
                    460.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 16.0,
                  "textcolor": [
                    0.29,
                    0.79,
                    0.91,
                    1.0
                  ],
                  "fontface": 1,
                  "text": "VOCAL TIMING MONITOR",
                  "presentation": 1,
                  "presentation_rect": [
                    16.0,
                    10.0,
                    350.0,
                    25.0
                  ]
                }
              },
              {
                "box": {
                  "id": "version",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    20.0,
                    505.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 9.0,
                  "textcolor": [
                    0.59,
                    0.67,
                    0.77,
                    1.0
                  ],
                  "text": "0.7 RC3.3 / SALVARE",
                  "presentation": 1,
                  "presentation_rect": [
                    367.0,
                    17.0,
                    112.0,
                    15.0
                  ]
                }
              },
              {
                "box": {
                  "id": "subtitle",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    220.0,
                    505.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 12.0,
                  "textcolor": [
                    0.59,
                    0.67,
                    0.77,
                    1.0
                  ],
                  "text": "Reper ritmic in timp real. Flow-ul si creativitatea raman ale tale."
                }
              },
              {
                "box": {
                  "id": "state-card",
                  "maxclass": "panel",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    420.0,
                    505.0,
                    185.0,
                    22.0
                  ],
                  "bgcolor": [
                    0.094,
                    0.118,
                    0.157,
                    1.0
                  ],
                  "border": 0,
                  "rounded": 12,
                  "background": 1,
                  "ignoreclick": 1,
                  "presentation": 1,
                  "presentation_rect": [
                    12.0,
                    46.0,
                    576.0,
                    60.0
                  ]
                }
              },
              {
                "box": {
                  "id": "delta-card",
                  "maxclass": "panel",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    620.0,
                    505.0,
                    185.0,
                    22.0
                  ],
                  "bgcolor": [
                    0.094,
                    0.118,
                    0.157,
                    1.0
                  ],
                  "border": 0,
                  "rounded": 12,
                  "background": 1,
                  "ignoreclick": 1
                }
              },
              {
                "box": {
                  "id": "count-card",
                  "maxclass": "panel",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    820.0,
                    505.0,
                    185.0,
                    22.0
                  ],
                  "bgcolor": [
                    0.094,
                    0.118,
                    0.157,
                    1.0
                  ],
                  "border": 0,
                  "rounded": 12,
                  "background": 1,
                  "ignoreclick": 1
                }
              },
              {
                "box": {
                  "id": "state-caption",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    1020.0,
                    505.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 10.0,
                  "textcolor": [
                    0.59,
                    0.67,
                    0.77,
                    1.0
                  ],
                  "text": "STARE"
                }
              },
              {
                "box": {
                  "id": "state-text",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    20.0,
                    550.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 19.0,
                  "textcolor": [
                    0.59,
                    0.67,
                    0.77,
                    1.0
                  ],
                  "fontface": 1,
                  "text": "INITIALIZARE",
                  "presentation": 1,
                  "presentation_rect": [
                    24.0,
                    54.0,
                    384.0,
                    26.0
                  ],
                  "hint": "Ultimul atac fata de grila Live. Verde: aproape; galben: decalaj moderat; rosu: pragul Auto Stop atins. Nu e evaluarea flow-ului."
                }
              },
              {
                "box": {
                  "id": "clock-text",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    220.0,
                    550.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 10.0,
                  "textcolor": [
                    0.59,
                    0.67,
                    0.77,
                    1.0
                  ],
                  "text": "Ceas audio: --",
                  "presentation": 1,
                  "presentation_rect": [
                    24.0,
                    83.0,
                    382.0,
                    16.0
                  ]
                }
              },
              {
                "box": {
                  "id": "api-text",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    420.0,
                    550.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 10.0,
                  "textcolor": [
                    0.59,
                    0.67,
                    0.77,
                    1.0
                  ],
                  "text": "Auto Stop: initializare conexiune",
                  "presentation": 1,
                  "presentation_rect": [
                    24.0,
                    516.0,
                    552.0,
                    19.0
                  ]
                }
              },
              {
                "box": {
                  "id": "delta-caption",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    620.0,
                    550.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 10.0,
                  "textcolor": [
                    0.59,
                    0.67,
                    0.77,
                    1.0
                  ],
                  "text": "ULTIMA ABATERE"
                }
              },
              {
                "box": {
                  "id": "delta-text",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    820.0,
                    550.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 27.0,
                  "textcolor": [
                    0.91,
                    0.94,
                    0.98,
                    1.0
                  ],
                  "fontface": 1,
                  "text": "--",
                  "presentation": 1,
                  "presentation_rect": [
                    424.0,
                    49.0,
                    154.0,
                    34.0
                  ]
                }
              },
              {
                "box": {
                  "id": "sign-caption",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    1020.0,
                    550.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 9.0,
                  "textcolor": [
                    0.59,
                    0.67,
                    0.77,
                    1.0
                  ],
                  "text": "- devreme / + tarziu",
                  "presentation": 1,
                  "presentation_rect": [
                    424.0,
                    85.0,
                    154.0,
                    15.0
                  ]
                }
              },
              {
                "box": {
                  "id": "count-caption",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    20.0,
                    595.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 10.0,
                  "textcolor": [
                    0.59,
                    0.67,
                    0.77,
                    1.0
                  ],
                  "text": "ATACURI AUDIO",
                  "presentation": 1,
                  "presentation_rect": [
                    376.0,
                    122.0,
                    112.0,
                    17.0
                  ]
                }
              },
              {
                "box": {
                  "id": "count-text",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    220.0,
                    595.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 21.0,
                  "textcolor": [
                    0.91,
                    0.94,
                    0.98,
                    1.0
                  ],
                  "fontface": 1,
                  "text": "0",
                  "presentation": 1,
                  "presentation_rect": [
                    493.0,
                    116.0,
                    85.0,
                    28.0
                  ]
                }
              },
              {
                "box": {
                  "id": "tests-text",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    420.0,
                    595.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 10.0,
                  "textcolor": [
                    0.59,
                    0.67,
                    0.77,
                    1.0
                  ],
                  "text": "Teste: 0",
                  "presentation": 1,
                  "presentation_rect": [
                    24.0,
                    542.0,
                    130.0,
                    17.0
                  ]
                }
              },
              {
                "box": {
                  "id": "enabled",
                  "maxclass": "textbutton",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "patching_rect": [
                    620.0,
                    595.0,
                    185.0,
                    22.0
                  ],
                  "texton": "ANALIZA ON",
                  "mode": 1,
                  "parameter_enable": 1,
                  "rounded": 7.0,
                  "fontsize": 10.0,
                  "fontface": 1,
                  "textcolor": [
                    0.91,
                    0.94,
                    0.98,
                    1.0
                  ],
                  "textoncolor": [
                    0.91,
                    0.94,
                    0.98,
                    1.0
                  ],
                  "bgcolor": [
                    0.12,
                    0.17,
                    0.22,
                    1.0
                  ],
                  "bgoncolor": [
                    0.1,
                    0.31,
                    0.38,
                    1.0
                  ],
                  "usegradient": 0,
                  "usebgoncolor": 1,
                  "outputmode": 1,
                  "text": "ANALIZA OFF",
                  "presentation": 1,
                  "presentation_rect": [
                    16.0,
                    116.0,
                    100.0,
                    28.0
                  ],
                  "parameter_mappable": 0,
                  "varname": "vtm_enabled",
                  "saved_attribute_attributes": {
                    "valueof": {
                      "parameter_longname": "VTM Analysis",
                      "parameter_shortname": "VTM Analysis",
                      "parameter_type": 1,
                      "parameter_invisible": 1,
                      "parameter_initial_enable": 1,
                      "parameter_initial": [
                        1
                      ],
                      "parameter_order": 0,
                      "parameter_mmin": 0.0,
                      "parameter_mmax": 1.0
                    }
                  }
                }
              },
              {
                "box": {
                  "id": "autostop",
                  "maxclass": "textbutton",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "patching_rect": [
                    820.0,
                    595.0,
                    185.0,
                    22.0
                  ],
                  "texton": "AUTO STOP ON",
                  "mode": 1,
                  "parameter_enable": 0,
                  "rounded": 7.0,
                  "fontsize": 11.0,
                  "fontface": 1,
                  "textcolor": [
                    0.91,
                    0.94,
                    0.98,
                    1.0
                  ],
                  "textoncolor": [
                    1.0,
                    0.73,
                    0.3,
                    1.0
                  ],
                  "bgcolor": [
                    0.12,
                    0.17,
                    0.22,
                    1.0
                  ],
                  "bgoncolor": [
                    0.32,
                    0.22,
                    0.09,
                    1.0
                  ],
                  "usegradient": 0,
                  "usebgoncolor": 1,
                  "outputmode": 1,
                  "text": "AUTO STOP OFF",
                  "presentation": 1,
                  "presentation_rect": [
                    124.0,
                    116.0,
                    156.0,
                    28.0
                  ],
                  "hint": "Activare explicita dupa sincronizare. La prima abatere care atinge pragul, opreste Live si inregistrarea in curs; apoi revine OFF."
                }
              },
              {
                "box": {
                  "id": "test",
                  "maxclass": "textbutton",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "patching_rect": [
                    1020.0,
                    595.0,
                    185.0,
                    22.0
                  ],
                  "texton": "TEST IMPULS",
                  "mode": 1,
                  "parameter_enable": 0,
                  "rounded": 7.0,
                  "fontsize": 10.0,
                  "fontface": 1,
                  "textcolor": [
                    0.29,
                    0.79,
                    0.91,
                    1.0
                  ],
                  "textoncolor": [
                    0.91,
                    0.94,
                    0.98,
                    1.0
                  ],
                  "bgcolor": [
                    0.12,
                    0.17,
                    0.22,
                    1.0
                  ],
                  "bgoncolor": [
                    0.12,
                    0.17,
                    0.22,
                    1.0
                  ],
                  "usegradient": 0,
                  "usebgoncolor": 1,
                  "outputmode": 1,
                  "text": "TEST IMPULS",
                  "presentation": 1,
                  "presentation_rect": [
                    452.0,
                    477.0,
                    124.0,
                    25.0
                  ]
                }
              },
              {
                "box": {
                  "id": "reset",
                  "maxclass": "textbutton",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "patching_rect": [
                    20.0,
                    640.0,
                    185.0,
                    22.0
                  ],
                  "texton": "RESET",
                  "mode": 1,
                  "parameter_enable": 0,
                  "rounded": 7.0,
                  "fontsize": 11.0,
                  "fontface": 1,
                  "textcolor": [
                    0.91,
                    0.94,
                    0.98,
                    1.0
                  ],
                  "textoncolor": [
                    0.91,
                    0.94,
                    0.98,
                    1.0
                  ],
                  "bgcolor": [
                    0.12,
                    0.17,
                    0.22,
                    1.0
                  ],
                  "bgoncolor": [
                    0.12,
                    0.17,
                    0.22,
                    1.0
                  ],
                  "usegradient": 0,
                  "usebgoncolor": 1,
                  "outputmode": 1,
                  "text": "RESET",
                  "presentation": 1,
                  "presentation_rect": [
                    288.0,
                    116.0,
                    70.0,
                    28.0
                  ]
                }
              },
              {
                "box": {
                  "id": "level-text",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    220.0,
                    640.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 10.0,
                  "textcolor": [
                    0.59,
                    0.67,
                    0.77,
                    1.0
                  ],
                  "hint": "Varful audio brut pe ultimele 600 ms, inaintea detectorului.",
                  "text": "Intrare: -- dB",
                  "presentation": 1,
                  "presentation_rect": [
                    366.0,
                    154.0,
                    218.0,
                    16.0
                  ]
                }
              },
              {
                "box": {
                  "id": "grid-caption",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    420.0,
                    640.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 9.0,
                  "textcolor": [
                    0.59,
                    0.67,
                    0.77,
                    1.0
                  ],
                  "text": "GRILA",
                  "presentation": 1,
                  "presentation_rect": [
                    24.0,
                    417.0,
                    90.0,
                    16.0
                  ]
                }
              },
              {
                "box": {
                  "id": "grid-ui",
                  "maxclass": "umenu",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "patching_rect": [
                    620.0,
                    640.0,
                    185.0,
                    22.0
                  ],
                  "items": [
                    "1/4",
                    ",",
                    "1/8",
                    ",",
                    "1/16"
                  ],
                  "bgcolor": [
                    0.094,
                    0.118,
                    0.157,
                    1.0
                  ],
                  "textcolor": [
                    0.91,
                    0.94,
                    0.98,
                    1.0
                  ],
                  "parameter_enable": 1,
                  "presentation": 1,
                  "presentation_rect": [
                    24.0,
                    438.0,
                    80.0,
                    26.0
                  ],
                  "fontsize": 11.0,
                  "parameter_mappable": 0,
                  "varname": "vtm_grid_ui",
                  "saved_attribute_attributes": {
                    "valueof": {
                      "parameter_longname": "VTM Grid",
                      "parameter_shortname": "VTM Grid",
                      "parameter_type": 1,
                      "parameter_invisible": 1,
                      "parameter_initial_enable": 1,
                      "parameter_initial": [
                        0
                      ],
                      "parameter_order": 1,
                      "parameter_mmin": 0.0,
                      "parameter_mmax": 2.0
                    }
                  }
                }
              },
              {
                "box": {
                  "id": "grid-map",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    640.0,
                    185.0,
                    22.0
                  ],
                  "text": "expr 4 * (1 + ($i1 == 1) + 3 * ($i1 == 2))"
                }
              },
              {
                "box": {
                  "id": "grid-tag",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    640.0,
                    185.0,
                    22.0
                  ],
                  "text": "prepend grid"
                }
              },
              {
                "box": {
                  "id": "redms-label",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    20.0,
                    685.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 9.0,
                  "textcolor": [
                    0.59,
                    0.67,
                    0.77,
                    1.0
                  ],
                  "text": "PRAG +/- ms",
                  "presentation": 1,
                  "presentation_rect": [
                    120.0,
                    417.0,
                    110.0,
                    16.0
                  ]
                }
              },
              {
                "box": {
                  "id": "redms",
                  "maxclass": "number",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "patching_rect": [
                    220.0,
                    685.0,
                    185.0,
                    22.0
                  ],
                  "minimum": 10,
                  "maximum": 300,
                  "bgcolor": [
                    0.094,
                    0.118,
                    0.157,
                    1.0
                  ],
                  "textcolor": [
                    0.91,
                    0.94,
                    0.98,
                    1.0
                  ],
                  "triangle": 0,
                  "parameter_enable": 1,
                  "format": 0,
                  "presentation": 1,
                  "presentation_rect": [
                    120.0,
                    438.0,
                    100.0,
                    26.0
                  ],
                  "fontsize": 11.0,
                  "parameter_mappable": 0,
                  "varname": "vtm_redms",
                  "saved_attribute_attributes": {
                    "valueof": {
                      "parameter_longname": "VTM Threshold ms",
                      "parameter_shortname": "VTM Threshold ms",
                      "parameter_type": 0,
                      "parameter_invisible": 1,
                      "parameter_initial_enable": 1,
                      "parameter_initial": [
                        100
                      ],
                      "parameter_order": 2,
                      "parameter_mmin": 10.0,
                      "parameter_mmax": 300.0,
                      "parameter_unitstyle": 0
                    }
                  }
                }
              },
              {
                "box": {
                  "id": "redms-tag",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    685.0,
                    185.0,
                    22.0
                  ],
                  "text": "prepend redms"
                }
              },
              {
                "box": {
                  "id": "offsetms-label",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    620.0,
                    685.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 9.0,
                  "textcolor": [
                    0.59,
                    0.67,
                    0.77,
                    1.0
                  ],
                  "text": "COMPENSARE ms",
                  "presentation": 1,
                  "presentation_rect": [
                    236.0,
                    417.0,
                    118.0,
                    16.0
                  ]
                }
              },
              {
                "box": {
                  "id": "offsetms",
                  "maxclass": "flonum",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "patching_rect": [
                    820.0,
                    685.0,
                    185.0,
                    22.0
                  ],
                  "minimum": -500,
                  "maximum": 500,
                  "bgcolor": [
                    0.094,
                    0.118,
                    0.157,
                    1.0
                  ],
                  "textcolor": [
                    0.91,
                    0.94,
                    0.98,
                    1.0
                  ],
                  "triangle": 0,
                  "parameter_enable": 1,
                  "format": 6,
                  "presentation": 1,
                  "presentation_rect": [
                    236.0,
                    438.0,
                    108.0,
                    26.0
                  ],
                  "fontsize": 11.0,
                  "parameter_mappable": 0,
                  "varname": "vtm_offsetms",
                  "saved_attribute_attributes": {
                    "valueof": {
                      "parameter_longname": "VTM Compensation ms",
                      "parameter_shortname": "VTM Compensation ms",
                      "parameter_type": 0,
                      "parameter_invisible": 1,
                      "parameter_initial_enable": 1,
                      "parameter_initial": [
                        0.0
                      ],
                      "parameter_order": 3,
                      "parameter_mmin": -500.0,
                      "parameter_mmax": 500.0
                    }
                  }
                }
              },
              {
                "box": {
                  "id": "offsetms-tag",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    685.0,
                    185.0,
                    22.0
                  ],
                  "text": "prepend offsetms"
                }
              },
              {
                "box": {
                  "id": "gatedb-label",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    20.0,
                    730.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 9.0,
                  "textcolor": [
                    0.59,
                    0.67,
                    0.77,
                    1.0
                  ],
                  "text": "DETECTIE dB",
                  "presentation": 1,
                  "presentation_rect": [
                    360.0,
                    417.0,
                    110.0,
                    16.0
                  ]
                }
              },
              {
                "box": {
                  "id": "gatedb",
                  "maxclass": "flonum",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "patching_rect": [
                    220.0,
                    730.0,
                    185.0,
                    22.0
                  ],
                  "minimum": -60,
                  "maximum": -6,
                  "bgcolor": [
                    0.094,
                    0.118,
                    0.157,
                    1.0
                  ],
                  "textcolor": [
                    0.91,
                    0.94,
                    0.98,
                    1.0
                  ],
                  "triangle": 0,
                  "parameter_enable": 1,
                  "format": 6,
                  "presentation": 1,
                  "presentation_rect": [
                    360.0,
                    438.0,
                    100.0,
                    26.0
                  ],
                  "fontsize": 11.0,
                  "parameter_mappable": 0,
                  "varname": "vtm_gatedb",
                  "saved_attribute_attributes": {
                    "valueof": {
                      "parameter_longname": "VTM Detection dB",
                      "parameter_shortname": "VTM Detection dB",
                      "parameter_type": 0,
                      "parameter_invisible": 1,
                      "parameter_initial_enable": 1,
                      "parameter_initial": [
                        -32.0
                      ],
                      "parameter_order": 4,
                      "parameter_mmin": -60.0,
                      "parameter_mmax": -6.0
                    }
                  }
                }
              },
              {
                "box": {
                  "id": "gatedb-tag",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    730.0,
                    185.0,
                    22.0
                  ],
                  "text": "prepend gatedb"
                }
              },
              {
                "box": {
                  "id": "calibrate",
                  "maxclass": "textbutton",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "patching_rect": [
                    620.0,
                    730.0,
                    185.0,
                    22.0
                  ],
                  "texton": "CALIBREAZA",
                  "mode": 1,
                  "parameter_enable": 0,
                  "rounded": 7.0,
                  "fontsize": 10.0,
                  "fontface": 1,
                  "textcolor": [
                    0.91,
                    0.94,
                    0.98,
                    1.0
                  ],
                  "textoncolor": [
                    0.91,
                    0.94,
                    0.98,
                    1.0
                  ],
                  "bgcolor": [
                    0.12,
                    0.17,
                    0.22,
                    1.0
                  ],
                  "bgoncolor": [
                    0.12,
                    0.17,
                    0.22,
                    1.0
                  ],
                  "usegradient": 0,
                  "usebgoncolor": 1,
                  "outputmode": 1,
                  "text": "CALIBREAZA",
                  "active": 0,
                  "presentation": 1,
                  "presentation_rect": [
                    476.0,
                    438.0,
                    100.0,
                    26.0
                  ],
                  "hint": "Preia ultima abatere audio bruta; doar impuls cunoscut pe grila 1/4."
                }
              },
              {
                "box": {
                  "id": "cal-hint",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    820.0,
                    730.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 10.0,
                  "textcolor": [
                    0.59,
                    0.67,
                    0.77,
                    1.0
                  ],
                  "text": "Calibrare: impuls cunoscut, grila 1/4."
                }
              },
              {
                "box": {
                  "id": "limit-text",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    1020.0,
                    730.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 9.0,
                  "textcolor": [
                    0.59,
                    0.67,
                    0.77,
                    1.0
                  ],
                  "text": "Limita grilei: -- ms",
                  "presentation": 1,
                  "presentation_rect": [
                    24.0,
                    566.0,
                    552.0,
                    17.0
                  ]
                }
              },
              {
                "box": {
                  "id": "footer",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    20.0,
                    775.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 10.0,
                  "textcolor": [
                    0.59,
                    0.67,
                    0.77,
                    1.0
                  ],
                  "text": "Microfonul nu este redat la iesire cat timp dispozitivul este activ. Auto Stop: OFF la incarcare."
                }
              },
              {
                "box": {
                  "id": "footer2",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    220.0,
                    775.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 9.0,
                  "textcolor": [
                    0.59,
                    0.67,
                    0.77,
                    1.0
                  ],
                  "text": "Setari in proiect (Ctrl+S). Auto Stop se activeaza manual. Iesire microfon muta.",
                  "presentation": 1,
                  "presentation_rect": [
                    24.0,
                    588.0,
                    552.0,
                    16.0
                  ]
                }
              },
              {
                "box": {
                  "id": "state-select",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 12,
                  "patching_rect": [
                    420.0,
                    775.0,
                    185.0,
                    22.0
                  ],
                  "text": "sel 0 1 2 3 4 5 6 7 8 9 10"
                }
              },
              {
                "box": {
                  "id": "status-0",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    620.0,
                    775.0,
                    185.0,
                    22.0
                  ],
                  "text": "set ANALIZA OPRITA"
                }
              },
              {
                "box": {
                  "id": "color-0",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    775.0,
                    185.0,
                    22.0
                  ],
                  "text": "textcolor 0.59 0.67 0.77 1.0"
                }
              },
              {
                "box": {
                  "id": "status-1",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    775.0,
                    185.0,
                    22.0
                  ],
                  "text": "set ASTEPT CEAS AUDIO"
                }
              },
              {
                "box": {
                  "id": "color-1",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    820.0,
                    185.0,
                    22.0
                  ],
                  "text": "textcolor 0.59 0.67 0.77 1.0"
                }
              },
              {
                "box": {
                  "id": "status-2",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    820.0,
                    185.0,
                    22.0
                  ],
                  "text": "set STABILIZEZ CEASUL"
                }
              },
              {
                "box": {
                  "id": "color-2",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    820.0,
                    185.0,
                    22.0
                  ],
                  "text": "textcolor 1.0 0.73 0.3 1.0"
                }
              },
              {
                "box": {
                  "id": "status-3",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    620.0,
                    820.0,
                    185.0,
                    22.0
                  ],
                  "text": "set ASCULT / SYNC OK"
                }
              },
              {
                "box": {
                  "id": "color-3",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    820.0,
                    185.0,
                    22.0
                  ],
                  "text": "textcolor 0.29 0.79 0.91 1.0"
                }
              },
              {
                "box": {
                  "id": "status-4",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    820.0,
                    185.0,
                    22.0
                  ],
                  "text": "set ON BEAT"
                }
              },
              {
                "box": {
                  "id": "color-4",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    865.0,
                    185.0,
                    22.0
                  ],
                  "text": "textcolor 0.35 0.84 0.64 1.0"
                }
              },
              {
                "box": {
                  "id": "status-5",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    865.0,
                    185.0,
                    22.0
                  ],
                  "text": "set USOR DECALAT"
                }
              },
              {
                "box": {
                  "id": "color-5",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    865.0,
                    185.0,
                    22.0
                  ],
                  "text": "textcolor 1.0 0.73 0.3 1.0"
                }
              },
              {
                "box": {
                  "id": "status-6",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    620.0,
                    865.0,
                    185.0,
                    22.0
                  ],
                  "text": "set OFF BEAT"
                }
              },
              {
                "box": {
                  "id": "color-6",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    865.0,
                    185.0,
                    22.0
                  ],
                  "text": "textcolor 1.0 0.38 0.43 1.0"
                }
              },
              {
                "box": {
                  "id": "status-7",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    865.0,
                    185.0,
                    22.0
                  ],
                  "text": "set TEST OK"
                }
              },
              {
                "box": {
                  "id": "color-7",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    910.0,
                    185.0,
                    22.0
                  ],
                  "text": "textcolor 0.29 0.79 0.91 1.0"
                }
              },
              {
                "box": {
                  "id": "status-8",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    910.0,
                    185.0,
                    22.0
                  ],
                  "text": "set TEST: FARA SYNC LA CLICK"
                }
              },
              {
                "box": {
                  "id": "color-8",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    910.0,
                    185.0,
                    22.0
                  ],
                  "text": "textcolor 1.0 0.73 0.3 1.0"
                }
              },
              {
                "box": {
                  "id": "status-9",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    620.0,
                    910.0,
                    185.0,
                    22.0
                  ],
                  "text": "set OPRIRE..."
                }
              },
              {
                "box": {
                  "id": "color-9",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    910.0,
                    185.0,
                    22.0
                  ],
                  "text": "textcolor 1.0 0.38 0.43 1.0"
                }
              },
              {
                "box": {
                  "id": "status-10",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    910.0,
                    185.0,
                    22.0
                  ],
                  "text": "set FARA PROCESARE AUDIO"
                }
              },
              {
                "box": {
                  "id": "color-10",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    955.0,
                    185.0,
                    22.0
                  ],
                  "text": "textcolor 1.0 0.73 0.3 1.0"
                }
              },
              {
                "box": {
                  "id": "delta-gate",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    955.0,
                    185.0,
                    22.0
                  ],
                  "text": "gate 1 0"
                }
              },
              {
                "box": {
                  "id": "delta-format",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    955.0,
                    185.0,
                    22.0
                  ],
                  "text": "sprintf %+.1f ms"
                }
              },
              {
                "box": {
                  "id": "delta-set",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    620.0,
                    955.0,
                    185.0,
                    22.0
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "hasdelta-select",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "patching_rect": [
                    820.0,
                    955.0,
                    185.0,
                    22.0
                  ],
                  "text": "sel 0"
                }
              },
              {
                "box": {
                  "id": "no-delta",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    955.0,
                    185.0,
                    22.0
                  ],
                  "text": "set --"
                }
              },
              {
                "box": {
                  "id": "count-format",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    1000.0,
                    185.0,
                    22.0
                  ],
                  "text": "sprintf %ld"
                }
              },
              {
                "box": {
                  "id": "count-set",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    1000.0,
                    185.0,
                    22.0
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "tests-format",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    1000.0,
                    185.0,
                    22.0
                  ],
                  "text": "sprintf Teste: %ld"
                }
              },
              {
                "box": {
                  "id": "tests-set",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    620.0,
                    1000.0,
                    185.0,
                    22.0
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "level-floor",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    1000.0,
                    185.0,
                    22.0
                  ],
                  "text": "maximum 0.00001"
                }
              },
              {
                "box": {
                  "id": "level-db",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    1000.0,
                    185.0,
                    22.0
                  ],
                  "text": "expr 20. * log10($f1)"
                }
              },
              {
                "box": {
                  "id": "level-format",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    1045.0,
                    185.0,
                    22.0
                  ],
                  "text": "sprintf Intrare: %.1f dB"
                }
              },
              {
                "box": {
                  "id": "level-set",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    1045.0,
                    185.0,
                    22.0
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "maxdev-format",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    1045.0,
                    185.0,
                    22.0
                  ],
                  "text": "sprintf Limita grilei: +/- %.1f ms (pragul mai mare nu poate fi atins)"
                }
              },
              {
                "box": {
                  "id": "maxdev-set",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    620.0,
                    1045.0,
                    185.0,
                    22.0
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "sync-select",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "patching_rect": [
                    820.0,
                    1045.0,
                    185.0,
                    22.0
                  ],
                  "text": "sel 0 1"
                }
              },
              {
                "box": {
                  "id": "sync-0",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    1045.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Ceas audio: indisponibil / oprit"
                }
              },
              {
                "box": {
                  "id": "sync-1",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    1090.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Ceas audio: sincronizat"
                }
              },
              {
                "box": {
                  "id": "api-select",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "patching_rect": [
                    220.0,
                    1090.0,
                    185.0,
                    22.0
                  ],
                  "text": "sel 0 1"
                }
              },
              {
                "box": {
                  "id": "api-0",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    1090.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Auto Stop: conexiune indisponibila"
                }
              },
              {
                "box": {
                  "id": "api-1",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    620.0,
                    1090.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Auto Stop: conexiune pregatita"
                }
              },
              {
                "box": {
                  "id": "stopnote-select",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 11,
                  "patching_rect": [
                    820.0,
                    1090.0,
                    185.0,
                    22.0
                  ],
                  "text": "sel 0 1 3 4 5 6 7 8 9 10"
                }
              },
              {
                "box": {
                  "id": "stopnote-0",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    1090.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Auto Stop: verific cererea"
                }
              },
              {
                "box": {
                  "id": "stopnote-1",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    1135.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Ultimul Stop: blocat - fara conexiune"
                }
              },
              {
                "box": {
                  "id": "stopnote-3",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    1135.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Ultimul Stop: blocat - dispozitiv inactiv"
                }
              },
              {
                "box": {
                  "id": "stopnote-4",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    1135.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Ultimul Stop: blocat - fara ceas"
                }
              },
              {
                "box": {
                  "id": "stopnote-5",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    620.0,
                    1135.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Ultimul Stop: blocat - fara procesare audio"
                }
              },
              {
                "box": {
                  "id": "stopnote-6",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    1135.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Ultimul Stop: blocat - analiza OFF"
                }
              },
              {
                "box": {
                  "id": "stopnote-7",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    1135.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Ultimul Stop: anulat - comutator OFF"
                }
              },
              {
                "box": {
                  "id": "stopnote-8",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    1180.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Ultimul Stop: comanda trimisa"
                }
              },
              {
                "box": {
                  "id": "stopnote-9",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    1180.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Ultimul Stop: oprire confirmata de Live"
                }
              },
              {
                "box": {
                  "id": "stopnote-10",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    1180.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Ultimul Stop: Live inca reda"
                }
              },
              {
                "box": {
                  "id": "raw-store",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    620.0,
                    1180.0,
                    185.0,
                    22.0
                  ],
                  "text": "f 0."
                }
              },
              {
                "box": {
                  "id": "cal-pak",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    1180.0,
                    185.0,
                    22.0
                  ],
                  "text": "pak 0 0"
                }
              },
              {
                "box": {
                  "id": "cal-unpack",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "patching_rect": [
                    1020.0,
                    1180.0,
                    185.0,
                    22.0
                  ],
                  "text": "unpack 0 0"
                }
              },
              {
                "box": {
                  "id": "cal-valid",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    1225.0,
                    185.0,
                    22.0
                  ],
                  "text": "expr ($i1 > 0) && ($i2 == 0)"
                }
              },
              {
                "box": {
                  "id": "cal-gate",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    1225.0,
                    185.0,
                    22.0
                  ],
                  "text": "gate 1 0"
                }
              },
              {
                "box": {
                  "id": "cal-active",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    1225.0,
                    185.0,
                    22.0
                  ],
                  "text": "prepend active"
                }
              },
              {
                "box": {
                  "id": "cal-bang",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    620.0,
                    1225.0,
                    185.0,
                    22.0
                  ],
                  "text": "t b"
                }
              },
              {
                "box": {
                  "id": "enabled-tag",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    1225.0,
                    185.0,
                    22.0
                  ],
                  "text": "prepend enabled"
                }
              },
              {
                "box": {
                  "id": "autostop-tag",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    1225.0,
                    185.0,
                    22.0
                  ],
                  "text": "prepend autostop"
                }
              },
              {
                "box": {
                  "id": "test-bang",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    1270.0,
                    185.0,
                    22.0
                  ],
                  "text": "t b"
                }
              },
              {
                "box": {
                  "id": "test-counter",
                  "maxclass": "newobj",
                  "numinlets": 5,
                  "numoutlets": 4,
                  "patching_rect": [
                    220.0,
                    1270.0,
                    185.0,
                    22.0
                  ],
                  "text": "counter 1 1000000000"
                }
              },
              {
                "box": {
                  "id": "test-tag",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    1270.0,
                    185.0,
                    22.0
                  ],
                  "text": "prepend testseq"
                }
              },
              {
                "box": {
                  "id": "reset-bang",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    620.0,
                    1270.0,
                    185.0,
                    22.0
                  ],
                  "text": "t b"
                }
              },
              {
                "box": {
                  "id": "reset-counter",
                  "maxclass": "newobj",
                  "numinlets": 5,
                  "numoutlets": 4,
                  "patching_rect": [
                    820.0,
                    1270.0,
                    185.0,
                    22.0
                  ],
                  "text": "counter 1 1000000000"
                }
              },
              {
                "box": {
                  "id": "reset-tag",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    1270.0,
                    185.0,
                    22.0
                  ],
                  "text": "prepend resetseq"
                }
              },
              {
                "box": {
                  "id": "off",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    1315.0,
                    185.0,
                    22.0
                  ],
                  "text": "0"
                }
              },
              {
                "box": {
                  "id": "initialize",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 7,
                  "patching_rect": [
                    220.0,
                    1315.0,
                    185.0,
                    22.0
                  ],
                  "text": "t b b b b b b b"
                }
              },
              {
                "box": {
                  "id": "initial-0",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    1315.0,
                    185.0,
                    22.0
                  ],
                  "text": "bang"
                }
              },
              {
                "box": {
                  "id": "initial-1",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    620.0,
                    1315.0,
                    185.0,
                    22.0
                  ],
                  "text": "0"
                }
              },
              {
                "box": {
                  "id": "initial-2",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    1315.0,
                    185.0,
                    22.0
                  ],
                  "text": "bang"
                }
              },
              {
                "box": {
                  "id": "initial-3",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    1315.0,
                    185.0,
                    22.0
                  ],
                  "text": "bang"
                }
              },
              {
                "box": {
                  "id": "initial-4",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    1360.0,
                    185.0,
                    22.0
                  ],
                  "text": "bang"
                }
              },
              {
                "box": {
                  "id": "initial-5",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    1360.0,
                    185.0,
                    22.0
                  ],
                  "text": "bang"
                }
              },
              {
                "box": {
                  "id": "initial-6",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    1360.0,
                    185.0,
                    22.0
                  ],
                  "text": "set --"
                }
              },
              {
                "box": {
                  "id": "voice-caption",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    620.0,
                    1360.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 10.0,
                  "textcolor": [
                    0.29,
                    0.79,
                    0.91,
                    1.0
                  ],
                  "fontface": 1,
                  "text": "VOCE / INTRAREA PISTEI",
                  "presentation": 1,
                  "presentation_rect": [
                    16.0,
                    154.0,
                    330.0,
                    16.0
                  ]
                }
              },
              {
                "box": {
                  "id": "history-caption",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    820.0,
                    1360.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 10.0,
                  "textcolor": [
                    0.59,
                    0.67,
                    0.77,
                    1.0
                  ],
                  "text": "Istoric comun: 6 secunde"
                }
              },
              {
                "box": {
                  "id": "voice-gain-caption",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    1020.0,
                    1360.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 10.0,
                  "textcolor": [
                    0.59,
                    0.67,
                    0.77,
                    1.0
                  ],
                  "text": "MARIRE VOCE x",
                  "presentation": 1,
                  "presentation_rect": [
                    24.0,
                    481.0,
                    118.0,
                    17.0
                  ]
                }
              },
              {
                "box": {
                  "id": "grid-wave-caption",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    20.0,
                    1405.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 9.0,
                  "textcolor": [
                    1.0,
                    0.73,
                    0.3,
                    1.0
                  ],
                  "text": "REPERE GRILA LIVE"
                }
              },
              {
                "box": {
                  "id": "grid-wave-hint",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    220.0,
                    1405.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 9.0,
                  "textcolor": [
                    0.59,
                    0.67,
                    0.77,
                    1.0
                  ],
                  "text": "Reperele se deplaseaza impreuna cu undele"
                }
              },
              {
                "box": {
                  "id": "beat-caption",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    420.0,
                    1405.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 10.0,
                  "textcolor": [
                    0.35,
                    0.84,
                    0.64,
                    1.0
                  ],
                  "fontface": 1,
                  "text": "INSTRUMENTAL",
                  "presentation": 1,
                  "presentation_rect": [
                    16.0,
                    250.0,
                    330.0,
                    16.0
                  ]
                }
              },
              {
                "box": {
                  "id": "beat-level",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    620.0,
                    1405.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 10.0,
                  "textcolor": [
                    0.59,
                    0.67,
                    0.77,
                    1.0
                  ],
                  "text": "Beat: -- dB",
                  "presentation": 1,
                  "presentation_rect": [
                    366.0,
                    250.0,
                    218.0,
                    16.0
                  ]
                }
              },
              {
                "box": {
                  "id": "beat-gain-caption",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    820.0,
                    1405.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 10.0,
                  "textcolor": [
                    0.59,
                    0.67,
                    0.77,
                    1.0
                  ],
                  "text": "MARIRE BEAT x",
                  "presentation": 1,
                  "presentation_rect": [
                    234.0,
                    481.0,
                    112.0,
                    17.0
                  ]
                }
              },
              {
                "box": {
                  "id": "voice-signal",
                  "maxclass": "inlet",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "patching_rect": [
                    60.0,
                    20.0,
                    25.0,
                    25.0
                  ],
                  "index": 2,
                  "outlettype": [
                    "signal"
                  ]
                }
              },
              {
                "box": {
                  "id": "voice-scope",
                  "maxclass": "live.scope~",
                  "numinlets": 2,
                  "numoutlets": 0,
                  "patching_rect": [
                    1020.0,
                    1405.0,
                    185.0,
                    22.0
                  ],
                  "active": 1,
                  "mode": 0,
                  "samples": 264600.0,
                  "interval": 40.0,
                  "range": [
                    -1.0,
                    1.0
                  ],
                  "smooth": 0,
                  "decay_time": 0.0,
                  "grid": 0,
                  "line_width": 1.0,
                  "rounded": 5.0,
                  "bgcolor": [
                    0.094,
                    0.118,
                    0.157,
                    1.0
                  ],
                  "activebgcolor": [
                    0.094,
                    0.118,
                    0.157,
                    1.0
                  ],
                  "linecolor": [
                    0.29,
                    0.79,
                    0.91,
                    1.0
                  ],
                  "activelinecolor": [
                    0.29,
                    0.79,
                    0.91,
                    1.0
                  ],
                  "parameter_enable": 0,
                  "ignoreclick": 1,
                  "presentation": 1,
                  "presentation_rect": [
                    16.0,
                    173.0,
                    568.0,
                    53.0
                  ]
                }
              },
              {
                "box": {
                  "id": "voice-gain",
                  "maxclass": "flonum",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "patching_rect": [
                    20.0,
                    1450.0,
                    185.0,
                    22.0
                  ],
                  "minimum": 1.0,
                  "maximum": 8.0,
                  "bgcolor": [
                    0.094,
                    0.118,
                    0.157,
                    1.0
                  ],
                  "textcolor": [
                    0.91,
                    0.94,
                    0.98,
                    1.0
                  ],
                  "parameter_enable": 1,
                  "triangle": 0,
                  "format": 6,
                  "presentation": 1,
                  "presentation_rect": [
                    148.0,
                    477.0,
                    60.0,
                    25.0
                  ],
                  "fontsize": 11.0,
                  "parameter_mappable": 0,
                  "varname": "vtm_voice_gain",
                  "saved_attribute_attributes": {
                    "valueof": {
                      "parameter_longname": "VTM Voice zoom",
                      "parameter_shortname": "VTM Voice zoom",
                      "parameter_type": 0,
                      "parameter_invisible": 1,
                      "parameter_initial_enable": 1,
                      "parameter_initial": [
                        1.0
                      ],
                      "parameter_order": 5,
                      "parameter_mmin": 1.0,
                      "parameter_mmax": 8.0
                    }
                  }
                }
              },
              {
                "box": {
                  "id": "voice-magnify",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    1450.0,
                    185.0,
                    22.0
                  ],
                  "outlettype": [
                    "signal"
                  ],
                  "text": "*~ 1."
                }
              },
              {
                "box": {
                  "id": "voice-initial-gain",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    1450.0,
                    185.0,
                    22.0
                  ],
                  "text": "bang"
                }
              },
              {
                "box": {
                  "id": "grid-signal",
                  "maxclass": "inlet",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "patching_rect": [
                    140.0,
                    20.0,
                    25.0,
                    25.0
                  ],
                  "index": 4,
                  "outlettype": [
                    "signal"
                  ]
                }
              },
              {
                "box": {
                  "id": "grid-scope",
                  "maxclass": "live.scope~",
                  "numinlets": 2,
                  "numoutlets": 0,
                  "patching_rect": [
                    620.0,
                    1450.0,
                    185.0,
                    22.0
                  ],
                  "active": 1,
                  "mode": 0,
                  "samples": 264600.0,
                  "interval": 40.0,
                  "range": [
                    0.0,
                    1.15
                  ],
                  "smooth": 0,
                  "decay_time": 0.0,
                  "grid": 0,
                  "line_width": 1.0,
                  "rounded": 5.0,
                  "bgcolor": [
                    0.094,
                    0.118,
                    0.157,
                    1.0
                  ],
                  "activebgcolor": [
                    0.094,
                    0.118,
                    0.157,
                    1.0
                  ],
                  "linecolor": [
                    1.0,
                    0.73,
                    0.3,
                    1.0
                  ],
                  "activelinecolor": [
                    1.0,
                    0.73,
                    0.3,
                    1.0
                  ],
                  "parameter_enable": 0,
                  "ignoreclick": 1,
                  "presentation": 1,
                  "presentation_rect": [
                    16.0,
                    230.0,
                    568.0,
                    14.0
                  ],
                  "hint": "Reperele grilei Live, pe aceeasi axa de 6 secunde."
                }
              },
              {
                "box": {
                  "id": "beat-signal",
                  "maxclass": "inlet",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "patching_rect": [
                    100.0,
                    20.0,
                    25.0,
                    25.0
                  ],
                  "index": 3,
                  "outlettype": [
                    "signal"
                  ]
                }
              },
              {
                "box": {
                  "id": "beat-scope",
                  "maxclass": "live.scope~",
                  "numinlets": 2,
                  "numoutlets": 0,
                  "patching_rect": [
                    820.0,
                    1450.0,
                    185.0,
                    22.0
                  ],
                  "active": 1,
                  "mode": 0,
                  "samples": 264600.0,
                  "interval": 40.0,
                  "range": [
                    -1.0,
                    1.0
                  ],
                  "smooth": 0,
                  "decay_time": 0.0,
                  "grid": 0,
                  "line_width": 1.0,
                  "rounded": 5.0,
                  "bgcolor": [
                    0.094,
                    0.118,
                    0.157,
                    1.0
                  ],
                  "activebgcolor": [
                    0.094,
                    0.118,
                    0.157,
                    1.0
                  ],
                  "linecolor": [
                    0.35,
                    0.84,
                    0.64,
                    1.0
                  ],
                  "activelinecolor": [
                    0.35,
                    0.84,
                    0.64,
                    1.0
                  ],
                  "parameter_enable": 0,
                  "ignoreclick": 1,
                  "presentation": 1,
                  "presentation_rect": [
                    16.0,
                    269.0,
                    568.0,
                    49.0
                  ]
                }
              },
              {
                "box": {
                  "id": "beat-gain",
                  "maxclass": "flonum",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "patching_rect": [
                    1020.0,
                    1450.0,
                    185.0,
                    22.0
                  ],
                  "minimum": 1.0,
                  "maximum": 8.0,
                  "bgcolor": [
                    0.094,
                    0.118,
                    0.157,
                    1.0
                  ],
                  "textcolor": [
                    0.91,
                    0.94,
                    0.98,
                    1.0
                  ],
                  "parameter_enable": 1,
                  "triangle": 0,
                  "format": 6,
                  "presentation": 1,
                  "presentation_rect": [
                    350.0,
                    477.0,
                    60.0,
                    25.0
                  ],
                  "fontsize": 11.0,
                  "parameter_mappable": 0,
                  "varname": "vtm_beat_gain",
                  "saved_attribute_attributes": {
                    "valueof": {
                      "parameter_longname": "VTM Beat zoom",
                      "parameter_shortname": "VTM Beat zoom",
                      "parameter_type": 0,
                      "parameter_invisible": 1,
                      "parameter_initial_enable": 1,
                      "parameter_initial": [
                        1.0
                      ],
                      "parameter_order": 6,
                      "parameter_mmin": 1.0,
                      "parameter_mmax": 8.0
                    }
                  }
                }
              },
              {
                "box": {
                  "id": "beat-magnify",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    1495.0,
                    185.0,
                    22.0
                  ],
                  "outlettype": [
                    "signal"
                  ],
                  "text": "*~ 1."
                }
              },
              {
                "box": {
                  "id": "beat-initial-gain",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    1495.0,
                    185.0,
                    22.0
                  ],
                  "text": "bang"
                }
              },
              {
                "box": {
                  "id": "wave-samples-message",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    1495.0,
                    185.0,
                    22.0
                  ],
                  "text": "prepend samples"
                }
              },
              {
                "box": {
                  "id": "time-old",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    620.0,
                    1495.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 9.0,
                  "textcolor": [
                    0.59,
                    0.67,
                    0.77,
                    1.0
                  ],
                  "text": "-6 s",
                  "presentation": 1,
                  "presentation_rect": [
                    16.0,
                    320.0,
                    60.0,
                    14.0
                  ]
                }
              },
              {
                "box": {
                  "id": "time-mid",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    820.0,
                    1495.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 9.0,
                  "textcolor": [
                    0.59,
                    0.67,
                    0.77,
                    1.0
                  ],
                  "text": "-3 s",
                  "presentation": 1,
                  "presentation_rect": [
                    285.0,
                    320.0,
                    60.0,
                    14.0
                  ]
                }
              },
              {
                "box": {
                  "id": "time-now",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    1020.0,
                    1495.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 9.0,
                  "textcolor": [
                    0.59,
                    0.67,
                    0.77,
                    1.0
                  ],
                  "text": "ACUM",
                  "presentation": 1,
                  "presentation_rect": [
                    538.0,
                    320.0,
                    46.0,
                    14.0
                  ]
                }
              },
              {
                "box": {
                  "id": "beat-source-caption",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    20.0,
                    1540.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 11.0,
                  "textcolor": [
                    0.59,
                    0.67,
                    0.77,
                    1.0
                  ],
                  "text": "SURSA INSTRUMENTALULUI",
                  "presentation": 1,
                  "presentation_rect": [
                    24.0,
                    357.0,
                    400.0,
                    17.0
                  ]
                }
              },
              {
                "box": {
                  "id": "beat-type",
                  "maxclass": "umenu",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "patching_rect": [
                    220.0,
                    1540.0,
                    185.0,
                    22.0
                  ],
                  "items": [
                    "(alege sursa)"
                  ],
                  "parameter_enable": 0,
                  "bgcolor": [
                    0.094,
                    0.118,
                    0.157,
                    1.0
                  ],
                  "textcolor": [
                    0.91,
                    0.94,
                    0.98,
                    1.0
                  ],
                  "presentation": 1,
                  "presentation_rect": [
                    24.0,
                    379.0,
                    304.0,
                    26.0
                  ],
                  "fontsize": 11.0
                }
              },
              {
                "box": {
                  "id": "beat-type-selected-index",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    1540.0,
                    185.0,
                    22.0
                  ],
                  "text": "i 0"
                }
              },
              {
                "box": {
                  "id": "beat-type-select",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    620.0,
                    1540.0,
                    185.0,
                    22.0
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "beat-type-list",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "patching_rect": [
                    820.0,
                    1540.0,
                    185.0,
                    22.0
                  ],
                  "text": "t l clear"
                }
              },
              {
                "box": {
                  "id": "beat-type-iter",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    1540.0,
                    185.0,
                    22.0
                  ],
                  "text": "iter"
                }
              },
              {
                "box": {
                  "id": "beat-type-append",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    1585.0,
                    185.0,
                    22.0
                  ],
                  "text": "prepend append"
                }
              },
              {
                "box": {
                  "id": "beat-type-reselect",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    1585.0,
                    185.0,
                    22.0
                  ],
                  "text": "t b"
                }
              },
              {
                "box": {
                  "id": "beat-type-command",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    1585.0,
                    185.0,
                    22.0
                  ],
                  "text": "prepend beat_type"
                }
              },
              {
                "box": {
                  "id": "beat-channel",
                  "maxclass": "umenu",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "patching_rect": [
                    620.0,
                    1585.0,
                    185.0,
                    22.0
                  ],
                  "items": [
                    "(alege sursa)"
                  ],
                  "parameter_enable": 0,
                  "bgcolor": [
                    0.094,
                    0.118,
                    0.157,
                    1.0
                  ],
                  "textcolor": [
                    0.91,
                    0.94,
                    0.98,
                    1.0
                  ],
                  "presentation": 1,
                  "presentation_rect": [
                    338.0,
                    379.0,
                    154.0,
                    26.0
                  ],
                  "fontsize": 11.0
                }
              },
              {
                "box": {
                  "id": "beat-channel-selected-index",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    1585.0,
                    185.0,
                    22.0
                  ],
                  "text": "i 0"
                }
              },
              {
                "box": {
                  "id": "beat-channel-select",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    1585.0,
                    185.0,
                    22.0
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "beat-channel-list",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "patching_rect": [
                    20.0,
                    1630.0,
                    185.0,
                    22.0
                  ],
                  "text": "t l clear"
                }
              },
              {
                "box": {
                  "id": "beat-channel-iter",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    1630.0,
                    185.0,
                    22.0
                  ],
                  "text": "iter"
                }
              },
              {
                "box": {
                  "id": "beat-channel-append",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    1630.0,
                    185.0,
                    22.0
                  ],
                  "text": "prepend append"
                }
              },
              {
                "box": {
                  "id": "beat-channel-reselect",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    620.0,
                    1630.0,
                    185.0,
                    22.0
                  ],
                  "text": "t b"
                }
              },
              {
                "box": {
                  "id": "beat-channel-command",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    1630.0,
                    185.0,
                    22.0
                  ],
                  "text": "prepend beat_channel"
                }
              },
              {
                "box": {
                  "id": "beat-refresh",
                  "maxclass": "textbutton",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "patching_rect": [
                    1020.0,
                    1630.0,
                    185.0,
                    22.0
                  ],
                  "texton": "REFRESH",
                  "mode": 1,
                  "parameter_enable": 0,
                  "rounded": 7.0,
                  "fontsize": 10.0,
                  "fontface": 1,
                  "textcolor": [
                    0.91,
                    0.94,
                    0.98,
                    1.0
                  ],
                  "textoncolor": [
                    0.91,
                    0.94,
                    0.98,
                    1.0
                  ],
                  "bgcolor": [
                    0.12,
                    0.17,
                    0.22,
                    1.0
                  ],
                  "bgoncolor": [
                    0.12,
                    0.17,
                    0.22,
                    1.0
                  ],
                  "usegradient": 0,
                  "usebgoncolor": 1,
                  "outputmode": 1,
                  "text": "REFRESH",
                  "presentation": 1,
                  "presentation_rect": [
                    502.0,
                    379.0,
                    74.0,
                    26.0
                  ]
                }
              },
              {
                "box": {
                  "id": "beat-refresh-bang",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    1675.0,
                    185.0,
                    22.0
                  ],
                  "text": "t b"
                }
              },
              {
                "box": {
                  "id": "beat-refresh-command",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    1675.0,
                    185.0,
                    22.0
                  ],
                  "text": "beat_refresh"
                }
              },
              {
                "box": {
                  "id": "wave-hint",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    420.0,
                    1675.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 9.0,
                  "textcolor": [
                    0.59,
                    0.67,
                    0.77,
                    1.0
                  ],
                  "text": "Marirea vizuala nu schimba sunetul sau detectia.",
                  "presentation": 1,
                  "presentation_rect": [
                    176.0,
                    542.0,
                    400.0,
                    17.0
                  ]
                }
              },
              {
                "box": {
                  "id": "beat-level-floor",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    620.0,
                    1675.0,
                    185.0,
                    22.0
                  ],
                  "text": "maximum 0.00001"
                }
              },
              {
                "box": {
                  "id": "beat-level-db",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    1675.0,
                    185.0,
                    22.0
                  ],
                  "text": "expr 20. * log10($f1)"
                }
              },
              {
                "box": {
                  "id": "beat-level-format",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    1675.0,
                    185.0,
                    22.0
                  ],
                  "text": "sprintf Beat: %.1f dB"
                }
              },
              {
                "box": {
                  "id": "beat-level-set",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    1720.0,
                    185.0,
                    22.0
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "settings-card",
                  "maxclass": "panel",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    220.0,
                    1720.0,
                    185.0,
                    22.0
                  ],
                  "bgcolor": [
                    0.094,
                    0.118,
                    0.157,
                    1.0
                  ],
                  "border": 0,
                  "rounded": 12,
                  "background": 1,
                  "ignoreclick": 1,
                  "presentation": 1,
                  "presentation_rect": [
                    12.0,
                    350.0,
                    576.0,
                    258.0
                  ]
                }
              },
              {
                "box": {
                  "id": "settings",
                  "maxclass": "textbutton",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "patching_rect": [
                    420.0,
                    1720.0,
                    185.0,
                    22.0
                  ],
                  "texton": "ASCUNDE",
                  "mode": 1,
                  "parameter_enable": 0,
                  "rounded": 7.0,
                  "fontsize": 12.0,
                  "fontface": 1,
                  "textcolor": [
                    0.91,
                    0.94,
                    0.98,
                    1.0
                  ],
                  "textoncolor": [
                    0.91,
                    0.94,
                    0.98,
                    1.0
                  ],
                  "bgcolor": [
                    0.12,
                    0.17,
                    0.22,
                    1.0
                  ],
                  "bgoncolor": [
                    0.1,
                    0.31,
                    0.38,
                    1.0
                  ],
                  "usegradient": 0,
                  "usebgoncolor": 1,
                  "outputmode": 1,
                  "text": "SETARI",
                  "presentation": 1,
                  "presentation_rect": [
                    490.0,
                    10.0,
                    94.0,
                    26.0
                  ]
                }
              },
              {
                "box": {
                  "id": "settings-trigger",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "patching_rect": [
                    620.0,
                    1720.0,
                    185.0,
                    22.0
                  ],
                  "text": "t b i"
                }
              },
              {
                "box": {
                  "id": "settings-height",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    1720.0,
                    185.0,
                    22.0
                  ],
                  "text": "expr 340 + 280 * $i1"
                }
              },
              {
                "box": {
                  "id": "settings-query",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    1720.0,
                    185.0,
                    22.0
                  ],
                  "text": "window getsize"
                }
              },
              {
                "box": {
                  "id": "window-route",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "patching_rect": [
                    20.0,
                    1765.0,
                    185.0,
                    22.0
                  ],
                  "text": "route window"
                }
              },
              {
                "box": {
                  "id": "window-size-route",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "patching_rect": [
                    220.0,
                    1765.0,
                    185.0,
                    22.0
                  ],
                  "text": "route size"
                }
              },
              {
                "box": {
                  "id": "window-unpack",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 4,
                  "patching_rect": [
                    420.0,
                    1765.0,
                    185.0,
                    22.0
                  ],
                  "text": "unpack 0 0 0 0"
                }
              },
              {
                "box": {
                  "id": "window-left",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "patching_rect": [
                    620.0,
                    1765.0,
                    185.0,
                    22.0
                  ],
                  "text": "t i i"
                }
              },
              {
                "box": {
                  "id": "window-right",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    1765.0,
                    185.0,
                    22.0
                  ],
                  "text": "+ 600"
                }
              },
              {
                "box": {
                  "id": "window-bottom",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    1765.0,
                    185.0,
                    22.0
                  ],
                  "text": "+ 340"
                }
              },
              {
                "box": {
                  "id": "window-pack",
                  "maxclass": "newobj",
                  "numinlets": 4,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    1810.0,
                    185.0,
                    22.0
                  ],
                  "text": "pack 0 0 0 0"
                }
              },
              {
                "box": {
                  "id": "window-resize",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    1810.0,
                    185.0,
                    22.0
                  ],
                  "text": "window size $1 $2 $3 $4, window exec"
                }
              },
              {
                "box": {
                  "id": "enabled-replay",
                  "maxclass": "newobj",
                  "numinlets": 3,
                  "numoutlets": 3,
                  "patching_rect": [
                    420.0,
                    1810.0,
                    185.0,
                    22.0
                  ],
                  "saved_object_attributes": {
                    "parameter_enable": 0
                  },
                  "text": "pattr @bindto vtm_enabled @thru 0 @autorestore 0"
                }
              },
              {
                "box": {
                  "id": "persist-reset",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "patching_rect": [
                    620.0,
                    1810.0,
                    185.0,
                    22.0
                  ],
                  "text": "t b b"
                }
              },
              {
                "box": {
                  "id": "persist-restore-on",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    1810.0,
                    185.0,
                    22.0
                  ],
                  "text": "1"
                }
              },
              {
                "box": {
                  "id": "persist-capture-off",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    1810.0,
                    185.0,
                    22.0
                  ],
                  "text": "0"
                }
              },
              {
                "box": {
                  "id": "persist-retry",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    1855.0,
                    185.0,
                    22.0
                  ],
                  "text": "set -1"
                }
              },
              {
                "box": {
                  "id": "persist-manual",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "patching_rect": [
                    220.0,
                    1855.0,
                    185.0,
                    22.0
                  ],
                  "text": "t b b"
                }
              },
              {
                "box": {
                  "id": "persist-restore-off",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    1855.0,
                    185.0,
                    22.0
                  ],
                  "text": "0"
                }
              },
              {
                "box": {
                  "id": "persist-capture-on",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    620.0,
                    1855.0,
                    185.0,
                    22.0
                  ],
                  "text": "1"
                }
              },
              {
                "box": {
                  "id": "persist-type",
                  "maxclass": "newobj",
                  "numinlets": 3,
                  "numoutlets": 3,
                  "patching_rect": [
                    820.0,
                    1855.0,
                    185.0,
                    22.0
                  ],
                  "saved_object_attributes": {
                    "parameter_enable": 1,
                    "parameter_mappable": 0
                  },
                  "restore": [
                    "__vtm_unset__"
                  ],
                  "varname": "vtm_saved_beat_type",
                  "saved_attribute_attributes": {
                    "valueof": {
                      "parameter_longname": "VTM Instrumental type",
                      "parameter_shortname": "VTM Instrumental type",
                      "parameter_type": 3,
                      "parameter_invisible": 1,
                      "parameter_order": 10,
                      "parameter_linknames": 0
                    }
                  },
                  "text": "pattr vtm_beat_type @thru 0 @autorestore 0"
                }
              },
              {
                "box": {
                  "id": "persist-type-capture",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    1855.0,
                    185.0,
                    22.0
                  ],
                  "text": "gate 1 0"
                }
              },
              {
                "box": {
                  "id": "persist-type-index-map",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 4,
                  "patching_rect": [
                    20.0,
                    1900.0,
                    185.0,
                    22.0
                  ],
                  "text": "coll @embed 0"
                }
              },
              {
                "box": {
                  "id": "persist-type-manual",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "patching_rect": [
                    220.0,
                    1900.0,
                    185.0,
                    22.0
                  ],
                  "text": "t i b"
                }
              },
              {
                "box": {
                  "id": "persist-type-list",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "patching_rect": [
                    420.0,
                    1900.0,
                    185.0,
                    22.0
                  ],
                  "text": "t b l b"
                }
              },
              {
                "box": {
                  "id": "persist-type-map",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 4,
                  "patching_rect": [
                    620.0,
                    1900.0,
                    185.0,
                    22.0
                  ],
                  "text": "coll @embed 0"
                }
              },
              {
                "box": {
                  "id": "persist-type-clear",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    1900.0,
                    185.0,
                    22.0
                  ],
                  "text": "clear"
                }
              },
              {
                "box": {
                  "id": "persist-type-zero",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    1900.0,
                    185.0,
                    22.0
                  ],
                  "text": "set 0"
                }
              },
              {
                "box": {
                  "id": "persist-type-iter",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    1945.0,
                    185.0,
                    22.0
                  ],
                  "text": "iter"
                }
              },
              {
                "box": {
                  "id": "persist-type-list-key",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    1945.0,
                    185.0,
                    22.0
                  ],
                  "text": "prepend vtm"
                }
              },
              {
                "box": {
                  "id": "persist-type-list-symbol",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    1945.0,
                    185.0,
                    22.0
                  ],
                  "text": "tosymbol"
                }
              },
              {
                "box": {
                  "id": "persist-type-entry",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "patching_rect": [
                    620.0,
                    1945.0,
                    185.0,
                    22.0
                  ],
                  "text": "t s b"
                }
              },
              {
                "box": {
                  "id": "persist-type-index",
                  "maxclass": "newobj",
                  "numinlets": 5,
                  "numoutlets": 4,
                  "patching_rect": [
                    820.0,
                    1945.0,
                    185.0,
                    22.0
                  ],
                  "text": "counter 0 1000000000"
                }
              },
              {
                "box": {
                  "id": "persist-type-pair",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    1945.0,
                    185.0,
                    22.0
                  ],
                  "text": "pack s 0"
                }
              },
              {
                "box": {
                  "id": "persist-type-store",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    1990.0,
                    185.0,
                    22.0
                  ],
                  "text": "prepend store"
                }
              },
              {
                "box": {
                  "id": "persist-type-reverse",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "patching_rect": [
                    220.0,
                    1990.0,
                    185.0,
                    22.0
                  ],
                  "text": "zl rev"
                }
              },
              {
                "box": {
                  "id": "persist-type-defer",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    1990.0,
                    185.0,
                    22.0
                  ],
                  "text": "deferlow"
                }
              },
              {
                "box": {
                  "id": "persist-type-restore",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    620.0,
                    1990.0,
                    185.0,
                    22.0
                  ],
                  "text": "gate 1 1"
                }
              },
              {
                "box": {
                  "id": "persist-type-change",
                  "maxclass": "newobj",
                  "numinlets": 3,
                  "numoutlets": 3,
                  "patching_rect": [
                    820.0,
                    1990.0,
                    185.0,
                    22.0
                  ],
                  "text": "change -1"
                }
              },
              {
                "box": {
                  "id": "persist-type-apply",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "patching_rect": [
                    1020.0,
                    1990.0,
                    185.0,
                    22.0
                  ],
                  "text": "t i b"
                }
              },
              {
                "box": {
                  "id": "persist-channel-retry",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    2035.0,
                    185.0,
                    22.0
                  ],
                  "text": "set -1"
                }
              },
              {
                "box": {
                  "id": "persist-channel",
                  "maxclass": "newobj",
                  "numinlets": 3,
                  "numoutlets": 3,
                  "patching_rect": [
                    220.0,
                    2035.0,
                    185.0,
                    22.0
                  ],
                  "saved_object_attributes": {
                    "parameter_enable": 1,
                    "parameter_mappable": 0
                  },
                  "restore": [
                    "__vtm_unset__"
                  ],
                  "varname": "vtm_saved_beat_channel",
                  "saved_attribute_attributes": {
                    "valueof": {
                      "parameter_longname": "VTM Instrumental channel",
                      "parameter_shortname": "VTM Instrumental channel",
                      "parameter_type": 3,
                      "parameter_invisible": 1,
                      "parameter_order": 11,
                      "parameter_linknames": 0
                    }
                  },
                  "text": "pattr vtm_beat_channel @thru 0 @autorestore 0"
                }
              },
              {
                "box": {
                  "id": "persist-channel-capture",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    2035.0,
                    185.0,
                    22.0
                  ],
                  "text": "gate 1 0"
                }
              },
              {
                "box": {
                  "id": "persist-channel-index-map",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 4,
                  "patching_rect": [
                    620.0,
                    2035.0,
                    185.0,
                    22.0
                  ],
                  "text": "coll @embed 0"
                }
              },
              {
                "box": {
                  "id": "persist-channel-manual",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "patching_rect": [
                    820.0,
                    2035.0,
                    185.0,
                    22.0
                  ],
                  "text": "t i b"
                }
              },
              {
                "box": {
                  "id": "persist-channel-list",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "patching_rect": [
                    1020.0,
                    2035.0,
                    185.0,
                    22.0
                  ],
                  "text": "t b l b"
                }
              },
              {
                "box": {
                  "id": "persist-channel-map",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 4,
                  "patching_rect": [
                    20.0,
                    2080.0,
                    185.0,
                    22.0
                  ],
                  "text": "coll @embed 0"
                }
              },
              {
                "box": {
                  "id": "persist-channel-clear",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    2080.0,
                    185.0,
                    22.0
                  ],
                  "text": "clear"
                }
              },
              {
                "box": {
                  "id": "persist-channel-zero",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    2080.0,
                    185.0,
                    22.0
                  ],
                  "text": "set 0"
                }
              },
              {
                "box": {
                  "id": "persist-channel-iter",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    620.0,
                    2080.0,
                    185.0,
                    22.0
                  ],
                  "text": "iter"
                }
              },
              {
                "box": {
                  "id": "persist-channel-list-key",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    2080.0,
                    185.0,
                    22.0
                  ],
                  "text": "prepend vtm"
                }
              },
              {
                "box": {
                  "id": "persist-channel-list-symbol",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    2080.0,
                    185.0,
                    22.0
                  ],
                  "text": "tosymbol"
                }
              },
              {
                "box": {
                  "id": "persist-channel-entry",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "patching_rect": [
                    20.0,
                    2125.0,
                    185.0,
                    22.0
                  ],
                  "text": "t s b"
                }
              },
              {
                "box": {
                  "id": "persist-channel-index",
                  "maxclass": "newobj",
                  "numinlets": 5,
                  "numoutlets": 4,
                  "patching_rect": [
                    220.0,
                    2125.0,
                    185.0,
                    22.0
                  ],
                  "text": "counter 0 1000000000"
                }
              },
              {
                "box": {
                  "id": "persist-channel-pair",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    2125.0,
                    185.0,
                    22.0
                  ],
                  "text": "pack s 0"
                }
              },
              {
                "box": {
                  "id": "persist-channel-store",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    620.0,
                    2125.0,
                    185.0,
                    22.0
                  ],
                  "text": "prepend store"
                }
              },
              {
                "box": {
                  "id": "persist-channel-reverse",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "patching_rect": [
                    820.0,
                    2125.0,
                    185.0,
                    22.0
                  ],
                  "text": "zl rev"
                }
              },
              {
                "box": {
                  "id": "persist-channel-defer",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    2125.0,
                    185.0,
                    22.0
                  ],
                  "text": "deferlow"
                }
              },
              {
                "box": {
                  "id": "persist-channel-restore",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    2170.0,
                    185.0,
                    22.0
                  ],
                  "text": "gate 1 1"
                }
              },
              {
                "box": {
                  "id": "persist-channel-change",
                  "maxclass": "newobj",
                  "numinlets": 3,
                  "numoutlets": 3,
                  "patching_rect": [
                    220.0,
                    2170.0,
                    185.0,
                    22.0
                  ],
                  "text": "change -1"
                }
              }
            ],
            "lines": [
              {
                "patchline": {
                  "source": [
                    "in",
                    0
                  ],
                  "destination": [
                    "route",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "load",
                    0
                  ],
                  "destination": [
                    "window-config",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "window-config",
                    0
                  ],
                  "destination": [
                    "window",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "grid-ui",
                    0
                  ],
                  "destination": [
                    "grid-map",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "grid-map",
                    0
                  ],
                  "destination": [
                    "grid-tag",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "grid-tag",
                    0
                  ],
                  "destination": [
                    "out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "redms",
                    0
                  ],
                  "destination": [
                    "redms-tag",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "redms-tag",
                    0
                  ],
                  "destination": [
                    "out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "offsetms",
                    0
                  ],
                  "destination": [
                    "offsetms-tag",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "offsetms-tag",
                    0
                  ],
                  "destination": [
                    "out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "gatedb",
                    0
                  ],
                  "destination": [
                    "gatedb-tag",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "gatedb-tag",
                    0
                  ],
                  "destination": [
                    "out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "route",
                    0
                  ],
                  "destination": [
                    "state-select",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "state-select",
                    0
                  ],
                  "destination": [
                    "status-0",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "state-select",
                    0
                  ],
                  "destination": [
                    "color-0",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "status-0",
                    0
                  ],
                  "destination": [
                    "state-text",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "color-0",
                    0
                  ],
                  "destination": [
                    "state-text",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "color-0",
                    0
                  ],
                  "destination": [
                    "delta-text",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "state-select",
                    1
                  ],
                  "destination": [
                    "status-1",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "state-select",
                    1
                  ],
                  "destination": [
                    "color-1",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "status-1",
                    0
                  ],
                  "destination": [
                    "state-text",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "color-1",
                    0
                  ],
                  "destination": [
                    "state-text",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "color-1",
                    0
                  ],
                  "destination": [
                    "delta-text",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "state-select",
                    2
                  ],
                  "destination": [
                    "status-2",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "state-select",
                    2
                  ],
                  "destination": [
                    "color-2",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "status-2",
                    0
                  ],
                  "destination": [
                    "state-text",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "color-2",
                    0
                  ],
                  "destination": [
                    "state-text",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "color-2",
                    0
                  ],
                  "destination": [
                    "delta-text",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "state-select",
                    3
                  ],
                  "destination": [
                    "status-3",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "state-select",
                    3
                  ],
                  "destination": [
                    "color-3",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "status-3",
                    0
                  ],
                  "destination": [
                    "state-text",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "color-3",
                    0
                  ],
                  "destination": [
                    "state-text",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "color-3",
                    0
                  ],
                  "destination": [
                    "delta-text",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "state-select",
                    4
                  ],
                  "destination": [
                    "status-4",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "state-select",
                    4
                  ],
                  "destination": [
                    "color-4",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "status-4",
                    0
                  ],
                  "destination": [
                    "state-text",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "color-4",
                    0
                  ],
                  "destination": [
                    "state-text",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "color-4",
                    0
                  ],
                  "destination": [
                    "delta-text",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "state-select",
                    5
                  ],
                  "destination": [
                    "status-5",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "state-select",
                    5
                  ],
                  "destination": [
                    "color-5",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "status-5",
                    0
                  ],
                  "destination": [
                    "state-text",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "color-5",
                    0
                  ],
                  "destination": [
                    "state-text",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "color-5",
                    0
                  ],
                  "destination": [
                    "delta-text",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "state-select",
                    6
                  ],
                  "destination": [
                    "status-6",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "state-select",
                    6
                  ],
                  "destination": [
                    "color-6",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "status-6",
                    0
                  ],
                  "destination": [
                    "state-text",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "color-6",
                    0
                  ],
                  "destination": [
                    "state-text",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "color-6",
                    0
                  ],
                  "destination": [
                    "delta-text",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "state-select",
                    7
                  ],
                  "destination": [
                    "status-7",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "state-select",
                    7
                  ],
                  "destination": [
                    "color-7",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "status-7",
                    0
                  ],
                  "destination": [
                    "state-text",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "color-7",
                    0
                  ],
                  "destination": [
                    "state-text",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "color-7",
                    0
                  ],
                  "destination": [
                    "delta-text",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "state-select",
                    8
                  ],
                  "destination": [
                    "status-8",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "state-select",
                    8
                  ],
                  "destination": [
                    "color-8",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "status-8",
                    0
                  ],
                  "destination": [
                    "state-text",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "color-8",
                    0
                  ],
                  "destination": [
                    "state-text",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "color-8",
                    0
                  ],
                  "destination": [
                    "delta-text",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "state-select",
                    9
                  ],
                  "destination": [
                    "status-9",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "state-select",
                    9
                  ],
                  "destination": [
                    "color-9",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "status-9",
                    0
                  ],
                  "destination": [
                    "state-text",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "color-9",
                    0
                  ],
                  "destination": [
                    "state-text",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "color-9",
                    0
                  ],
                  "destination": [
                    "delta-text",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "state-select",
                    10
                  ],
                  "destination": [
                    "status-10",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "state-select",
                    10
                  ],
                  "destination": [
                    "color-10",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "status-10",
                    0
                  ],
                  "destination": [
                    "state-text",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "color-10",
                    0
                  ],
                  "destination": [
                    "state-text",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "color-10",
                    0
                  ],
                  "destination": [
                    "delta-text",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "route",
                    11
                  ],
                  "destination": [
                    "delta-gate",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "route",
                    1
                  ],
                  "destination": [
                    "delta-gate",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "delta-gate",
                    0
                  ],
                  "destination": [
                    "delta-format",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "delta-format",
                    0
                  ],
                  "destination": [
                    "delta-set",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "delta-set",
                    0
                  ],
                  "destination": [
                    "delta-text",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "route",
                    11
                  ],
                  "destination": [
                    "hasdelta-select",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "hasdelta-select",
                    0
                  ],
                  "destination": [
                    "no-delta",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "no-delta",
                    0
                  ],
                  "destination": [
                    "delta-text",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "route",
                    2
                  ],
                  "destination": [
                    "count-format",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "count-format",
                    0
                  ],
                  "destination": [
                    "count-set",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "count-set",
                    0
                  ],
                  "destination": [
                    "count-text",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "route",
                    4
                  ],
                  "destination": [
                    "tests-format",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "tests-format",
                    0
                  ],
                  "destination": [
                    "tests-set",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "tests-set",
                    0
                  ],
                  "destination": [
                    "tests-text",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "route",
                    3
                  ],
                  "destination": [
                    "level-floor",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "level-floor",
                    0
                  ],
                  "destination": [
                    "level-db",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "level-db",
                    0
                  ],
                  "destination": [
                    "level-format",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "level-format",
                    0
                  ],
                  "destination": [
                    "level-set",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "level-set",
                    0
                  ],
                  "destination": [
                    "level-text",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "route",
                    7
                  ],
                  "destination": [
                    "maxdev-format",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "maxdev-format",
                    0
                  ],
                  "destination": [
                    "maxdev-set",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "maxdev-set",
                    0
                  ],
                  "destination": [
                    "limit-text",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "route",
                    6
                  ],
                  "destination": [
                    "sync-select",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sync-select",
                    0
                  ],
                  "destination": [
                    "sync-0",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sync-0",
                    0
                  ],
                  "destination": [
                    "clock-text",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sync-select",
                    1
                  ],
                  "destination": [
                    "sync-1",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "sync-1",
                    0
                  ],
                  "destination": [
                    "clock-text",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "route",
                    10
                  ],
                  "destination": [
                    "api-select",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "api-select",
                    0
                  ],
                  "destination": [
                    "api-0",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "api-0",
                    0
                  ],
                  "destination": [
                    "api-text",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "api-select",
                    1
                  ],
                  "destination": [
                    "api-1",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "api-1",
                    0
                  ],
                  "destination": [
                    "api-text",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "route",
                    12
                  ],
                  "destination": [
                    "stopnote-select",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "stopnote-select",
                    0
                  ],
                  "destination": [
                    "stopnote-0",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "stopnote-0",
                    0
                  ],
                  "destination": [
                    "api-text",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "stopnote-select",
                    1
                  ],
                  "destination": [
                    "stopnote-1",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "stopnote-1",
                    0
                  ],
                  "destination": [
                    "api-text",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "stopnote-select",
                    2
                  ],
                  "destination": [
                    "stopnote-3",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "stopnote-3",
                    0
                  ],
                  "destination": [
                    "api-text",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "stopnote-select",
                    3
                  ],
                  "destination": [
                    "stopnote-4",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "stopnote-4",
                    0
                  ],
                  "destination": [
                    "api-text",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "stopnote-select",
                    4
                  ],
                  "destination": [
                    "stopnote-5",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "stopnote-5",
                    0
                  ],
                  "destination": [
                    "api-text",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "stopnote-select",
                    5
                  ],
                  "destination": [
                    "stopnote-6",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "stopnote-6",
                    0
                  ],
                  "destination": [
                    "api-text",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "stopnote-select",
                    6
                  ],
                  "destination": [
                    "stopnote-7",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "stopnote-7",
                    0
                  ],
                  "destination": [
                    "api-text",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "stopnote-select",
                    7
                  ],
                  "destination": [
                    "stopnote-8",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "stopnote-8",
                    0
                  ],
                  "destination": [
                    "api-text",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "stopnote-select",
                    8
                  ],
                  "destination": [
                    "stopnote-9",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "stopnote-9",
                    0
                  ],
                  "destination": [
                    "api-text",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "stopnote-select",
                    9
                  ],
                  "destination": [
                    "stopnote-10",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "stopnote-10",
                    0
                  ],
                  "destination": [
                    "api-text",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "route",
                    5
                  ],
                  "destination": [
                    "raw-store",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "route",
                    2
                  ],
                  "destination": [
                    "cal-pak",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "grid-ui",
                    0
                  ],
                  "destination": [
                    "cal-pak",
                    1
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal-pak",
                    0
                  ],
                  "destination": [
                    "cal-unpack",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal-unpack",
                    0
                  ],
                  "destination": [
                    "cal-valid",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal-unpack",
                    1
                  ],
                  "destination": [
                    "cal-valid",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal-valid",
                    0
                  ],
                  "destination": [
                    "cal-gate",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal-valid",
                    0
                  ],
                  "destination": [
                    "cal-active",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal-active",
                    0
                  ],
                  "destination": [
                    "calibrate",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "calibrate",
                    0
                  ],
                  "destination": [
                    "cal-bang",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal-bang",
                    0
                  ],
                  "destination": [
                    "cal-gate",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "cal-gate",
                    0
                  ],
                  "destination": [
                    "raw-store",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "raw-store",
                    0
                  ],
                  "destination": [
                    "offsetms",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "enabled",
                    0
                  ],
                  "destination": [
                    "enabled-tag",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "enabled-tag",
                    0
                  ],
                  "destination": [
                    "out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "autostop",
                    0
                  ],
                  "destination": [
                    "autostop-tag",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "autostop-tag",
                    0
                  ],
                  "destination": [
                    "out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "test",
                    0
                  ],
                  "destination": [
                    "test-bang",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "test-bang",
                    0
                  ],
                  "destination": [
                    "test-counter",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "test-counter",
                    0
                  ],
                  "destination": [
                    "test-tag",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "test-tag",
                    0
                  ],
                  "destination": [
                    "out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "reset",
                    0
                  ],
                  "destination": [
                    "reset-bang",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "reset-bang",
                    0
                  ],
                  "destination": [
                    "reset-counter",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "reset-counter",
                    0
                  ],
                  "destination": [
                    "reset-tag",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "reset-tag",
                    0
                  ],
                  "destination": [
                    "out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "route",
                    8
                  ],
                  "destination": [
                    "off",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "off",
                    0
                  ],
                  "destination": [
                    "autostop",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "route",
                    9
                  ],
                  "destination": [
                    "initialize",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "initialize",
                    0
                  ],
                  "destination": [
                    "initial-0",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "initialize",
                    1
                  ],
                  "destination": [
                    "initial-1",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "initial-1",
                    0
                  ],
                  "destination": [
                    "autostop",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "initialize",
                    2
                  ],
                  "destination": [
                    "initial-2",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "initial-2",
                    0
                  ],
                  "destination": [
                    "grid-ui",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "initialize",
                    3
                  ],
                  "destination": [
                    "initial-3",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "initial-3",
                    0
                  ],
                  "destination": [
                    "redms",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "initialize",
                    4
                  ],
                  "destination": [
                    "initial-4",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "initial-4",
                    0
                  ],
                  "destination": [
                    "offsetms",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "initialize",
                    5
                  ],
                  "destination": [
                    "initial-5",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "initial-5",
                    0
                  ],
                  "destination": [
                    "gatedb",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "initialize",
                    6
                  ],
                  "destination": [
                    "initial-6",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "initial-6",
                    0
                  ],
                  "destination": [
                    "delta-text",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "voice-signal",
                    0
                  ],
                  "destination": [
                    "voice-magnify",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "voice-gain",
                    0
                  ],
                  "destination": [
                    "voice-magnify",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "voice-magnify",
                    0
                  ],
                  "destination": [
                    "voice-scope",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "grid-signal",
                    0
                  ],
                  "destination": [
                    "grid-scope",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "beat-signal",
                    0
                  ],
                  "destination": [
                    "beat-magnify",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "beat-gain",
                    0
                  ],
                  "destination": [
                    "beat-magnify",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "beat-magnify",
                    0
                  ],
                  "destination": [
                    "beat-scope",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "route",
                    17
                  ],
                  "destination": [
                    "wave-samples-message",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "wave-samples-message",
                    0
                  ],
                  "destination": [
                    "voice-scope",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "wave-samples-message",
                    0
                  ],
                  "destination": [
                    "beat-scope",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "wave-samples-message",
                    0
                  ],
                  "destination": [
                    "grid-scope",
                    0
                  ],
                  "order": 2
                }
              },
              {
                "patchline": {
                  "source": [
                    "route",
                    13
                  ],
                  "destination": [
                    "beat-type-selected-index",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "beat-type-selected-index",
                    0
                  ],
                  "destination": [
                    "beat-type-select",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "beat-type-select",
                    0
                  ],
                  "destination": [
                    "beat-type",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "route",
                    15
                  ],
                  "destination": [
                    "beat-type-list",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "beat-type-list",
                    1
                  ],
                  "destination": [
                    "beat-type",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "beat-type-list",
                    0
                  ],
                  "destination": [
                    "beat-type-iter",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "beat-type-iter",
                    0
                  ],
                  "destination": [
                    "beat-type-append",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "beat-type-append",
                    0
                  ],
                  "destination": [
                    "beat-type",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "beat-type-list",
                    0
                  ],
                  "destination": [
                    "beat-type-reselect",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "beat-type-reselect",
                    0
                  ],
                  "destination": [
                    "beat-type-selected-index",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "beat-type-command",
                    0
                  ],
                  "destination": [
                    "out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "route",
                    14
                  ],
                  "destination": [
                    "beat-channel-selected-index",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "beat-channel-selected-index",
                    0
                  ],
                  "destination": [
                    "beat-channel-select",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "beat-channel-select",
                    0
                  ],
                  "destination": [
                    "beat-channel",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "route",
                    16
                  ],
                  "destination": [
                    "beat-channel-list",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "beat-channel-list",
                    1
                  ],
                  "destination": [
                    "beat-channel",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "beat-channel-list",
                    0
                  ],
                  "destination": [
                    "beat-channel-iter",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "beat-channel-iter",
                    0
                  ],
                  "destination": [
                    "beat-channel-append",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "beat-channel-append",
                    0
                  ],
                  "destination": [
                    "beat-channel",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "beat-channel-list",
                    0
                  ],
                  "destination": [
                    "beat-channel-reselect",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "beat-channel-reselect",
                    0
                  ],
                  "destination": [
                    "beat-channel-selected-index",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "beat-channel-command",
                    0
                  ],
                  "destination": [
                    "out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "beat-refresh",
                    0
                  ],
                  "destination": [
                    "beat-refresh-bang",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "beat-refresh-bang",
                    0
                  ],
                  "destination": [
                    "beat-refresh-command",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "beat-refresh-command",
                    0
                  ],
                  "destination": [
                    "out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "route",
                    18
                  ],
                  "destination": [
                    "beat-level-floor",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "beat-level-floor",
                    0
                  ],
                  "destination": [
                    "beat-level-db",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "beat-level-db",
                    0
                  ],
                  "destination": [
                    "beat-level-format",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "beat-level-format",
                    0
                  ],
                  "destination": [
                    "beat-level-set",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "beat-level-set",
                    0
                  ],
                  "destination": [
                    "beat-level",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "settings",
                    0
                  ],
                  "destination": [
                    "settings-trigger",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "settings-trigger",
                    1
                  ],
                  "destination": [
                    "settings-height",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "settings-height",
                    0
                  ],
                  "destination": [
                    "window-bottom",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "settings-trigger",
                    0
                  ],
                  "destination": [
                    "settings-query",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "settings-query",
                    0
                  ],
                  "destination": [
                    "window",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "window",
                    0
                  ],
                  "destination": [
                    "window-route",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "window-route",
                    0
                  ],
                  "destination": [
                    "window-size-route",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "window-size-route",
                    0
                  ],
                  "destination": [
                    "window-unpack",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "window-unpack",
                    1
                  ],
                  "destination": [
                    "window-bottom",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "window-unpack",
                    1
                  ],
                  "destination": [
                    "window-pack",
                    1
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "window-bottom",
                    0
                  ],
                  "destination": [
                    "window-pack",
                    3
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "window-unpack",
                    0
                  ],
                  "destination": [
                    "window-left",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "window-left",
                    1
                  ],
                  "destination": [
                    "window-right",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "window-right",
                    0
                  ],
                  "destination": [
                    "window-pack",
                    2
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "window-left",
                    0
                  ],
                  "destination": [
                    "window-pack",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "window-pack",
                    0
                  ],
                  "destination": [
                    "window-resize",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "window-resize",
                    0
                  ],
                  "destination": [
                    "window",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "initial-0",
                    0
                  ],
                  "destination": [
                    "enabled-replay",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "enabled-replay",
                    0
                  ],
                  "destination": [
                    "enabled-tag",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "initialize",
                    6
                  ],
                  "destination": [
                    "voice-initial-gain",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "voice-initial-gain",
                    0
                  ],
                  "destination": [
                    "voice-gain",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "initialize",
                    6
                  ],
                  "destination": [
                    "beat-initial-gain",
                    0
                  ],
                  "order": 2
                }
              },
              {
                "patchline": {
                  "source": [
                    "beat-initial-gain",
                    0
                  ],
                  "destination": [
                    "beat-gain",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "initialize",
                    6
                  ],
                  "destination": [
                    "persist-reset",
                    0
                  ],
                  "order": 3
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-reset",
                    1
                  ],
                  "destination": [
                    "persist-restore-on",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-reset",
                    0
                  ],
                  "destination": [
                    "persist-capture-off",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-reset",
                    1
                  ],
                  "destination": [
                    "persist-retry",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-manual",
                    1
                  ],
                  "destination": [
                    "persist-restore-off",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-manual",
                    0
                  ],
                  "destination": [
                    "persist-capture-on",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "beat-type-selected-index",
                    0
                  ],
                  "destination": [
                    "persist-type-capture",
                    1
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-capture-off",
                    0
                  ],
                  "destination": [
                    "persist-type-capture",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-capture-on",
                    0
                  ],
                  "destination": [
                    "persist-type-capture",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-type-capture",
                    0
                  ],
                  "destination": [
                    "persist-type-index-map",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-type-index-map",
                    0
                  ],
                  "destination": [
                    "persist-type",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "beat-type",
                    0
                  ],
                  "destination": [
                    "persist-type-manual",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-type-manual",
                    1
                  ],
                  "destination": [
                    "persist-manual",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-type-manual",
                    0
                  ],
                  "destination": [
                    "beat-type-command",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "route",
                    15
                  ],
                  "destination": [
                    "persist-type-list",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-type-list",
                    2
                  ],
                  "destination": [
                    "persist-type-clear",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-type-clear",
                    0
                  ],
                  "destination": [
                    "persist-type-map",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-type-clear",
                    0
                  ],
                  "destination": [
                    "persist-type-index-map",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-type-list",
                    2
                  ],
                  "destination": [
                    "persist-type-zero",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-type-zero",
                    0
                  ],
                  "destination": [
                    "persist-type-index",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-type-list",
                    1
                  ],
                  "destination": [
                    "persist-type-iter",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-type-iter",
                    0
                  ],
                  "destination": [
                    "persist-type-list-key",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-type-list-key",
                    0
                  ],
                  "destination": [
                    "persist-type-list-symbol",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-type-list-symbol",
                    0
                  ],
                  "destination": [
                    "persist-type-entry",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-type-entry",
                    1
                  ],
                  "destination": [
                    "persist-type-index",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-type-index",
                    0
                  ],
                  "destination": [
                    "persist-type-pair",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-type-entry",
                    0
                  ],
                  "destination": [
                    "persist-type-pair",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-type-pair",
                    0
                  ],
                  "destination": [
                    "persist-type-store",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-type-store",
                    0
                  ],
                  "destination": [
                    "persist-type-map",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-type-pair",
                    0
                  ],
                  "destination": [
                    "persist-type-reverse",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-type-reverse",
                    0
                  ],
                  "destination": [
                    "persist-type-index-map",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-type-list",
                    0
                  ],
                  "destination": [
                    "beat-type-selected-index",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-type-list",
                    0
                  ],
                  "destination": [
                    "persist-type-defer",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-type-defer",
                    0
                  ],
                  "destination": [
                    "persist-type-restore",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-restore-on",
                    0
                  ],
                  "destination": [
                    "persist-type-restore",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-restore-off",
                    0
                  ],
                  "destination": [
                    "persist-type-restore",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-type-restore",
                    0
                  ],
                  "destination": [
                    "persist-type",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-type",
                    0
                  ],
                  "destination": [
                    "persist-type-map",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-retry",
                    0
                  ],
                  "destination": [
                    "persist-type-change",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-type-map",
                    0
                  ],
                  "destination": [
                    "persist-type-change",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-type-change",
                    0
                  ],
                  "destination": [
                    "persist-type-apply",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-type-apply",
                    1
                  ],
                  "destination": [
                    "persist-channel-retry",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-channel-retry",
                    0
                  ],
                  "destination": [
                    "persist-channel-change",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-type-apply",
                    0
                  ],
                  "destination": [
                    "beat-type-command",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "beat-channel-selected-index",
                    0
                  ],
                  "destination": [
                    "persist-channel-capture",
                    1
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-capture-off",
                    0
                  ],
                  "destination": [
                    "persist-channel-capture",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-capture-on",
                    0
                  ],
                  "destination": [
                    "persist-channel-capture",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-channel-capture",
                    0
                  ],
                  "destination": [
                    "persist-channel-index-map",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-channel-index-map",
                    0
                  ],
                  "destination": [
                    "persist-channel",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "beat-channel",
                    0
                  ],
                  "destination": [
                    "persist-channel-manual",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-channel-manual",
                    1
                  ],
                  "destination": [
                    "persist-manual",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-channel-manual",
                    0
                  ],
                  "destination": [
                    "beat-channel-command",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "route",
                    16
                  ],
                  "destination": [
                    "persist-channel-list",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-channel-list",
                    2
                  ],
                  "destination": [
                    "persist-channel-clear",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-channel-clear",
                    0
                  ],
                  "destination": [
                    "persist-channel-map",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-channel-clear",
                    0
                  ],
                  "destination": [
                    "persist-channel-index-map",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-channel-list",
                    2
                  ],
                  "destination": [
                    "persist-channel-zero",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-channel-zero",
                    0
                  ],
                  "destination": [
                    "persist-channel-index",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-channel-list",
                    1
                  ],
                  "destination": [
                    "persist-channel-iter",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-channel-iter",
                    0
                  ],
                  "destination": [
                    "persist-channel-list-key",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-channel-list-key",
                    0
                  ],
                  "destination": [
                    "persist-channel-list-symbol",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-channel-list-symbol",
                    0
                  ],
                  "destination": [
                    "persist-channel-entry",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-channel-entry",
                    1
                  ],
                  "destination": [
                    "persist-channel-index",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-channel-index",
                    0
                  ],
                  "destination": [
                    "persist-channel-pair",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-channel-entry",
                    0
                  ],
                  "destination": [
                    "persist-channel-pair",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-channel-pair",
                    0
                  ],
                  "destination": [
                    "persist-channel-store",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-channel-store",
                    0
                  ],
                  "destination": [
                    "persist-channel-map",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-channel-pair",
                    0
                  ],
                  "destination": [
                    "persist-channel-reverse",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-channel-reverse",
                    0
                  ],
                  "destination": [
                    "persist-channel-index-map",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-channel-list",
                    0
                  ],
                  "destination": [
                    "beat-channel-selected-index",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-channel-list",
                    0
                  ],
                  "destination": [
                    "persist-channel-defer",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-channel-defer",
                    0
                  ],
                  "destination": [
                    "persist-channel-restore",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-restore-on",
                    0
                  ],
                  "destination": [
                    "persist-channel-restore",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-restore-off",
                    0
                  ],
                  "destination": [
                    "persist-channel-restore",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-channel-restore",
                    0
                  ],
                  "destination": [
                    "persist-channel",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-channel",
                    0
                  ],
                  "destination": [
                    "persist-channel-map",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-retry",
                    0
                  ],
                  "destination": [
                    "persist-channel-change",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-channel-map",
                    0
                  ],
                  "destination": [
                    "persist-channel-change",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "persist-channel-change",
                    0
                  ],
                  "destination": [
                    "beat-channel-command",
                    0
                  ]
                }
              }
            ],
            "autosave": 0,
            "title": "Vocal Timing Monitor | 0.7 RC3.3 Persistent",
            "openrect": [
              60.0,
              50.0,
              600.0,
              340.0
            ]
          },
          "text": "p VTM_Monitor"
        }
      },
      {
        "box": {
          "id": "plugin",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            620.0,
            505.0,
            185.0,
            22.0
          ],
          "outlettype": [
            "signal",
            "signal"
          ],
          "text": "plugin~ 1 2"
        }
      },
      {
        "box": {
          "id": "phasor",
          "maxclass": "newobj",
          "numinlets": 0,
          "numoutlets": 1,
          "patching_rect": [
            820.0,
            505.0,
            185.0,
            22.0
          ],
          "outlettype": [
            "signal"
          ],
          "text": "plugphasor~"
        }
      },
      {
        "box": {
          "id": "engine",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 11,
          "patching_rect": [
            1020.0,
            505.0,
            185.0,
            22.0
          ],
          "patcher": {
            "fileversion": 1,
            "appversion": {
              "major": 8,
              "minor": 6,
              "revision": 0,
              "architecture": "x64",
              "modernui": 1
            },
            "classnamespace": "dsp.gen",
            "rect": [
              100.0,
              100.0,
              900.0,
              600.0
            ],
            "openinpresentation": 0,
            "default_fontname": "Arial",
            "default_fontsize": 12.0,
            "bgcolor": [
              0.055,
              0.071,
              0.098,
              1.0
            ],
            "editing_bgcolor": [
              0.055,
              0.071,
              0.098,
              1.0
            ],
            "locked_bgcolor": [
              0.055,
              0.071,
              0.098,
              1.0
            ],
            "toolbarvisible": 0,
            "boxes": [
              {
                "box": {
                  "id": "code",
                  "maxclass": "codebox",
                  "numinlets": 3,
                  "numoutlets": 11,
                  "patching_rect": [
                    20.0,
                    20.0,
                    850.0,
                    500.0
                  ],
                  "code": "// Vocal Timing Monitor 0.6 RC6. Embedded GenExpr, no external dependencies.\n// in1/in2 = stereo audio; in3 = plugphasor~ (one ramp per quarter note).\n// History reads are previous-sample values. Commit all histories at the end.\nParam enabled(1);\nParam autostop(0);\nParam apiready(0);\nParam grid(4);\nParam redms(100);\nParam offsetms(0);\nParam gateamp(0.0251188643);\nParam testseq(0);\nParam resetseq(0);\nHistory prevphase(0);\nHistory validrun(0);\nHistory periodms(600);\nHistory prevleft(0);\nHistory prevright(0);\nHistory hpleft(0);\nHistory hpright(0);\nHistory envelope(0);\nHistory noise(0.001);\nHistory quiet(0);\nHistory armed(0);\nHistory candidate(0);\nHistory candidatedelta(0);\nHistory candidateperiod(600);\nHistory cooldown(0);\nHistory total(0);\nHistory lastdelta(0);\nHistory lastraw(0);\nHistory lastclass(3);\nHistory stopheld(0);\nHistory prevauto(0);\nHistory lasttestseq(0);\nHistory testtotal(0);\nHistory testhold(0);\nHistory lastresetseq(0);\nHistory prevgrid(4);\nHistory prevoffset(0);\nHistory prevenabled(1);\nHistory hasmeasurement(0);\nHistory sampleclock(0);\n\n// Decode and validate the actual audio clock. Never timestamp in the UI thread.\nphase = clamp(in3, 0, 1);\npd = phase - prevphase;\ninc = pd < -0.5 ? pd + 1 : pd;\nincrementok = (inc >= 19.8 / (60 * samplerate)) && (inc <= 404 / (60 * samplerate));\nnvalid = incrementok ? min(validrun + 1, samplerate) : 0;\nsynced = nvalid >= samplerate * 0.010;\nnperiod = incrementok ? 1000 / (inc * samplerate) : periodms;\ndenom = grid == 16 ? 16 : (grid == 8 ? 8 : 4);\nsteps = denom / 4;\nstepms = nperiod / steps;\nmaxdeviation = stepms * 0.5;\nresetnow = resetseq != lastresetseq;\nsettingschanged = (denom != prevgrid) || (offsetms != prevoffset) || (enabled != prevenabled);\n// Only the validated audio clock and the user's analysis switch gate detection.\n// Host lifecycle flags remain in the native Auto Stop safety gate.\noperating = (enabled > 0) && synced;\n\n// Independent high-pass for each channel; max(abs(L),abs(R)) avoids phase cancellation.\nhpcoef = exp(-6.28318530718 * 65 / samplerate);\nnl = in1 - prevleft + hpcoef * hpleft;\nnr = in2 - prevright + hpcoef * hpright;\nlevel = max(abs(nl), abs(nr));\nenvcoef = exp(-1 / (samplerate * (level > envelope ? 0.0002 : 0.008)));\nnenv = level + envcoef * (envelope - level);\ntriggerlevel = max(clamp(gateamp, 0.001, 0.5), max(noise * 3.5, noise + 0.008));\nreleaselevel = triggerlevel * 0.45;\nnnoise = nenv < releaselevel ? noise + (nenv - noise) / samplerate : noise;\nnquiet = nenv < releaselevel ? min(quiet + 1, samplerate) : 0;\nnarmed = armed;\nncandidate = candidate;\nncdelta = candidatedelta;\nncperiod = candidateperiod;\nncool = max(0, cooldown - 1);\nntotal = total;\nndelta = lastdelta;\nnraw = lastraw;\nnclass = lastclass;\nnstop = stopheld;\nntests = testtotal;\nnmeasurement = hasmeasurement;\nnthold = max(0, testhold - 1);\n\nif (nquiet >= samplerate * 0.012) {\n    narmed = 1;\n}\nif (!operating || resetnow || settingschanged) {\n    ncandidate = 0;\n    narmed = 0;\n    nquiet = 0;\n    ncool = 0;\n}\nif (resetnow || settingschanged) {\n    nclass = 3;\n    nthold = 0;\n    nmeasurement = 0;\n}\nif (resetnow) {\n    ntotal = 0;\n    ntests = 0;\n    ndelta = 0;\n    nraw = 0;\n}\n\n// Mark first threshold crossing, then confirm 2 ms of continuous envelope.\n// Timestamp remains the crossing, never the later confirmation instant.\nif (operating && !resetnow && !settingschanged) {\n    if ((candidate == 0) && narmed && (ncool == 0) && (nenv >= triggerlevel)) {\n        ncandidate = 1;\n        ncdelta = phase * nperiod;\n        ncperiod = nperiod;\n        narmed = 0;\n    } else if (candidate > 0) {\n        if (nenv < releaselevel) {\n            ncandidate = 0;\n        } else {\n            ncandidate = candidate + 1;\n        }\n    }\n    if (ncandidate >= samplerate * 0.002) {\n        rawpos = ncdelta / ncperiod * steps;\n        rawdelta = (rawpos - floor(rawpos + 0.5)) * ncperiod / steps;\n        adjusted = (ncdelta - clamp(offsetms, -500, 500)) / ncperiod * steps;\n        measured = (adjusted - floor(adjusted + 0.5)) * ncperiod / steps;\n        ndelta = measured;\n        nraw = rawdelta;\n        ntotal = total + 1;\n        nmeasurement = 1;\n        nclass = abs(measured) >= clamp(redms, 10, 300) ? 6 : (abs(measured) >= min(45, redms * 0.5) ? 5 : 4);\n        nthold = 0;\n        ncandidate = 0;\n        ncool = samplerate * max(0.020, min(0.080, stepms * 0.00045));\n        if ((nclass == 6) && (autostop > 0) && (prevauto > 0) && (apiready > 0)) {\n            nstop = 1;\n        }\n    }\n}\n\n// UI test is a separate, labelled synthetic timestamp; it cannot arm Auto Stop.\nif (testseq != lasttestseq) {\n    ntests = testtotal + 1;\n    nthold = samplerate * 0.8;\n    if (operating) {\n        testpos = (phase * nperiod - clamp(offsetms, -500, 500)) / stepms;\n        ndelta = (testpos - floor(testpos + 0.5)) * stepms;\n        nclass = 7;\n        nmeasurement = 1;\n    } else {\n        nclass = 8;\n    }\n}\n\n// DSP-side cancellation. Lifecycle/preview flags are checked by the native gate\n// and also disarm autostop; they do not gate read-only audio analysis here.\nif ((autostop <= 0) || (enabled <= 0) || (apiready <= 0) || resetnow || settingschanged || !synced) {\n    nstop = 0;\n}\nstate = nclass;\nif (nthold > 0) {\n    // Retain the result AT THE TEST instant; later sync must not upgrade it.\n    state = nclass;\n} else if (enabled <= 0) {\n    state = 0;\n} else if (!synced) {\n    state = incrementok ? 2 : 1;\n}\nif (nstop > 0) {\n    state = 9;\n}\n\nout1 = ndelta;\nout2 = ntotal;\nout3 = nstop;\nout4 = state;\nout5 = nenv;\nout6 = ntests;\nout7 = nraw;\nout8 = synced;\nout9 = maxdeviation;\nout10 = nmeasurement;\n// DSP activity is measured independently from transport and input amplitude.\nnextclock = sampleclock + 1;\nif (nextclock >= 1000000000) {\n    nextclock = 0;\n}\nout11 = nextclock;\n\nprevphase = phase;\nvalidrun = nvalid;\nperiodms = nperiod;\nprevleft = in1;\nprevright = in2;\nhpleft = nl;\nhpright = nr;\nenvelope = nenv;\nnoise = nnoise;\nquiet = nquiet;\narmed = narmed;\ncandidate = ncandidate;\ncandidatedelta = ncdelta;\ncandidateperiod = ncperiod;\ncooldown = ncool;\ntotal = ntotal;\nlastdelta = ndelta;\nlastraw = nraw;\nlastclass = nclass;\nstopheld = nstop;\nprevauto = autostop;\nlasttestseq = testseq;\ntesttotal = ntests;\ntesthold = nthold;\nlastresetseq = resetseq;\nprevgrid = denom;\nprevoffset = offsetms;\nprevenabled = enabled;\nhasmeasurement = nmeasurement;\nsampleclock = nextclock;\n"
                }
              },
              {
                "box": {
                  "id": "in1",
                  "maxclass": "newobj",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    460.0,
                    185.0,
                    22.0
                  ],
                  "text": "in 1"
                }
              },
              {
                "box": {
                  "id": "in2",
                  "maxclass": "newobj",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    460.0,
                    185.0,
                    22.0
                  ],
                  "text": "in 2"
                }
              },
              {
                "box": {
                  "id": "in3",
                  "maxclass": "newobj",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    460.0,
                    185.0,
                    22.0
                  ],
                  "text": "in 3"
                }
              },
              {
                "box": {
                  "id": "out1",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    620.0,
                    460.0,
                    185.0,
                    22.0
                  ],
                  "text": "out 1"
                }
              },
              {
                "box": {
                  "id": "out2",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    820.0,
                    460.0,
                    185.0,
                    22.0
                  ],
                  "text": "out 2"
                }
              },
              {
                "box": {
                  "id": "out3",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    1020.0,
                    460.0,
                    185.0,
                    22.0
                  ],
                  "text": "out 3"
                }
              },
              {
                "box": {
                  "id": "out4",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    20.0,
                    505.0,
                    185.0,
                    22.0
                  ],
                  "text": "out 4"
                }
              },
              {
                "box": {
                  "id": "out5",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    220.0,
                    505.0,
                    185.0,
                    22.0
                  ],
                  "text": "out 5"
                }
              },
              {
                "box": {
                  "id": "out6",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    420.0,
                    505.0,
                    185.0,
                    22.0
                  ],
                  "text": "out 6"
                }
              },
              {
                "box": {
                  "id": "out7",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    620.0,
                    505.0,
                    185.0,
                    22.0
                  ],
                  "text": "out 7"
                }
              },
              {
                "box": {
                  "id": "out8",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    820.0,
                    505.0,
                    185.0,
                    22.0
                  ],
                  "text": "out 8"
                }
              },
              {
                "box": {
                  "id": "out9",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    1020.0,
                    505.0,
                    185.0,
                    22.0
                  ],
                  "text": "out 9"
                }
              },
              {
                "box": {
                  "id": "out10",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    20.0,
                    550.0,
                    185.0,
                    22.0
                  ],
                  "text": "out 10"
                }
              },
              {
                "box": {
                  "id": "out11",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    220.0,
                    550.0,
                    185.0,
                    22.0
                  ],
                  "text": "out 11"
                }
              }
            ],
            "lines": [
              {
                "patchline": {
                  "source": [
                    "in1",
                    0
                  ],
                  "destination": [
                    "code",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "in2",
                    0
                  ],
                  "destination": [
                    "code",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "in3",
                    0
                  ],
                  "destination": [
                    "code",
                    2
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "code",
                    0
                  ],
                  "destination": [
                    "out1",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "code",
                    1
                  ],
                  "destination": [
                    "out2",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "code",
                    2
                  ],
                  "destination": [
                    "out3",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "code",
                    3
                  ],
                  "destination": [
                    "out4",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "code",
                    4
                  ],
                  "destination": [
                    "out5",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "code",
                    5
                  ],
                  "destination": [
                    "out6",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "code",
                    6
                  ],
                  "destination": [
                    "out7",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "code",
                    7
                  ],
                  "destination": [
                    "out8",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "code",
                    8
                  ],
                  "destination": [
                    "out9",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "code",
                    9
                  ],
                  "destination": [
                    "out10",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "code",
                    10
                  ],
                  "destination": [
                    "out11",
                    0
                  ]
                }
              }
            ],
            "autosave": 0
          },
          "outlettype": [
            "signal",
            "signal",
            "signal",
            "signal",
            "signal",
            "signal",
            "signal",
            "signal",
            "signal",
            "signal",
            "signal"
          ],
          "text": "gen~"
        }
      },
      {
        "box": {
          "id": "input-abs-l",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            20.0,
            550.0,
            185.0,
            22.0
          ],
          "outlettype": [
            "signal"
          ],
          "text": "abs~"
        }
      },
      {
        "box": {
          "id": "input-abs-r",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            220.0,
            550.0,
            185.0,
            22.0
          ],
          "outlettype": [
            "signal"
          ],
          "text": "abs~"
        }
      },
      {
        "box": {
          "id": "input-max",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            420.0,
            550.0,
            185.0,
            22.0
          ],
          "outlettype": [
            "signal"
          ],
          "text": "maximum~"
        }
      },
      {
        "box": {
          "id": "input-peak",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            620.0,
            550.0,
            185.0,
            22.0
          ],
          "text": "peakamp~ 600"
        }
      },
      {
        "box": {
          "id": "silence",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            820.0,
            550.0,
            185.0,
            22.0
          ],
          "outlettype": [
            "signal"
          ],
          "text": "sig~ 0"
        }
      },
      {
        "box": {
          "id": "plugout",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 0,
          "patching_rect": [
            1020.0,
            550.0,
            185.0,
            22.0
          ],
          "text": "plugout~"
        }
      },
      {
        "box": {
          "id": "control-route",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 8,
          "patching_rect": [
            20.0,
            595.0,
            185.0,
            22.0
          ],
          "text": "route gatedb enabled autostop grid redms offsetms resetseq"
        }
      },
      {
        "box": {
          "id": "db-linear",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            220.0,
            595.0,
            185.0,
            22.0
          ],
          "text": "expr exp($f1 * 0.11512925464970229)"
        }
      },
      {
        "box": {
          "id": "gateamp-tag",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            420.0,
            595.0,
            185.0,
            22.0
          ],
          "text": "prepend gateamp"
        }
      },
      {
        "box": {
          "id": "enabled-tag",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            620.0,
            595.0,
            185.0,
            22.0
          ],
          "text": "prepend enabled"
        }
      },
      {
        "box": {
          "id": "autostop-tag",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            820.0,
            595.0,
            185.0,
            22.0
          ],
          "text": "prepend autostop"
        }
      },
      {
        "box": {
          "id": "grid-tag",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            1020.0,
            595.0,
            185.0,
            22.0
          ],
          "text": "prepend grid"
        }
      },
      {
        "box": {
          "id": "redms-tag",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            20.0,
            640.0,
            185.0,
            22.0
          ],
          "text": "prepend redms"
        }
      },
      {
        "box": {
          "id": "offsetms-tag",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            220.0,
            640.0,
            185.0,
            22.0
          ],
          "text": "prepend offsetms"
        }
      },
      {
        "box": {
          "id": "resetseq-tag",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            420.0,
            640.0,
            185.0,
            22.0
          ],
          "text": "prepend resetseq"
        }
      },
      {
        "box": {
          "id": "thisdevice",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            620.0,
            640.0,
            185.0,
            22.0
          ],
          "text": "live.thisdevice"
        }
      },
      {
        "box": {
          "id": "load",
          "maxclass": "newobj",
          "numinlets": 0,
          "numoutlets": 1,
          "patching_rect": [
            820.0,
            640.0,
            185.0,
            22.0
          ],
          "text": "loadbang"
        }
      },
      {
        "box": {
          "id": "start-qmetro",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            1020.0,
            640.0,
            185.0,
            22.0
          ],
          "text": "1"
        }
      },
      {
        "box": {
          "id": "qmetro",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            20.0,
            685.0,
            185.0,
            22.0
          ],
          "text": "qmetro 20"
        }
      },
      {
        "box": {
          "id": "ready-defer",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            220.0,
            685.0,
            185.0,
            22.0
          ],
          "text": "deferlow"
        }
      },
      {
        "box": {
          "id": "ready-trigger",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            420.0,
            685.0,
            185.0,
            22.0
          ],
          "text": "t b b b"
        }
      },
      {
        "box": {
          "id": "init-ui",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            620.0,
            685.0,
            185.0,
            22.0
          ],
          "text": "init"
        }
      },
      {
        "box": {
          "id": "reset-dsp",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            820.0,
            685.0,
            185.0,
            22.0
          ],
          "text": "resetseq -1"
        }
      },
      {
        "box": {
          "id": "path-message",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            1020.0,
            685.0,
            185.0,
            22.0
          ],
          "text": "path live_set"
        }
      },
      {
        "box": {
          "id": "live-path",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            20.0,
            730.0,
            185.0,
            22.0
          ],
          "text": "live.path"
        }
      },
      {
        "box": {
          "id": "stop-object",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            220.0,
            730.0,
            185.0,
            22.0
          ],
          "text": "live.object"
        }
      },
      {
        "box": {
          "id": "id-route",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            420.0,
            730.0,
            185.0,
            22.0
          ],
          "text": "route id"
        }
      },
      {
        "box": {
          "id": "path-trigger",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            620.0,
            730.0,
            185.0,
            22.0
          ],
          "text": "t b i i"
        }
      },
      {
        "box": {
          "id": "bind-id",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            820.0,
            730.0,
            185.0,
            22.0
          ],
          "text": "prepend id"
        }
      },
      {
        "box": {
          "id": "ack-valid",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            1020.0,
            730.0,
            185.0,
            22.0
          ],
          "text": "expr ($i1 > 0) && ($i1 == $i2)"
        }
      },
      {
        "box": {
          "id": "api-clear",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            20.0,
            775.0,
            185.0,
            22.0
          ],
          "text": "0"
        }
      },
      {
        "box": {
          "id": "api-valid",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 3,
          "patching_rect": [
            220.0,
            775.0,
            185.0,
            22.0
          ],
          "text": "change -1"
        }
      },
      {
        "box": {
          "id": "bind-defer",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            420.0,
            775.0,
            185.0,
            22.0
          ],
          "text": "deferlow"
        }
      },
      {
        "box": {
          "id": "bind-getid",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            620.0,
            775.0,
            185.0,
            22.0
          ],
          "text": "getid"
        }
      },
      {
        "box": {
          "id": "object-response",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            820.0,
            775.0,
            185.0,
            22.0
          ],
          "text": "route id is_playing"
        }
      },
      {
        "box": {
          "id": "api-tag",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            1020.0,
            775.0,
            185.0,
            22.0
          ],
          "text": "prepend apiready"
        }
      },
      {
        "box": {
          "id": "api-ui-tag",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            20.0,
            820.0,
            185.0,
            22.0
          ],
          "text": "prepend api"
        }
      },
      {
        "box": {
          "id": "retry",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            220.0,
            820.0,
            185.0,
            22.0
          ],
          "text": "metro 1000"
        }
      },
      {
        "box": {
          "id": "retry-gate",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            420.0,
            820.0,
            185.0,
            22.0
          ],
          "text": "gate 1 0"
        }
      },
      {
        "box": {
          "id": "api-not",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            620.0,
            820.0,
            185.0,
            22.0
          ],
          "text": "== 0"
        }
      },
      {
        "box": {
          "id": "enable-retry",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            820.0,
            820.0,
            185.0,
            22.0
          ],
          "text": "1"
        }
      },
      {
        "box": {
          "id": "deviceon-change",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            1020.0,
            820.0,
            185.0,
            22.0
          ],
          "text": "sel 0"
        }
      },
      {
        "box": {
          "id": "disarm-ui",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            20.0,
            865.0,
            185.0,
            22.0
          ],
          "text": "disarm"
        }
      },
      {
        "box": {
          "id": "stopped-select",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            220.0,
            865.0,
            185.0,
            22.0
          ],
          "text": "sel 0"
        }
      },
      {
        "box": {
          "id": "api-lost",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            420.0,
            865.0,
            185.0,
            22.0
          ],
          "text": "sel 0"
        }
      },
      {
        "box": {
          "id": "enabled-off",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            620.0,
            865.0,
            185.0,
            22.0
          ],
          "text": "sel 0"
        }
      },
      {
        "box": {
          "id": "safety",
          "maxclass": "newobj",
          "numinlets": 6,
          "numoutlets": 1,
          "patching_rect": [
            820.0,
            865.0,
            185.0,
            22.0
          ],
          "text": "expr ($i1 > 0) && ($i2 > 0) && ($i3 > 0) && ($i4 > 0) && ($i5 > 0) && ($i6 > 0)"
        }
      },
      {
        "box": {
          "id": "safety-pak",
          "maxclass": "newobj",
          "numinlets": 6,
          "numoutlets": 1,
          "patching_rect": [
            1020.0,
            865.0,
            185.0,
            22.0
          ],
          "text": "pak 0 1 0 1 0 0"
        }
      },
      {
        "box": {
          "id": "safety-unpack",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 6,
          "patching_rect": [
            20.0,
            910.0,
            185.0,
            22.0
          ],
          "text": "unpack 0 0 0 0 0 0"
        }
      },
      {
        "box": {
          "id": "stop-reason",
          "maxclass": "newobj",
          "numinlets": 6,
          "numoutlets": 1,
          "patching_rect": [
            220.0,
            910.0,
            185.0,
            22.0
          ],
          "text": "expr ($i3 <= 0) + ($i3 > 0) * (3 * ($i4 <= 0) + ($i4 > 0) * (4 * ($i5 <= 0) + ($i5 > 0) * (5 * ($i6 <= 0) + ($i6 > 0) * (6 * ($i2 <= 0) + ($i2 > 0) * 7 * ($i1 <= 0)))))"
        }
      },
      {
        "box": {
          "id": "stop-reason-store",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            420.0,
            910.0,
            185.0,
            22.0
          ],
          "text": "i 1"
        }
      },
      {
        "box": {
          "id": "stopnote-ui-tag",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            620.0,
            910.0,
            185.0,
            22.0
          ],
          "text": "prepend stopnote"
        }
      },
      {
        "box": {
          "id": "stop-defer",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            820.0,
            910.0,
            185.0,
            22.0
          ],
          "text": "deferlow"
        }
      },
      {
        "box": {
          "id": "stop-gate",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            1020.0,
            910.0,
            185.0,
            22.0
          ],
          "text": "gate 1 0"
        }
      },
      {
        "box": {
          "id": "stop-finalize",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            20.0,
            955.0,
            185.0,
            22.0
          ],
          "text": "t b b b"
        }
      },
      {
        "box": {
          "id": "stop-trigger",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            220.0,
            955.0,
            185.0,
            22.0
          ],
          "text": "t b b"
        }
      },
      {
        "box": {
          "id": "stop-call",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            420.0,
            955.0,
            185.0,
            22.0
          ],
          "text": "call stop_playing"
        }
      },
      {
        "box": {
          "id": "stop-sent",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            620.0,
            955.0,
            185.0,
            22.0
          ],
          "text": "8"
        }
      },
      {
        "box": {
          "id": "stop-check-bang",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            820.0,
            955.0,
            185.0,
            22.0
          ],
          "text": "t b"
        }
      },
      {
        "box": {
          "id": "stop-check-delay",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            1020.0,
            955.0,
            185.0,
            22.0
          ],
          "text": "delay 150"
        }
      },
      {
        "box": {
          "id": "stop-check-gate",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            20.0,
            1000.0,
            185.0,
            22.0
          ],
          "text": "gate 1 0"
        }
      },
      {
        "box": {
          "id": "stop-check-get",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            220.0,
            1000.0,
            185.0,
            22.0
          ],
          "text": "get is_playing"
        }
      },
      {
        "box": {
          "id": "stop-check-select",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            420.0,
            1000.0,
            185.0,
            22.0
          ],
          "text": "sel 0 1"
        }
      },
      {
        "box": {
          "id": "stop-confirmed",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            620.0,
            1000.0,
            185.0,
            22.0
          ],
          "text": "9"
        }
      },
      {
        "box": {
          "id": "stop-unconfirmed",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            820.0,
            1000.0,
            185.0,
            22.0
          ],
          "text": "10"
        }
      },
      {
        "box": {
          "id": "stop-check-cancel",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            1020.0,
            1000.0,
            185.0,
            22.0
          ],
          "text": "stop"
        }
      },
      {
        "box": {
          "id": "disarm-reason-gate",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            20.0,
            1045.0,
            185.0,
            22.0
          ],
          "text": "gate 1 0"
        }
      },
      {
        "box": {
          "id": "api-lost-reason",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            220.0,
            1045.0,
            185.0,
            22.0
          ],
          "text": "1"
        }
      },
      {
        "box": {
          "id": "deviceon-change-reason",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            420.0,
            1045.0,
            185.0,
            22.0
          ],
          "text": "3"
        }
      },
      {
        "box": {
          "id": "stopped-select-reason",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            620.0,
            1045.0,
            185.0,
            22.0
          ],
          "text": "4"
        }
      },
      {
        "box": {
          "id": "audio-lost-reason",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            820.0,
            1045.0,
            185.0,
            22.0
          ],
          "text": "5"
        }
      },
      {
        "box": {
          "id": "enabled-off-reason",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            1020.0,
            1045.0,
            185.0,
            22.0
          ],
          "text": "6"
        }
      },
      {
        "box": {
          "id": "poll",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            20.0,
            1090.0,
            185.0,
            22.0
          ],
          "text": "t b b"
        }
      },
      {
        "box": {
          "id": "snapshot-trigger",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 10,
          "patching_rect": [
            220.0,
            1090.0,
            185.0,
            22.0
          ],
          "text": "t b b b b b b b b b b"
        }
      },
      {
        "box": {
          "id": "snapshot-0",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            420.0,
            1090.0,
            185.0,
            22.0
          ],
          "text": "snapshot~"
        }
      },
      {
        "box": {
          "id": "delta-ui-tag",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            620.0,
            1090.0,
            185.0,
            22.0
          ],
          "text": "prepend delta"
        }
      },
      {
        "box": {
          "id": "snapshot-1",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            820.0,
            1090.0,
            185.0,
            22.0
          ],
          "text": "snapshot~"
        }
      },
      {
        "box": {
          "id": "count-int",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            1020.0,
            1090.0,
            185.0,
            22.0
          ],
          "text": "i"
        }
      },
      {
        "box": {
          "id": "count-change",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 3,
          "patching_rect": [
            20.0,
            1135.0,
            185.0,
            22.0
          ],
          "text": "change"
        }
      },
      {
        "box": {
          "id": "count-ui-tag",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            220.0,
            1135.0,
            185.0,
            22.0
          ],
          "text": "prepend count"
        }
      },
      {
        "box": {
          "id": "snapshot-2",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            420.0,
            1135.0,
            185.0,
            22.0
          ],
          "text": "snapshot~"
        }
      },
      {
        "box": {
          "id": "stop-change",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 3,
          "patching_rect": [
            620.0,
            1135.0,
            185.0,
            22.0
          ],
          "text": "change"
        }
      },
      {
        "box": {
          "id": "stop-select",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            820.0,
            1135.0,
            185.0,
            22.0
          ],
          "text": "sel 1"
        }
      },
      {
        "box": {
          "id": "snapshot-3",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            1020.0,
            1135.0,
            185.0,
            22.0
          ],
          "text": "snapshot~"
        }
      },
      {
        "box": {
          "id": "state-int",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            20.0,
            1180.0,
            185.0,
            22.0
          ],
          "text": "i"
        }
      },
      {
        "box": {
          "id": "state-change",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 3,
          "patching_rect": [
            220.0,
            1180.0,
            185.0,
            22.0
          ],
          "text": "change -1"
        }
      },
      {
        "box": {
          "id": "state-ui-tag",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            420.0,
            1180.0,
            185.0,
            22.0
          ],
          "text": "prepend state"
        }
      },
      {
        "box": {
          "id": "snapshot-4",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            620.0,
            1180.0,
            185.0,
            22.0
          ],
          "text": "snapshot~"
        }
      },
      {
        "box": {
          "id": "level-ui-tag",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            820.0,
            1180.0,
            185.0,
            22.0
          ],
          "text": "prepend level"
        }
      },
      {
        "box": {
          "id": "snapshot-5",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            1020.0,
            1180.0,
            185.0,
            22.0
          ],
          "text": "snapshot~"
        }
      },
      {
        "box": {
          "id": "tests-int",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            20.0,
            1225.0,
            185.0,
            22.0
          ],
          "text": "i"
        }
      },
      {
        "box": {
          "id": "tests-change",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 3,
          "patching_rect": [
            220.0,
            1225.0,
            185.0,
            22.0
          ],
          "text": "change"
        }
      },
      {
        "box": {
          "id": "tests-ui-tag",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            420.0,
            1225.0,
            185.0,
            22.0
          ],
          "text": "prepend tests"
        }
      },
      {
        "box": {
          "id": "snapshot-6",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            620.0,
            1225.0,
            185.0,
            22.0
          ],
          "text": "snapshot~"
        }
      },
      {
        "box": {
          "id": "raw-change",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 3,
          "patching_rect": [
            820.0,
            1225.0,
            185.0,
            22.0
          ],
          "text": "change 0."
        }
      },
      {
        "box": {
          "id": "raw-ui-tag",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            1020.0,
            1225.0,
            185.0,
            22.0
          ],
          "text": "prepend raw"
        }
      },
      {
        "box": {
          "id": "snapshot-7",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            20.0,
            1270.0,
            185.0,
            22.0
          ],
          "text": "snapshot~"
        }
      },
      {
        "box": {
          "id": "sync-int",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            220.0,
            1270.0,
            185.0,
            22.0
          ],
          "text": "i"
        }
      },
      {
        "box": {
          "id": "sync-change",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 3,
          "patching_rect": [
            420.0,
            1270.0,
            185.0,
            22.0
          ],
          "text": "change"
        }
      },
      {
        "box": {
          "id": "sync-ui-tag",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            620.0,
            1270.0,
            185.0,
            22.0
          ],
          "text": "prepend sync"
        }
      },
      {
        "box": {
          "id": "snapshot-8",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            820.0,
            1270.0,
            185.0,
            22.0
          ],
          "text": "snapshot~"
        }
      },
      {
        "box": {
          "id": "maxdev-change",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 3,
          "patching_rect": [
            1020.0,
            1270.0,
            185.0,
            22.0
          ],
          "text": "change 0."
        }
      },
      {
        "box": {
          "id": "maxdev-ui-tag",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            20.0,
            1315.0,
            185.0,
            22.0
          ],
          "text": "prepend maxdev"
        }
      },
      {
        "box": {
          "id": "snapshot-9",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            220.0,
            1315.0,
            185.0,
            22.0
          ],
          "text": "snapshot~"
        }
      },
      {
        "box": {
          "id": "hasdelta-int",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            420.0,
            1315.0,
            185.0,
            22.0
          ],
          "text": "i"
        }
      },
      {
        "box": {
          "id": "hasdelta-change",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 3,
          "patching_rect": [
            620.0,
            1315.0,
            185.0,
            22.0
          ],
          "text": "change"
        }
      },
      {
        "box": {
          "id": "hasdelta-ui-tag",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            820.0,
            1315.0,
            185.0,
            22.0
          ],
          "text": "prepend hasdelta"
        }
      },
      {
        "box": {
          "id": "heartbeat-snapshot",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            1020.0,
            1315.0,
            185.0,
            22.0
          ],
          "text": "snapshot~"
        }
      },
      {
        "box": {
          "id": "heartbeat-change",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 3,
          "patching_rect": [
            20.0,
            1360.0,
            185.0,
            22.0
          ],
          "text": "change 0."
        }
      },
      {
        "box": {
          "id": "heartbeat-trigger",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            220.0,
            1360.0,
            185.0,
            22.0
          ],
          "text": "t b b b"
        }
      },
      {
        "box": {
          "id": "heartbeat-cancel",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            420.0,
            1360.0,
            185.0,
            22.0
          ],
          "text": "stop"
        }
      },
      {
        "box": {
          "id": "heartbeat-timeout",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            620.0,
            1360.0,
            185.0,
            22.0
          ],
          "text": "delay 250"
        }
      },
      {
        "box": {
          "id": "audio-on",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            820.0,
            1360.0,
            185.0,
            22.0
          ],
          "text": "1"
        }
      },
      {
        "box": {
          "id": "audio-off",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            1020.0,
            1360.0,
            185.0,
            22.0
          ],
          "text": "0"
        }
      },
      {
        "box": {
          "id": "audio-alive",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 3,
          "patching_rect": [
            20.0,
            1405.0,
            185.0,
            22.0
          ],
          "text": "change -1"
        }
      },
      {
        "box": {
          "id": "audio-initial",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            220.0,
            1405.0,
            185.0,
            22.0
          ],
          "text": "0"
        }
      },
      {
        "box": {
          "id": "audio-lost",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            420.0,
            1405.0,
            185.0,
            22.0
          ],
          "text": "sel 0"
        }
      },
      {
        "box": {
          "id": "zero-level",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            620.0,
            1405.0,
            185.0,
            22.0
          ],
          "text": "level 0."
        }
      },
      {
        "box": {
          "id": "state-pak",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            820.0,
            1405.0,
            185.0,
            22.0
          ],
          "text": "pak 1 0"
        }
      },
      {
        "box": {
          "id": "state-unpack",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            1020.0,
            1405.0,
            185.0,
            22.0
          ],
          "text": "unpack 0 0"
        }
      },
      {
        "box": {
          "id": "state-render",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            20.0,
            1450.0,
            185.0,
            22.0
          ],
          "text": "expr $i1 * ($i2 > 0) + 10 * ($i2 == 0)"
        }
      },
      {
        "box": {
          "id": "state-render-change",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 3,
          "patching_rect": [
            220.0,
            1450.0,
            185.0,
            22.0
          ],
          "text": "change -1"
        }
      },
      {
        "box": {
          "id": "sync-pak",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            420.0,
            1450.0,
            185.0,
            22.0
          ],
          "text": "pak 0 0"
        }
      },
      {
        "box": {
          "id": "sync-unpack",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            620.0,
            1450.0,
            185.0,
            22.0
          ],
          "text": "unpack 0 0"
        }
      },
      {
        "box": {
          "id": "sync-render",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            820.0,
            1450.0,
            185.0,
            22.0
          ],
          "text": "expr ($i1 > 0) && ($i2 > 0)"
        }
      },
      {
        "box": {
          "id": "sync-render-change",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 3,
          "patching_rect": [
            1020.0,
            1450.0,
            185.0,
            22.0
          ],
          "text": "change -1"
        }
      },
      {
        "box": {
          "id": "beat-plugin",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [
            20.0,
            1495.0,
            185.0,
            22.0
          ],
          "outlettype": [
            "signal",
            "signal"
          ],
          "text": "plugin~ 3 4"
        }
      },
      {
        "box": {
          "id": "voice-display-abs-l",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            220.0,
            1495.0,
            185.0,
            22.0
          ],
          "outlettype": [
            "signal"
          ],
          "text": "abs~"
        }
      },
      {
        "box": {
          "id": "voice-display-abs-r",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            420.0,
            1495.0,
            185.0,
            22.0
          ],
          "outlettype": [
            "signal"
          ],
          "text": "abs~"
        }
      },
      {
        "box": {
          "id": "voice-display-choose",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            620.0,
            1495.0,
            185.0,
            22.0
          ],
          "outlettype": [
            "signal"
          ],
          "text": ">=~"
        }
      },
      {
        "box": {
          "id": "voice-display-index",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            820.0,
            1495.0,
            185.0,
            22.0
          ],
          "outlettype": [
            "signal"
          ],
          "text": "+~ 1"
        }
      },
      {
        "box": {
          "id": "voice-display-select",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 1,
          "patching_rect": [
            1020.0,
            1495.0,
            185.0,
            22.0
          ],
          "outlettype": [
            "signal"
          ],
          "text": "selector~ 2 1"
        }
      },
      {
        "box": {
          "id": "beat-display-abs-l",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            20.0,
            1540.0,
            185.0,
            22.0
          ],
          "outlettype": [
            "signal"
          ],
          "text": "abs~"
        }
      },
      {
        "box": {
          "id": "beat-display-abs-r",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            220.0,
            1540.0,
            185.0,
            22.0
          ],
          "outlettype": [
            "signal"
          ],
          "text": "abs~"
        }
      },
      {
        "box": {
          "id": "beat-display-choose",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            420.0,
            1540.0,
            185.0,
            22.0
          ],
          "outlettype": [
            "signal"
          ],
          "text": ">=~"
        }
      },
      {
        "box": {
          "id": "beat-display-index",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            620.0,
            1540.0,
            185.0,
            22.0
          ],
          "outlettype": [
            "signal"
          ],
          "text": "+~ 1"
        }
      },
      {
        "box": {
          "id": "beat-display-select",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 1,
          "patching_rect": [
            820.0,
            1540.0,
            185.0,
            22.0
          ],
          "outlettype": [
            "signal"
          ],
          "text": "selector~ 2 1"
        }
      },
      {
        "box": {
          "id": "beat-peak-max",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            1020.0,
            1540.0,
            185.0,
            22.0
          ],
          "outlettype": [
            "signal"
          ],
          "text": "maximum~"
        }
      },
      {
        "box": {
          "id": "beat-peak",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            20.0,
            1585.0,
            185.0,
            22.0
          ],
          "text": "peakamp~ 600"
        }
      },
      {
        "box": {
          "id": "beat-level-ui-tag",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            220.0,
            1585.0,
            185.0,
            22.0
          ],
          "text": "prepend beatlevel"
        }
      },
      {
        "box": {
          "id": "wave-control-route",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 4,
          "patching_rect": [
            420.0,
            1585.0,
            185.0,
            22.0
          ],
          "text": "route beat_type beat_channel beat_refresh"
        }
      },
      {
        "box": {
          "id": "beat-router",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 5,
          "patching_rect": [
            620.0,
            1585.0,
            185.0,
            22.0
          ],
          "text": "live.routing @port audio_inputs @index 1"
        }
      },
      {
        "box": {
          "id": "beat-type-command",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            820.0,
            1585.0,
            185.0,
            22.0
          ],
          "text": "prepend type"
        }
      },
      {
        "box": {
          "id": "beat-channel-command",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            1020.0,
            1585.0,
            185.0,
            22.0
          ],
          "text": "prepend channel"
        }
      },
      {
        "box": {
          "id": "beat-router-port",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            20.0,
            1630.0,
            185.0,
            22.0
          ],
          "text": "port audio_inputs"
        }
      },
      {
        "box": {
          "id": "beat-router-index",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            220.0,
            1630.0,
            185.0,
            22.0
          ],
          "text": "index 1"
        }
      },
      {
        "box": {
          "id": "beat-router-init",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            420.0,
            1630.0,
            185.0,
            22.0
          ],
          "text": "t b b"
        }
      },
      {
        "box": {
          "id": "wave_type-ui-tag",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            620.0,
            1630.0,
            185.0,
            22.0
          ],
          "text": "prepend wave_type"
        }
      },
      {
        "box": {
          "id": "wave_channel-ui-tag",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            820.0,
            1630.0,
            185.0,
            22.0
          ],
          "text": "prepend wave_channel"
        }
      },
      {
        "box": {
          "id": "wave_types-ui-tag",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            1020.0,
            1630.0,
            185.0,
            22.0
          ],
          "text": "prepend wave_types"
        }
      },
      {
        "box": {
          "id": "wave_channels-ui-tag",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            20.0,
            1675.0,
            185.0,
            22.0
          ],
          "text": "prepend wave_channels"
        }
      },
      {
        "box": {
          "id": "wave-samplerate",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 4,
          "patching_rect": [
            220.0,
            1675.0,
            185.0,
            22.0
          ],
          "text": "dspstate~"
        }
      },
      {
        "box": {
          "id": "wave-rate-query",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            420.0,
            1675.0,
            185.0,
            22.0
          ],
          "text": "t b"
        }
      },
      {
        "box": {
          "id": "wave-rate-change",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 3,
          "patching_rect": [
            620.0,
            1675.0,
            185.0,
            22.0
          ],
          "text": "change 0."
        }
      },
      {
        "box": {
          "id": "wave-duration",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            820.0,
            1675.0,
            185.0,
            22.0
          ],
          "text": "* 6."
        }
      },
      {
        "box": {
          "id": "wave-samples-ui-tag",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            1020.0,
            1675.0,
            185.0,
            22.0
          ],
          "text": "prepend wave_samples"
        }
      },
      {
        "box": {
          "id": "wave-grid-div",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            20.0,
            1720.0,
            185.0,
            22.0
          ],
          "text": "/ 4."
        }
      },
      {
        "box": {
          "id": "wave-grid-scale",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            220.0,
            1720.0,
            185.0,
            22.0
          ],
          "outlettype": [
            "signal"
          ],
          "text": "*~ 1."
        }
      },
      {
        "box": {
          "id": "wave-grid-wrap",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            420.0,
            1720.0,
            185.0,
            22.0
          ],
          "outlettype": [
            "signal"
          ],
          "text": "%~ 1."
        }
      },
      {
        "box": {
          "id": "wave-grid-pulse",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            620.0,
            1720.0,
            185.0,
            22.0
          ],
          "outlettype": [
            "signal"
          ],
          "text": "<~ 0.025"
        }
      },
      {
        "box": {
          "id": "wave-grid-valid",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            820.0,
            1720.0,
            185.0,
            22.0
          ],
          "outlettype": [
            "signal"
          ],
          "text": "*~ 0."
        }
      }
    ],
    "lines": [
      {
        "patchline": {
          "source": [
            "open",
            0
          ],
          "destination": [
            "open-bang",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "open-bang",
            0
          ],
          "destination": [
            "open-message",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "open-message",
            0
          ],
          "destination": [
            "pcontrol",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "pcontrol",
            0
          ],
          "destination": [
            "popup",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "plugin",
            0
          ],
          "destination": [
            "engine",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "plugin",
            1
          ],
          "destination": [
            "engine",
            1
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "phasor",
            0
          ],
          "destination": [
            "engine",
            2
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "plugin",
            0
          ],
          "destination": [
            "input-abs-l",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "plugin",
            1
          ],
          "destination": [
            "input-abs-r",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "input-abs-l",
            0
          ],
          "destination": [
            "input-max",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "input-abs-r",
            0
          ],
          "destination": [
            "input-max",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "input-max",
            0
          ],
          "destination": [
            "input-peak",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "input-peak",
            0
          ],
          "destination": [
            "level-ui-tag",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "silence",
            0
          ],
          "destination": [
            "plugout",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "silence",
            0
          ],
          "destination": [
            "plugout",
            1
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "control-route",
            0
          ],
          "destination": [
            "db-linear",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "db-linear",
            0
          ],
          "destination": [
            "gateamp-tag",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "gateamp-tag",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "control-route",
            1
          ],
          "destination": [
            "enabled-tag",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "enabled-tag",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "control-route",
            2
          ],
          "destination": [
            "autostop-tag",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "autostop-tag",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "control-route",
            3
          ],
          "destination": [
            "grid-tag",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "grid-tag",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "control-route",
            4
          ],
          "destination": [
            "redms-tag",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "redms-tag",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "control-route",
            5
          ],
          "destination": [
            "offsetms-tag",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "offsetms-tag",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "control-route",
            6
          ],
          "destination": [
            "resetseq-tag",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "resetseq-tag",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "control-route",
            7
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "load",
            0
          ],
          "destination": [
            "start-qmetro",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "start-qmetro",
            0
          ],
          "destination": [
            "qmetro",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "thisdevice",
            0
          ],
          "destination": [
            "ready-defer",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ready-defer",
            0
          ],
          "destination": [
            "ready-trigger",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "ready-trigger",
            2
          ],
          "destination": [
            "init-ui",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "init-ui",
            0
          ],
          "destination": [
            "popup",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ready-trigger",
            1
          ],
          "destination": [
            "reset-dsp",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "reset-dsp",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ready-trigger",
            0
          ],
          "destination": [
            "path-message",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "path-message",
            0
          ],
          "destination": [
            "live-path",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "live-path",
            1
          ],
          "destination": [
            "id-route",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "id-route",
            0
          ],
          "destination": [
            "path-trigger",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "path-trigger",
            1
          ],
          "destination": [
            "bind-id",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "bind-id",
            0
          ],
          "destination": [
            "stop-object",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "path-trigger",
            2
          ],
          "destination": [
            "ack-valid",
            1
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "path-trigger",
            2
          ],
          "destination": [
            "api-clear",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "api-clear",
            0
          ],
          "destination": [
            "api-valid",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "path-trigger",
            0
          ],
          "destination": [
            "bind-defer",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "bind-defer",
            0
          ],
          "destination": [
            "bind-getid",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "bind-getid",
            0
          ],
          "destination": [
            "stop-object",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "stop-object",
            0
          ],
          "destination": [
            "object-response",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "object-response",
            0
          ],
          "destination": [
            "ack-valid",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ack-valid",
            0
          ],
          "destination": [
            "api-valid",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "api-valid",
            0
          ],
          "destination": [
            "api-tag",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "api-tag",
            0
          ],
          "destination": [
            "engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "api-valid",
            0
          ],
          "destination": [
            "api-ui-tag",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "api-ui-tag",
            0
          ],
          "destination": [
            "popup",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "start-qmetro",
            0
          ],
          "destination": [
            "retry",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "ready-trigger",
            2
          ],
          "destination": [
            "enable-retry",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "enable-retry",
            0
          ],
          "destination": [
            "retry-gate",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "api-valid",
            0
          ],
          "destination": [
            "api-not",
            0
          ],
          "order": 2
        }
      },
      {
        "patchline": {
          "source": [
            "api-not",
            0
          ],
          "destination": [
            "retry-gate",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "retry",
            0
          ],
          "destination": [
            "retry-gate",
            1
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "retry-gate",
            0
          ],
          "destination": [
            "path-message",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "thisdevice",
            1
          ],
          "destination": [
            "deviceon-change",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "disarm-ui",
            0
          ],
          "destination": [
            "popup",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "sync-change",
            0
          ],
          "destination": [
            "stopped-select",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "api-valid",
            0
          ],
          "destination": [
            "api-lost",
            0
          ],
          "order": 3
        }
      },
      {
        "patchline": {
          "source": [
            "control-route",
            1
          ],
          "destination": [
            "enabled-off",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "control-route",
            3
          ],
          "destination": [
            "disarm-ui",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "control-route",
            4
          ],
          "destination": [
            "disarm-ui",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "control-route",
            5
          ],
          "destination": [
            "disarm-ui",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "control-route",
            6
          ],
          "destination": [
            "disarm-ui",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "control-route",
            2
          ],
          "destination": [
            "safety-pak",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "control-route",
            1
          ],
          "destination": [
            "safety-pak",
            1
          ],
          "order": 2
        }
      },
      {
        "patchline": {
          "source": [
            "api-valid",
            0
          ],
          "destination": [
            "safety-pak",
            2
          ],
          "order": 4
        }
      },
      {
        "patchline": {
          "source": [
            "thisdevice",
            1
          ],
          "destination": [
            "safety-pak",
            3
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "safety-pak",
            0
          ],
          "destination": [
            "safety-unpack",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "safety-unpack",
            0
          ],
          "destination": [
            "safety",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "safety-unpack",
            1
          ],
          "destination": [
            "safety",
            1
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "safety-unpack",
            2
          ],
          "destination": [
            "safety",
            2
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "safety-unpack",
            3
          ],
          "destination": [
            "safety",
            3
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "safety-unpack",
            4
          ],
          "destination": [
            "safety",
            4
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "safety-unpack",
            5
          ],
          "destination": [
            "safety",
            5
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "safety-unpack",
            0
          ],
          "destination": [
            "stop-reason",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "safety-unpack",
            1
          ],
          "destination": [
            "stop-reason",
            1
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "safety-unpack",
            2
          ],
          "destination": [
            "stop-reason",
            2
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "safety-unpack",
            3
          ],
          "destination": [
            "stop-reason",
            3
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "safety-unpack",
            4
          ],
          "destination": [
            "stop-reason",
            4
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "safety-unpack",
            5
          ],
          "destination": [
            "stop-reason",
            5
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "stop-reason",
            0
          ],
          "destination": [
            "stop-reason-store",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "stopnote-ui-tag",
            0
          ],
          "destination": [
            "popup",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "stop-reason-store",
            0
          ],
          "destination": [
            "stopnote-ui-tag",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "safety",
            0
          ],
          "destination": [
            "stop-gate",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "stop-defer",
            0
          ],
          "destination": [
            "stop-finalize",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "stop-finalize",
            2
          ],
          "destination": [
            "stop-reason-store",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "stop-finalize",
            1
          ],
          "destination": [
            "stop-gate",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "stop-finalize",
            0
          ],
          "destination": [
            "disarm-ui",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "stop-gate",
            0
          ],
          "destination": [
            "stop-trigger",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "stop-trigger",
            1
          ],
          "destination": [
            "disarm-ui",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "stop-trigger",
            0
          ],
          "destination": [
            "stop-call",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "stop-call",
            0
          ],
          "destination": [
            "stop-object",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "stop-call",
            0
          ],
          "destination": [
            "stop-sent",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "stop-sent",
            0
          ],
          "destination": [
            "stopnote-ui-tag",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "stop-call",
            0
          ],
          "destination": [
            "stop-check-bang",
            0
          ],
          "order": 2
        }
      },
      {
        "patchline": {
          "source": [
            "stop-check-bang",
            0
          ],
          "destination": [
            "stop-check-delay",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "api-valid",
            0
          ],
          "destination": [
            "stop-check-gate",
            0
          ],
          "order": 5
        }
      },
      {
        "patchline": {
          "source": [
            "stop-check-delay",
            0
          ],
          "destination": [
            "stop-check-gate",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "stop-check-gate",
            0
          ],
          "destination": [
            "stop-check-get",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "stop-check-get",
            0
          ],
          "destination": [
            "stop-object",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "object-response",
            1
          ],
          "destination": [
            "stop-check-select",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "stop-check-select",
            0
          ],
          "destination": [
            "stop-confirmed",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "stop-check-select",
            1
          ],
          "destination": [
            "stop-unconfirmed",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "stop-confirmed",
            0
          ],
          "destination": [
            "stopnote-ui-tag",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "stop-unconfirmed",
            0
          ],
          "destination": [
            "stopnote-ui-tag",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "api-lost",
            0
          ],
          "destination": [
            "stop-check-cancel",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "stop-check-cancel",
            0
          ],
          "destination": [
            "stop-check-delay",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "control-route",
            2
          ],
          "destination": [
            "disarm-reason-gate",
            0
          ],
          "order": 2
        }
      },
      {
        "patchline": {
          "source": [
            "disarm-reason-gate",
            0
          ],
          "destination": [
            "stopnote-ui-tag",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "api-lost",
            0
          ],
          "destination": [
            "api-lost-reason",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "api-lost-reason",
            0
          ],
          "destination": [
            "disarm-reason-gate",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "api-lost",
            0
          ],
          "destination": [
            "disarm-ui",
            0
          ],
          "order": 2
        }
      },
      {
        "patchline": {
          "source": [
            "deviceon-change",
            0
          ],
          "destination": [
            "deviceon-change-reason",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "deviceon-change-reason",
            0
          ],
          "destination": [
            "disarm-reason-gate",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "deviceon-change",
            0
          ],
          "destination": [
            "disarm-ui",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "stopped-select",
            0
          ],
          "destination": [
            "stopped-select-reason",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "stopped-select-reason",
            0
          ],
          "destination": [
            "disarm-reason-gate",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "stopped-select",
            0
          ],
          "destination": [
            "disarm-ui",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "audio-lost",
            0
          ],
          "destination": [
            "audio-lost-reason",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "audio-lost-reason",
            0
          ],
          "destination": [
            "disarm-reason-gate",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "audio-lost",
            0
          ],
          "destination": [
            "disarm-ui",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "enabled-off",
            0
          ],
          "destination": [
            "enabled-off-reason",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "enabled-off-reason",
            0
          ],
          "destination": [
            "disarm-reason-gate",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "enabled-off",
            0
          ],
          "destination": [
            "disarm-ui",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "qmetro",
            0
          ],
          "destination": [
            "poll",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "poll",
            1
          ],
          "destination": [
            "snapshot-trigger",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "engine",
            0
          ],
          "destination": [
            "snapshot-0",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "snapshot-trigger",
            8
          ],
          "destination": [
            "snapshot-0",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "delta-ui-tag",
            0
          ],
          "destination": [
            "popup",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "snapshot-0",
            0
          ],
          "destination": [
            "delta-ui-tag",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "engine",
            1
          ],
          "destination": [
            "snapshot-1",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "snapshot-trigger",
            7
          ],
          "destination": [
            "snapshot-1",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "snapshot-1",
            0
          ],
          "destination": [
            "count-int",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "count-int",
            0
          ],
          "destination": [
            "count-change",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "count-ui-tag",
            0
          ],
          "destination": [
            "popup",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "count-change",
            0
          ],
          "destination": [
            "count-ui-tag",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "engine",
            2
          ],
          "destination": [
            "snapshot-2",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "snapshot-trigger",
            6
          ],
          "destination": [
            "snapshot-2",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "snapshot-2",
            0
          ],
          "destination": [
            "stop-change",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "stop-change",
            0
          ],
          "destination": [
            "stop-select",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "stop-select",
            0
          ],
          "destination": [
            "stop-defer",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "engine",
            3
          ],
          "destination": [
            "snapshot-3",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "snapshot-trigger",
            5
          ],
          "destination": [
            "snapshot-3",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "snapshot-3",
            0
          ],
          "destination": [
            "state-int",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "state-int",
            0
          ],
          "destination": [
            "state-change",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "state-ui-tag",
            0
          ],
          "destination": [
            "popup",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "state-change",
            0
          ],
          "destination": [
            "state-pak",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "engine",
            4
          ],
          "destination": [
            "snapshot-4",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "snapshot-trigger",
            4
          ],
          "destination": [
            "snapshot-4",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "level-ui-tag",
            0
          ],
          "destination": [
            "popup",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "engine",
            5
          ],
          "destination": [
            "snapshot-5",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "snapshot-trigger",
            3
          ],
          "destination": [
            "snapshot-5",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "snapshot-5",
            0
          ],
          "destination": [
            "tests-int",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "tests-int",
            0
          ],
          "destination": [
            "tests-change",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "tests-ui-tag",
            0
          ],
          "destination": [
            "popup",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "tests-change",
            0
          ],
          "destination": [
            "tests-ui-tag",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "engine",
            6
          ],
          "destination": [
            "snapshot-6",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "snapshot-trigger",
            2
          ],
          "destination": [
            "snapshot-6",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "snapshot-6",
            0
          ],
          "destination": [
            "raw-change",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "raw-ui-tag",
            0
          ],
          "destination": [
            "popup",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "raw-change",
            0
          ],
          "destination": [
            "raw-ui-tag",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "engine",
            7
          ],
          "destination": [
            "snapshot-7",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "snapshot-trigger",
            1
          ],
          "destination": [
            "snapshot-7",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "snapshot-7",
            0
          ],
          "destination": [
            "sync-int",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "sync-int",
            0
          ],
          "destination": [
            "sync-change",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "sync-ui-tag",
            0
          ],
          "destination": [
            "popup",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "sync-change",
            0
          ],
          "destination": [
            "sync-pak",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "sync-change",
            0
          ],
          "destination": [
            "safety-pak",
            4
          ],
          "order": 2
        }
      },
      {
        "patchline": {
          "source": [
            "engine",
            8
          ],
          "destination": [
            "snapshot-8",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "snapshot-trigger",
            0
          ],
          "destination": [
            "snapshot-8",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "snapshot-8",
            0
          ],
          "destination": [
            "maxdev-change",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "maxdev-ui-tag",
            0
          ],
          "destination": [
            "popup",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "maxdev-change",
            0
          ],
          "destination": [
            "maxdev-ui-tag",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "engine",
            9
          ],
          "destination": [
            "snapshot-9",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "snapshot-trigger",
            9
          ],
          "destination": [
            "snapshot-9",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "snapshot-9",
            0
          ],
          "destination": [
            "hasdelta-int",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "hasdelta-int",
            0
          ],
          "destination": [
            "hasdelta-change",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "hasdelta-ui-tag",
            0
          ],
          "destination": [
            "popup",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "hasdelta-change",
            0
          ],
          "destination": [
            "hasdelta-ui-tag",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "engine",
            10
          ],
          "destination": [
            "heartbeat-snapshot",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "poll",
            0
          ],
          "destination": [
            "heartbeat-snapshot",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "heartbeat-snapshot",
            0
          ],
          "destination": [
            "heartbeat-change",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "heartbeat-change",
            0
          ],
          "destination": [
            "heartbeat-trigger",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "heartbeat-trigger",
            2
          ],
          "destination": [
            "heartbeat-cancel",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "heartbeat-cancel",
            0
          ],
          "destination": [
            "heartbeat-timeout",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "heartbeat-trigger",
            1
          ],
          "destination": [
            "heartbeat-timeout",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "heartbeat-trigger",
            0
          ],
          "destination": [
            "audio-on",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "heartbeat-timeout",
            0
          ],
          "destination": [
            "audio-off",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "audio-on",
            0
          ],
          "destination": [
            "audio-alive",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "audio-off",
            0
          ],
          "destination": [
            "audio-alive",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "load",
            0
          ],
          "destination": [
            "audio-initial",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "audio-initial",
            0
          ],
          "destination": [
            "audio-alive",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "audio-alive",
            0
          ],
          "destination": [
            "safety-pak",
            5
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "audio-alive",
            0
          ],
          "destination": [
            "audio-lost",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "audio-lost",
            0
          ],
          "destination": [
            "zero-level",
            0
          ],
          "order": 2
        }
      },
      {
        "patchline": {
          "source": [
            "zero-level",
            0
          ],
          "destination": [
            "popup",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "audio-alive",
            0
          ],
          "destination": [
            "state-pak",
            1
          ],
          "order": 2
        }
      },
      {
        "patchline": {
          "source": [
            "state-pak",
            0
          ],
          "destination": [
            "state-unpack",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "state-unpack",
            0
          ],
          "destination": [
            "state-render",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "state-unpack",
            1
          ],
          "destination": [
            "state-render",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "state-render",
            0
          ],
          "destination": [
            "state-render-change",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "state-render-change",
            0
          ],
          "destination": [
            "state-ui-tag",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "audio-alive",
            0
          ],
          "destination": [
            "sync-pak",
            1
          ],
          "order": 3
        }
      },
      {
        "patchline": {
          "source": [
            "sync-pak",
            0
          ],
          "destination": [
            "sync-unpack",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "sync-unpack",
            0
          ],
          "destination": [
            "sync-render",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "sync-unpack",
            1
          ],
          "destination": [
            "sync-render",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "sync-render",
            0
          ],
          "destination": [
            "sync-render-change",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "sync-render-change",
            0
          ],
          "destination": [
            "sync-ui-tag",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "plugin",
            0
          ],
          "destination": [
            "voice-display-abs-l",
            0
          ],
          "order": 2
        }
      },
      {
        "patchline": {
          "source": [
            "plugin",
            1
          ],
          "destination": [
            "voice-display-abs-r",
            0
          ],
          "order": 2
        }
      },
      {
        "patchline": {
          "source": [
            "voice-display-abs-l",
            0
          ],
          "destination": [
            "voice-display-choose",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "voice-display-abs-r",
            0
          ],
          "destination": [
            "voice-display-choose",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "voice-display-choose",
            0
          ],
          "destination": [
            "voice-display-index",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "voice-display-index",
            0
          ],
          "destination": [
            "voice-display-select",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "plugin",
            0
          ],
          "destination": [
            "voice-display-select",
            2
          ],
          "order": 3
        }
      },
      {
        "patchline": {
          "source": [
            "plugin",
            1
          ],
          "destination": [
            "voice-display-select",
            1
          ],
          "order": 3
        }
      },
      {
        "patchline": {
          "source": [
            "voice-display-select",
            0
          ],
          "destination": [
            "popup",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "beat-plugin",
            0
          ],
          "destination": [
            "beat-display-abs-l",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "beat-plugin",
            1
          ],
          "destination": [
            "beat-display-abs-r",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "beat-display-abs-l",
            0
          ],
          "destination": [
            "beat-display-choose",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "beat-display-abs-r",
            0
          ],
          "destination": [
            "beat-display-choose",
            1
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "beat-display-choose",
            0
          ],
          "destination": [
            "beat-display-index",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "beat-display-index",
            0
          ],
          "destination": [
            "beat-display-select",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "beat-plugin",
            0
          ],
          "destination": [
            "beat-display-select",
            2
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "beat-plugin",
            1
          ],
          "destination": [
            "beat-display-select",
            1
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "beat-display-select",
            0
          ],
          "destination": [
            "popup",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "beat-display-abs-l",
            0
          ],
          "destination": [
            "beat-peak-max",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "beat-display-abs-r",
            0
          ],
          "destination": [
            "beat-peak-max",
            1
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "beat-peak-max",
            0
          ],
          "destination": [
            "beat-peak",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "beat-peak",
            0
          ],
          "destination": [
            "beat-level-ui-tag",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "beat-level-ui-tag",
            0
          ],
          "destination": [
            "popup",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "popup",
            0
          ],
          "destination": [
            "wave-control-route",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "wave-control-route",
            3
          ],
          "destination": [
            "control-route",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "wave-control-route",
            0
          ],
          "destination": [
            "beat-type-command",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "wave-control-route",
            1
          ],
          "destination": [
            "beat-channel-command",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "beat-type-command",
            0
          ],
          "destination": [
            "beat-router",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "beat-channel-command",
            0
          ],
          "destination": [
            "beat-router",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ready-defer",
            0
          ],
          "destination": [
            "beat-router-init",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "beat-router-init",
            1
          ],
          "destination": [
            "beat-router-port",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "beat-router-init",
            0
          ],
          "destination": [
            "beat-router-index",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "beat-router-port",
            0
          ],
          "destination": [
            "beat-router",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "beat-router-index",
            0
          ],
          "destination": [
            "beat-router",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "wave-control-route",
            2
          ],
          "destination": [
            "beat-router-index",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "beat-router",
            0
          ],
          "destination": [
            "wave_type-ui-tag",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "wave_type-ui-tag",
            0
          ],
          "destination": [
            "popup",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "beat-router",
            1
          ],
          "destination": [
            "wave_channel-ui-tag",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "wave_channel-ui-tag",
            0
          ],
          "destination": [
            "popup",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "beat-router",
            2
          ],
          "destination": [
            "wave_types-ui-tag",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "wave_types-ui-tag",
            0
          ],
          "destination": [
            "popup",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "beat-router",
            3
          ],
          "destination": [
            "wave_channels-ui-tag",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "wave_channels-ui-tag",
            0
          ],
          "destination": [
            "popup",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "plugin",
            0
          ],
          "destination": [
            "wave-samplerate",
            0
          ],
          "order": 4
        }
      },
      {
        "patchline": {
          "source": [
            "ready-defer",
            0
          ],
          "destination": [
            "wave-rate-query",
            0
          ],
          "order": 2
        }
      },
      {
        "patchline": {
          "source": [
            "retry",
            0
          ],
          "destination": [
            "wave-rate-query",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "wave-rate-query",
            0
          ],
          "destination": [
            "wave-samplerate",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "wave-samplerate",
            1
          ],
          "destination": [
            "wave-rate-change",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "wave-rate-change",
            0
          ],
          "destination": [
            "wave-duration",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "wave-duration",
            0
          ],
          "destination": [
            "wave-samples-ui-tag",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "wave-samples-ui-tag",
            0
          ],
          "destination": [
            "popup",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "control-route",
            3
          ],
          "destination": [
            "wave-grid-div",
            0
          ],
          "order": 2
        }
      },
      {
        "patchline": {
          "source": [
            "phasor",
            0
          ],
          "destination": [
            "wave-grid-scale",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "wave-grid-div",
            0
          ],
          "destination": [
            "wave-grid-scale",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "wave-grid-scale",
            0
          ],
          "destination": [
            "wave-grid-wrap",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "wave-grid-wrap",
            0
          ],
          "destination": [
            "wave-grid-pulse",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "wave-grid-pulse",
            0
          ],
          "destination": [
            "wave-grid-valid",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "sync-render-change",
            0
          ],
          "destination": [
            "wave-grid-valid",
            1
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "wave-grid-valid",
            0
          ],
          "destination": [
            "popup",
            3
          ]
        }
      }
    ],
    "autosave": 0,
    "devicewidth": 360.0,
    "description": "Audio onset grid proximity monitor",
    "digest": "Vocal Timing Monitor 0.7 RC3.3 Persistent - native embedded engine",
    "tags": "audio timing monitor",
    "latency": 0,
    "is_mpe": 0,
    "minimum_live_version": "12.0.0",
    "minimum_max_version": "8.6.0",
    "dependency_cache": [],
    "parameters": {
      "inherited_shortname": 1,
      "popup::enabled": [
        "VTM Analysis",
        "VTM Analysis",
        0
      ],
      "popup::grid-ui": [
        "VTM Grid",
        "VTM Grid",
        0
      ],
      "popup::redms": [
        "VTM Threshold ms",
        "VTM Threshold ms",
        0
      ],
      "popup::offsetms": [
        "VTM Compensation ms",
        "VTM Compensation ms",
        0
      ],
      "popup::gatedb": [
        "VTM Detection dB",
        "VTM Detection dB",
        0
      ],
      "popup::voice-gain": [
        "VTM Voice zoom",
        "VTM Voice zoom",
        0
      ],
      "popup::beat-gain": [
        "VTM Beat zoom",
        "VTM Beat zoom",
        0
      ],
      "popup::persist-type": [
        "VTM Instrumental type",
        "VTM Instrumental type",
        0
      ],
      "popup::persist-channel": [
        "VTM Instrumental channel",
        "VTM Instrumental channel",
        0
      ]
    },
    "project": {
      "version": 1,
      "amxdtype": 1633771873,
      "readonly": 0,
      "contents": {
        "patchers": {},
        "code": {}
      },
      "searchpath": {},
      "detailsvisible": 0,
      "autoorganize": 1,
      "hideprojectwindow": 1,
      "showdependencies": 1,
      "autolocalize": 0
    }
  }
}