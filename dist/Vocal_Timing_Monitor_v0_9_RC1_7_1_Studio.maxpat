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
          "id": "ui-device-canvas",
          "maxclass": "panel",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            1020.0,
            1720.0,
            185.0,
            22.0
          ],
          "border": 0,
          "rounded": 0,
          "background": 1,
          "ignoreclick": 1,
          "presentation": 1,
          "presentation_rect": [
            0.0,
            0.0,
            360.0,
            169.0
          ],
          "varname": "vtm_device_canvas",
          "bgfillcolor": {
            "type": "color",
            "color": [
              0.06666666666666667,
              0.09019607843137255,
              0.13333333333333333,
              1.0
            ]
          }
        }
      },
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
          "fontsize": 20.0,
          "textcolor": [
            0.40784313725490196,
            0.8431372549019608,
            0.9294117647058824,
            1.0
          ],
          "fontface": 1,
          "text": "VOCAL TIMING MONITOR",
          "presentation": 1,
          "presentation_rect": [
            16.0,
            11.0,
            330.0,
            27
          ],
          "fontname": "Segoe UI",
          "varname": "vtm_device_title"
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
            0.6784313725490196,
            0.7294117647058823,
            0.807843137254902,
            1.0
          ],
          "text": "0.9 RC1.7.1 Studio | teme și setări salvate",
          "presentation": 1,
          "presentation_rect": [
            16.0,
            40.0,
            330.0,
            18.0
          ],
          "fontname": "Segoe UI",
          "varname": "vtm_device_version"
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
          "texton": "Deschide monitorul",
          "mode": 1,
          "parameter_enable": 0,
          "rounded": 7.0,
          "fontsize": 12.0,
          "fontface": 1,
          "textcolor": [
            0.9450980392156862,
            0.9607843137254902,
            0.984313725490196,
            1.0
          ],
          "textoncolor": [
            0.8509803921568627,
            0.9725490196078431,
            1.0,
            1.0
          ],
          "bgcolor": [
            0.06666666666666667,
            0.10588235294117647,
            0.1568627450980392,
            1.0
          ],
          "bgoncolor": [
            0.12941176470588237,
            0.28627450980392155,
            0.3411764705882353,
            1.0
          ],
          "usegradient": 0,
          "usebgoncolor": 1,
          "outputmode": 1,
          "text": "Deschide monitorul",
          "presentation": 1,
          "presentation_rect": [
            16.0,
            69.0,
            328.0,
            34.0
          ],
          "fontname": "Segoe UI",
          "varname": "vtm_device_open",
          "textovercolor": [
            0.9450980392156862,
            0.9607843137254902,
            0.984313725490196,
            1.0
          ],
          "usetextovercolor": 1
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
            0.6784313725490196,
            0.7294117647058823,
            0.807843137254902,
            1.0
          ],
          "text": "Setări în proiect · oprire automată OFF la încărcare",
          "presentation": 1,
          "presentation_rect": [
            16.0,
            113.0,
            330.0,
            18.0
          ],
          "fontname": "Segoe UI",
          "varname": "vtm_device_note1"
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
            0.6784313725490196,
            0.7294117647058823,
            0.807843137254902,
            1.0
          ],
          "text": "Pistă pentru analiză · ieșire audio mută",
          "presentation": 1,
          "presentation_rect": [
            16.0,
            135.0,
            330.0,
            18.0
          ],
          "fontname": "Segoe UI",
          "varname": "vtm_device_note2"
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
          "numoutlets": 4,
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
              640,
              370
            ],
            "openinpresentation": 1,
            "default_fontname": "Arial",
            "default_fontsize": 12.0,
            "bgcolor": [
              0.06666666666666667,
              0.09019607843137255,
              0.13333333333333333,
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
                  "id": "studio-canvas",
                  "maxclass": "panel",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    420.0,
                    2170.0,
                    185.0,
                    22.0
                  ],
                  "bgcolor": [
                    0.06666666666666667,
                    0.09019607843137255,
                    0.13333333333333333,
                    1.0
                  ],
                  "border": 0,
                  "rounded": 0,
                  "background": 1,
                  "ignoreclick": 1,
                  "presentation": 1,
                  "presentation_rect": [
                    0.0,
                    0.0,
                    640.0,
                    760.0
                  ],
                  "varname": "vtm_ui_studio_canvas"
                }
              },
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
                  "numoutlets": 26,
                  "patching_rect": [
                    220.0,
                    460.0,
                    185.0,
                    22.0
                  ],
                  "text": "route state delta count level tests raw sync maxdev disarm init api hasdelta stopnote wave_type wave_channel wave_types wave_channels wave_samples beatlevel latencyoffset latencystatus latencyreason latencydiagnostics latencycancelreason autocalvalid"
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
                  "text": "window flags float nogrow nozoom, window size 60 50 700 420, window exec"
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
                  "fontsize": 20.0,
                  "textcolor": [
                    0.9450980392156862,
                    0.9607843137254902,
                    0.984313725490196,
                    1.0
                  ],
                  "fontface": 1,
                  "text": "Vocal Timing Monitor",
                  "presentation": 1,
                  "presentation_rect": [
                    16.0,
                    10.0,
                    350.0,
                    27.0
                  ],
                  "varname": "vtm_ui_title",
                  "fontname": "Segoe UI"
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
                  "fontsize": 11.0,
                  "textcolor": [
                    0.6784313725490196,
                    0.7294117647058823,
                    0.807843137254902,
                    1.0
                  ],
                  "text": "0.9 RC1.7.1  ·  reper ritmic în timp real",
                  "presentation": 1,
                  "presentation_rect": [
                    17.0,
                    37.0,
                    320.0,
                    17
                  ],
                  "varname": "vtm_ui_version",
                  "fontname": "Segoe UI"
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
                    0.10588235294117647,
                    0.1411764705882353,
                    0.19607843137254902,
                    1.0
                  ],
                  "border": 0,
                  "rounded": 12,
                  "background": 1,
                  "ignoreclick": 1,
                  "presentation": 1,
                  "presentation_rect": [
                    16.0,
                    60.0,
                    608.0,
                    80.0
                  ],
                  "varname": "vtm_ui_state_card"
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
                  "fontsize": 21.0,
                  "textcolor": [
                    0.9450980392156862,
                    0.9607843137254902,
                    0.984313725490196,
                    1.0
                  ],
                  "fontface": 1,
                  "text": "Pornește redarea",
                  "hint": "Ultimul atac fata de grila Live. Verde: aproape; galben: decalaj moderat; rosu: pragul Auto Stop atins. Nu e evaluarea flow-ului.",
                  "presentation": 1,
                  "presentation_rect": [
                    65.0,
                    72.0,
                    343.0,
                    29.0
                  ],
                  "varname": "vtm_ui_state_text",
                  "fontname": "Segoe UI"
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
                  "fontsize": 12.0,
                  "textcolor": [
                    0.6784313725490196,
                    0.7294117647058823,
                    0.807843137254902,
                    1.0
                  ],
                  "text": "Pornește redarea în Ableton",
                  "presentation": 1,
                  "presentation_rect": [
                    32.0,
                    109.0,
                    365.0,
                    18.0
                  ],
                  "varname": "vtm_ui_clock_text",
                  "fontname": "Segoe UI"
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
                  "fontsize": 11.0,
                  "textcolor": [
                    0.6784313725490196,
                    0.7294117647058823,
                    0.807843137254902,
                    1.0
                  ],
                  "text": "Auto Stop: initializare conexiune",
                  "presentation": 1,
                  "presentation_rect": [
                    32.0,
                    670.0,
                    440.0,
                    17
                  ],
                  "varname": "vtm_ui_api_text",
                  "hidden": 1,
                  "fontname": "Segoe UI"
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
                  "fontsize": 28.0,
                  "textcolor": [
                    0.9450980392156862,
                    0.9607843137254902,
                    0.984313725490196,
                    1.0
                  ],
                  "fontface": 1,
                  "text": "--",
                  "presentation": 1,
                  "presentation_rect": [
                    420.0,
                    65.0,
                    188.0,
                    43.0
                  ],
                  "varname": "vtm_ui_delta_text",
                  "textjustification": 2,
                  "fontname": "Segoe UI"
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
                  "fontsize": 11.0,
                  "textcolor": [
                    0.6784313725490196,
                    0.7294117647058823,
                    0.807843137254902,
                    1.0
                  ],
                  "text": "Față de grila din Ableton",
                  "presentation": 1,
                  "presentation_rect": [
                    404.0,
                    113.0,
                    204.0,
                    17.0
                  ],
                  "varname": "vtm_ui_sign_caption",
                  "textjustification": 2,
                  "fontname": "Segoe UI"
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
                    0.6784313725490196,
                    0.7294117647058823,
                    0.807843137254902,
                    1.0
                  ],
                  "text": "ATACURI",
                  "presentation": 1,
                  "presentation_rect": [
                    524.0,
                    146.0,
                    100.0,
                    15.0
                  ],
                  "varname": "vtm_ui_count_caption",
                  "textjustification": 2,
                  "fontname": "Segoe UI"
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
                  "fontsize": 16.0,
                  "textcolor": [
                    0.9450980392156862,
                    0.9607843137254902,
                    0.984313725490196,
                    1.0
                  ],
                  "fontface": 1,
                  "text": "0",
                  "presentation": 1,
                  "presentation_rect": [
                    524.0,
                    161.0,
                    100.0,
                    24.0
                  ],
                  "varname": "vtm_ui_count_text",
                  "textjustification": 2,
                  "fontname": "Segoe UI"
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
                    0.6784313725490196,
                    0.7294117647058823,
                    0.807843137254902,
                    1.0
                  ],
                  "text": "Teste: 0",
                  "presentation": 1,
                  "presentation_rect": [
                    32.0,
                    696.0,
                    110.0,
                    15.0
                  ],
                  "varname": "vtm_ui_tests_text",
                  "hidden": 1,
                  "fontname": "Segoe UI"
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
                  "texton": "Analiză activă",
                  "mode": 1,
                  "parameter_enable": 1,
                  "rounded": 8.0,
                  "fontsize": 12.0,
                  "fontface": 1,
                  "textcolor": [
                    0.9450980392156862,
                    0.9607843137254902,
                    0.984313725490196,
                    1.0
                  ],
                  "textoncolor": [
                    0.8509803921568627,
                    0.9725490196078431,
                    1.0,
                    1.0
                  ],
                  "bgcolor": [
                    0.06666666666666667,
                    0.10588235294117647,
                    0.1568627450980392,
                    1.0
                  ],
                  "bgoncolor": [
                    0.12941176470588237,
                    0.28627450980392155,
                    0.3411764705882353,
                    1.0
                  ],
                  "usegradient": 0,
                  "usebgoncolor": 1,
                  "outputmode": 1,
                  "text": "Analiză oprită",
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
                  },
                  "presentation": 1,
                  "presentation_rect": [
                    16.0,
                    150.0,
                    140.0,
                    30.0
                  ],
                  "fontname": "Segoe UI",
                  "usetextovercolor": 1,
                  "textovercolor": [
                    0.9450980392156862,
                    0.9607843137254902,
                    0.984313725490196,
                    1.0
                  ]
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
                  "texton": "Oprire auto: ON",
                  "mode": 1,
                  "parameter_enable": 0,
                  "rounded": 8.0,
                  "fontsize": 12.0,
                  "fontface": 1,
                  "textcolor": [
                    0.9450980392156862,
                    0.9607843137254902,
                    0.984313725490196,
                    1.0
                  ],
                  "textoncolor": [
                    1.0,
                    0.8588235294117647,
                    0.615686274509804,
                    1.0
                  ],
                  "bgcolor": [
                    0.06666666666666667,
                    0.10588235294117647,
                    0.1568627450980392,
                    1.0
                  ],
                  "bgoncolor": [
                    0.3176470588235294,
                    0.25098039215686274,
                    0.13333333333333333,
                    1.0
                  ],
                  "usegradient": 0,
                  "usebgoncolor": 1,
                  "outputmode": 1,
                  "text": "Oprire auto: OFF",
                  "hint": "Rămâne ON între take-uri. Oprește la prima abatere peste toleranță. La redeschiderea proiectului pornește OFF.",
                  "presentation": 1,
                  "presentation_rect": [
                    166.0,
                    150.0,
                    166.0,
                    30.0
                  ],
                  "varname": "vtm_ui_autostop",
                  "fontname": "Segoe UI",
                  "usetextovercolor": 1,
                  "textovercolor": [
                    0.9450980392156862,
                    0.9607843137254902,
                    0.984313725490196,
                    1.0
                  ]
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
                  "texton": "Test afișare",
                  "mode": 1,
                  "parameter_enable": 0,
                  "rounded": 8.0,
                  "fontsize": 11.0,
                  "fontface": 1,
                  "textcolor": [
                    0.9450980392156862,
                    0.9607843137254902,
                    0.984313725490196,
                    1.0
                  ],
                  "textoncolor": [
                    0.9450980392156862,
                    0.9607843137254902,
                    0.984313725490196,
                    1.0
                  ],
                  "bgcolor": [
                    0.06666666666666667,
                    0.10588235294117647,
                    0.1568627450980392,
                    1.0
                  ],
                  "bgoncolor": [
                    0.06666666666666667,
                    0.10588235294117647,
                    0.1568627450980392,
                    1.0
                  ],
                  "usegradient": 0,
                  "usebgoncolor": 1,
                  "outputmode": 1,
                  "text": "Test afișare",
                  "presentation": 1,
                  "presentation_rect": [
                    488.0,
                    668.0,
                    120.0,
                    28.0
                  ],
                  "varname": "vtm_ui_test",
                  "hidden": 1,
                  "fontname": "Segoe UI",
                  "usetextovercolor": 1,
                  "textovercolor": [
                    0.9450980392156862,
                    0.9607843137254902,
                    0.984313725490196,
                    1.0
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
                  "texton": "Resetează măsurătorile",
                  "mode": 1,
                  "parameter_enable": 0,
                  "rounded": 8.0,
                  "fontsize": 11.0,
                  "fontface": 1,
                  "textcolor": [
                    0.9450980392156862,
                    0.9607843137254902,
                    0.984313725490196,
                    1.0
                  ],
                  "textoncolor": [
                    0.9450980392156862,
                    0.9607843137254902,
                    0.984313725490196,
                    1.0
                  ],
                  "bgcolor": [
                    0.06666666666666667,
                    0.10588235294117647,
                    0.1568627450980392,
                    1.0
                  ],
                  "bgoncolor": [
                    0.06666666666666667,
                    0.10588235294117647,
                    0.1568627450980392,
                    1.0
                  ],
                  "usegradient": 0,
                  "usebgoncolor": 1,
                  "outputmode": 1,
                  "text": "Resetează măsurătorile",
                  "presentation": 1,
                  "presentation_rect": [
                    342.0,
                    150.0,
                    166.0,
                    30.0
                  ],
                  "varname": "vtm_ui_reset",
                  "hint": "Resetează contorul și rezultatul. Setările rămân; oprirea automată este dezarmată.",
                  "fontname": "Segoe UI",
                  "usetextovercolor": 1,
                  "textovercolor": [
                    0.9450980392156862,
                    0.9607843137254902,
                    0.984313725490196,
                    1.0
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
                  "fontsize": 11.0,
                  "textcolor": [
                    0.6784313725490196,
                    0.7294117647058823,
                    0.807843137254902,
                    1.0
                  ],
                  "hint": "Varful audio brut pe ultimele 600 ms, inaintea detectorului.",
                  "text": "Intrare: -- dB",
                  "presentation": 1,
                  "presentation_rect": [
                    388.0,
                    195.0,
                    224.0,
                    17
                  ],
                  "varname": "vtm_ui_level_text",
                  "textjustification": 2,
                  "fontname": "Segoe UI"
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
                  "fontsize": 11.0,
                  "textcolor": [
                    0.6784313725490196,
                    0.7294117647058823,
                    0.807843137254902,
                    1.0
                  ],
                  "text": "Grilă ritmică",
                  "presentation": 1,
                  "presentation_rect": [
                    32.0,
                    423.0,
                    128.0,
                    17
                  ],
                  "varname": "vtm_ui_grid_caption",
                  "hidden": 0,
                  "fontname": "Segoe UI"
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
                    0.06666666666666667,
                    0.10588235294117647,
                    0.1568627450980392,
                    1.0
                  ],
                  "textcolor": [
                    0.9450980392156862,
                    0.9607843137254902,
                    0.984313725490196,
                    1.0
                  ],
                  "parameter_enable": 1,
                  "fontsize": 14.0,
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
                  },
                  "presentation": 1,
                  "presentation_rect": [
                    32.0,
                    446.0,
                    128.0,
                    29.0
                  ],
                  "hidden": 0,
                  "fontname": "Segoe UI"
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
                  "fontsize": 11.0,
                  "textcolor": [
                    0.6784313725490196,
                    0.7294117647058823,
                    0.807843137254902,
                    1.0
                  ],
                  "text": "Toleranță (±ms)",
                  "presentation": 1,
                  "presentation_rect": [
                    184.0,
                    423.0,
                    126.0,
                    17
                  ],
                  "varname": "vtm_ui_redms_label",
                  "hidden": 0,
                  "fontname": "Segoe UI"
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
                    0.06666666666666667,
                    0.10588235294117647,
                    0.1568627450980392,
                    1.0
                  ],
                  "textcolor": [
                    0.9450980392156862,
                    0.9607843137254902,
                    0.984313725490196,
                    1.0
                  ],
                  "triangle": 0,
                  "parameter_enable": 1,
                  "format": 0,
                  "fontsize": 14.0,
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
                  },
                  "presentation": 1,
                  "presentation_rect": [
                    184.0,
                    446.0,
                    100.0,
                    29.0
                  ],
                  "hidden": 0,
                  "hint": "Abaterea permisă în milisecunde. Controlează și oprirea automată.",
                  "fontname": "Segoe UI"
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
                  "fontsize": 11.0,
                  "textcolor": [
                    0.6784313725490196,
                    0.7294117647058823,
                    0.807843137254902,
                    1.0
                  ],
                  "text": "Compensarea întârzierii (ms)",
                  "presentation": 1,
                  "presentation_rect": [
                    32.0,
                    452.0,
                    200.0,
                    17
                  ],
                  "varname": "vtm_ui_offsetms_label",
                  "hidden": 1,
                  "fontname": "Segoe UI"
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
                    0.06666666666666667,
                    0.10588235294117647,
                    0.1568627450980392,
                    1.0
                  ],
                  "textcolor": [
                    0.9450980392156862,
                    0.9607843137254902,
                    0.984313725490196,
                    1.0
                  ],
                  "triangle": 0,
                  "parameter_enable": 1,
                  "format": 6,
                  "fontsize": 14.0,
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
                  },
                  "presentation": 1,
                  "presentation_rect": [
                    32.0,
                    476.0,
                    124.0,
                    30.0
                  ],
                  "hidden": 1,
                  "fontname": "Segoe UI"
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
                  "fontsize": 11.0,
                  "textcolor": [
                    0.6784313725490196,
                    0.7294117647058823,
                    0.807843137254902,
                    1.0
                  ],
                  "text": "Prag de detecție (dB)",
                  "presentation": 1,
                  "presentation_rect": [
                    32.0,
                    540.0,
                    140.0,
                    17
                  ],
                  "varname": "vtm_ui_gatedb_label",
                  "hidden": 0,
                  "fontname": "Segoe UI"
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
                    0.06666666666666667,
                    0.10588235294117647,
                    0.1568627450980392,
                    1.0
                  ],
                  "textcolor": [
                    0.9450980392156862,
                    0.9607843137254902,
                    0.984313725490196,
                    1.0
                  ],
                  "triangle": 0,
                  "parameter_enable": 1,
                  "format": 6,
                  "fontsize": 14.0,
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
                  },
                  "presentation": 1,
                  "presentation_rect": [
                    32.0,
                    561.0,
                    104.0,
                    29.0
                  ],
                  "hidden": 0,
                  "fontname": "Segoe UI"
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
                  "texton": "Preia întârzierea",
                  "mode": 1,
                  "parameter_enable": 0,
                  "rounded": 8.0,
                  "fontsize": 12.0,
                  "fontface": 1,
                  "textcolor": [
                    0.9450980392156862,
                    0.9607843137254902,
                    0.984313725490196,
                    1.0
                  ],
                  "textoncolor": [
                    0.9450980392156862,
                    0.9607843137254902,
                    0.984313725490196,
                    1.0
                  ],
                  "bgcolor": [
                    0.06666666666666667,
                    0.10588235294117647,
                    0.1568627450980392,
                    1.0
                  ],
                  "bgoncolor": [
                    0.06666666666666667,
                    0.10588235294117647,
                    0.1568627450980392,
                    1.0
                  ],
                  "usegradient": 0,
                  "usebgoncolor": 1,
                  "outputmode": 1,
                  "text": "Preia întârzierea",
                  "active": 1,
                  "hint": "Măsoară diferența dintre instrumentalul digital și cel captat de microfon, fără voce. Necesită difuzoare audibile în microfon. Nu deduce latența din ritmul vocii.",
                  "presentation": 1,
                  "presentation_rect": [
                    180.0,
                    476.0,
                    204.0,
                    30.0
                  ],
                  "varname": "vtm_ui_calibrate",
                  "hidden": 1,
                  "fontname": "Segoe UI",
                  "usetextovercolor": 1,
                  "textovercolor": [
                    0.9450980392156862,
                    0.9607843137254902,
                    0.984313725490196,
                    1.0
                  ]
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
                  "fontsize": 10.0,
                  "textcolor": [
                    0.6784313725490196,
                    0.7294117647058823,
                    0.807843137254902,
                    1.0
                  ],
                  "text": "Limita grilei: -- ms",
                  "presentation": 1,
                  "presentation_rect": [
                    154.0,
                    696.0,
                    454.0,
                    15.0
                  ],
                  "varname": "vtm_ui_limit_text",
                  "hidden": 1,
                  "fontname": "Segoe UI"
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
                  "fontsize": 11.0,
                  "textcolor": [
                    0.6784313725490196,
                    0.7294117647058823,
                    0.807843137254902,
                    1.0
                  ],
                  "text": "Setările se păstrează în proiect cu Ctrl+S. Oprirea automată pornește OFF.",
                  "presentation": 1,
                  "presentation_rect": [
                    16.0,
                    734.0,
                    608.0,
                    17.0
                  ],
                  "varname": "vtm_ui_footer2",
                  "textjustification": 1,
                  "fontname": "Segoe UI"
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
                  "text": "set Analiză oprită"
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
                  "text": "textcolor 0.6784313725490196 0.7294117647058823 0.807843137254902 1.0"
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
                  "text": "set Pornește redarea"
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
                  "text": "textcolor 0.6784313725490196 0.7294117647058823 0.807843137254902 1.0"
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
                  "text": "set Se sincronizează"
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
                  "text": "textcolor 1.0 0.8 0.47058823529411764 1.0"
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
                  "text": "set Pregătit să te asculte"
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
                  "text": "textcolor 0.40784313725490196 0.8431372549019608 0.9294117647058824 1.0"
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
                  "text": "set Aproape de grilă"
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
                  "text": "textcolor 0.39215686274509803 0.8470588235294118 0.6705882352941176 1.0"
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
                  "text": "set Decalaj moderat"
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
                  "text": "textcolor 1.0 0.8 0.47058823529411764 1.0"
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
                  "text": "set Peste toleranță"
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
                  "text": "textcolor 1.0 0.5411764705882353 0.6078431372549019 1.0"
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
                  "text": "set Test de afișare"
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
                  "text": "textcolor 0.40784313725490196 0.8431372549019608 0.9294117647058824 1.0"
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
                  "text": "set Pornește redarea"
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
                  "text": "textcolor 1.0 0.8 0.47058823529411764 1.0"
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
                  "text": "set Se oprește redarea"
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
                  "text": "textcolor 1.0 0.5411764705882353 0.6078431372549019 1.0"
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
                  "text": "set Verifică motorul audio"
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
                  "text": "textcolor 1.0 0.8 0.47058823529411764 1.0"
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
                  "text": "sprintf Nivel: %.1f dB"
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
                  "text": "sprintf Abatere maximă a grilei: ±%.0f ms"
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
                  "text": "set Pornește redarea în Ableton"
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
                  "text": "set Redarea este sincronizată"
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
                  "fontsize": 12.0,
                  "textcolor": [
                    0.40784313725490196,
                    0.8431372549019608,
                    0.9294117647058824,
                    1.0
                  ],
                  "fontface": 1,
                  "text": "Microfon",
                  "presentation": 1,
                  "presentation_rect": [
                    28.0,
                    195.0,
                    250.0,
                    18
                  ],
                  "varname": "vtm_ui_voice_caption",
                  "fontname": "Segoe UI"
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
                  "fontsize": 12.0,
                  "textcolor": [
                    0.6784313725490196,
                    0.7294117647058823,
                    0.807843137254902,
                    1.0
                  ],
                  "text": "Microfon",
                  "presentation": 1,
                  "presentation_rect": [
                    32.0,
                    611.0,
                    120.0,
                    18
                  ],
                  "varname": "vtm_ui_voice_gain_caption",
                  "hidden": 1,
                  "fontname": "Segoe UI"
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
                  "fontsize": 12.0,
                  "textcolor": [
                    0.39215686274509803,
                    0.8470588235294118,
                    0.6705882352941176,
                    1.0
                  ],
                  "fontface": 1,
                  "text": "Instrumental",
                  "presentation": 1,
                  "presentation_rect": [
                    28.0,
                    282.0,
                    250.0,
                    18
                  ],
                  "varname": "vtm_ui_beat_caption",
                  "fontname": "Segoe UI"
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
                  "fontsize": 11.0,
                  "textcolor": [
                    0.6784313725490196,
                    0.7294117647058823,
                    0.807843137254902,
                    1.0
                  ],
                  "text": "Beat: -- dB",
                  "presentation": 1,
                  "presentation_rect": [
                    388.0,
                    282.0,
                    224.0,
                    17
                  ],
                  "varname": "vtm_ui_beat_level",
                  "textjustification": 2,
                  "fontname": "Segoe UI"
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
                  "fontsize": 12.0,
                  "textcolor": [
                    0.6784313725490196,
                    0.7294117647058823,
                    0.807843137254902,
                    1.0
                  ],
                  "text": "Instrumental",
                  "presentation": 1,
                  "presentation_rect": [
                    320.0,
                    611.0,
                    140.0,
                    18
                  ],
                  "varname": "vtm_ui_beat_gain_caption",
                  "hidden": 1,
                  "fontname": "Segoe UI"
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
                    0.10588235294117647,
                    0.1411764705882353,
                    0.19607843137254902,
                    1.0
                  ],
                  "activebgcolor": [
                    0.10588235294117647,
                    0.1411764705882353,
                    0.19607843137254902,
                    1.0
                  ],
                  "linecolor": [
                    0.40784313725490196,
                    0.8431372549019608,
                    0.9294117647058824,
                    1.0
                  ],
                  "activelinecolor": [
                    0.40784313725490196,
                    0.8431372549019608,
                    0.9294117647058824,
                    1.0
                  ],
                  "parameter_enable": 0,
                  "ignoreclick": 1,
                  "presentation": 1,
                  "presentation_rect": [
                    28.0,
                    216.0,
                    584.0,
                    38.0
                  ],
                  "varname": "vtm_ui_voice_scope"
                }
              },
              {
                "box": {
                  "id": "voice-gain",
                  "maxclass": "live.numbox",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "patching_rect": [
                    20.0,
                    1450.0,
                    185.0,
                    22.0
                  ],
                  "textcolor": [
                    0.9450980392156862,
                    0.9607843137254902,
                    0.984313725490196,
                    1.0
                  ],
                  "parameter_enable": 1,
                  "fontsize": 14.0,
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
                      "parameter_mmax": 8.0,
                      "parameter_unitstyle": 9,
                      "parameter_units": "%g×"
                    }
                  },
                  "presentation": 1,
                  "presentation_rect": [
                    160.0,
                    604.0,
                    72.0,
                    29.0
                  ],
                  "hidden": 1,
                  "outlettype": [
                    "",
                    "float"
                  ],
                  "appearance": 4,
                  "active": 1,
                  "textjustification": 1,
                  "hint": "Mărire vizuală de la 1× la 8×. Acceptă și 2.5×. Nu schimbă sunetul sau detecția.",
                  "fontname": "Segoe UI",
                  "activebgcolor": [
                    0.06666666666666667,
                    0.10588235294117647,
                    0.1568627450980392,
                    1.0
                  ],
                  "lcdbgcolor": [
                    0.06666666666666667,
                    0.10588235294117647,
                    0.1568627450980392,
                    1.0
                  ],
                  "lcdcolor": [
                    0.9450980392156862,
                    0.9607843137254902,
                    0.984313725490196,
                    1.0
                  ],
                  "inactivelcdcolor": [
                    0.9450980392156862,
                    0.9607843137254902,
                    0.984313725490196,
                    1.0
                  ],
                  "bordercolor": [
                    0.20392156862745098,
                    0.26666666666666666,
                    0.34509803921568627,
                    1.0
                  ],
                  "focusbordercolor": [
                    0.40784313725490196,
                    0.8431372549019608,
                    0.9294117647058824,
                    1.0
                  ]
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
                    0.10588235294117647,
                    0.1411764705882353,
                    0.19607843137254902,
                    1.0
                  ],
                  "activebgcolor": [
                    0.10588235294117647,
                    0.1411764705882353,
                    0.19607843137254902,
                    1.0
                  ],
                  "linecolor": [
                    1.0,
                    0.8,
                    0.47058823529411764,
                    1.0
                  ],
                  "activelinecolor": [
                    1.0,
                    0.8,
                    0.47058823529411764,
                    1.0
                  ],
                  "parameter_enable": 0,
                  "ignoreclick": 1,
                  "hint": "Reperele grilei Live, pe aceeasi axa de 6 secunde.",
                  "presentation": 1,
                  "presentation_rect": [
                    28.0,
                    258.0,
                    584.0,
                    8.0
                  ],
                  "varname": "vtm_ui_grid_scope"
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
                    0.10588235294117647,
                    0.1411764705882353,
                    0.19607843137254902,
                    1.0
                  ],
                  "activebgcolor": [
                    0.10588235294117647,
                    0.1411764705882353,
                    0.19607843137254902,
                    1.0
                  ],
                  "linecolor": [
                    0.39215686274509803,
                    0.8470588235294118,
                    0.6705882352941176,
                    1.0
                  ],
                  "activelinecolor": [
                    0.39215686274509803,
                    0.8470588235294118,
                    0.6705882352941176,
                    1.0
                  ],
                  "parameter_enable": 0,
                  "ignoreclick": 1,
                  "presentation": 1,
                  "presentation_rect": [
                    28.0,
                    303.0,
                    584.0,
                    34.0
                  ],
                  "varname": "vtm_ui_beat_scope"
                }
              },
              {
                "box": {
                  "id": "beat-gain",
                  "maxclass": "live.numbox",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "patching_rect": [
                    1020.0,
                    1450.0,
                    185.0,
                    22.0
                  ],
                  "textcolor": [
                    0.9450980392156862,
                    0.9607843137254902,
                    0.984313725490196,
                    1.0
                  ],
                  "parameter_enable": 1,
                  "fontsize": 14.0,
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
                      "parameter_mmax": 8.0,
                      "parameter_unitstyle": 9,
                      "parameter_units": "%g×"
                    }
                  },
                  "presentation": 1,
                  "presentation_rect": [
                    474.0,
                    604.0,
                    72.0,
                    29.0
                  ],
                  "hidden": 1,
                  "outlettype": [
                    "",
                    "float"
                  ],
                  "appearance": 4,
                  "active": 1,
                  "textjustification": 1,
                  "hint": "Mărire vizuală de la 1× la 8×. Acceptă și 2.5×. Nu schimbă sunetul sau detecția.",
                  "fontname": "Segoe UI",
                  "activebgcolor": [
                    0.06666666666666667,
                    0.10588235294117647,
                    0.1568627450980392,
                    1.0
                  ],
                  "lcdbgcolor": [
                    0.06666666666666667,
                    0.10588235294117647,
                    0.1568627450980392,
                    1.0
                  ],
                  "lcdcolor": [
                    0.9450980392156862,
                    0.9607843137254902,
                    0.984313725490196,
                    1.0
                  ],
                  "inactivelcdcolor": [
                    0.9450980392156862,
                    0.9607843137254902,
                    0.984313725490196,
                    1.0
                  ],
                  "bordercolor": [
                    0.20392156862745098,
                    0.26666666666666666,
                    0.34509803921568627,
                    1.0
                  ],
                  "focusbordercolor": [
                    0.40784313725490196,
                    0.8431372549019608,
                    0.9294117647058824,
                    1.0
                  ]
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
                  "fontsize": 10.0,
                  "textcolor": [
                    0.6784313725490196,
                    0.7294117647058823,
                    0.807843137254902,
                    1.0
                  ],
                  "text": "Acum 6 s",
                  "presentation": 1,
                  "presentation_rect": [
                    16.0,
                    343.0,
                    80.0,
                    15.0
                  ],
                  "varname": "vtm_ui_time_old",
                  "fontname": "Segoe UI"
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
                  "fontsize": 10.0,
                  "textcolor": [
                    0.6784313725490196,
                    0.7294117647058823,
                    0.807843137254902,
                    1.0
                  ],
                  "text": "Acum 3 s",
                  "presentation": 1,
                  "presentation_rect": [
                    292.0,
                    343.0,
                    80.0,
                    15.0
                  ],
                  "varname": "vtm_ui_time_mid",
                  "fontname": "Segoe UI"
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
                  "fontsize": 10.0,
                  "textcolor": [
                    0.6784313725490196,
                    0.7294117647058823,
                    0.807843137254902,
                    1.0
                  ],
                  "text": "Acum",
                  "presentation": 1,
                  "presentation_rect": [
                    578.0,
                    343.0,
                    46.0,
                    15.0
                  ],
                  "varname": "vtm_ui_time_now",
                  "fontname": "Segoe UI"
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
                  "fontsize": 13.0,
                  "textcolor": [
                    0.9450980392156862,
                    0.9607843137254902,
                    0.984313725490196,
                    1.0
                  ],
                  "text": "Instrumental · pista și punctul de preluare",
                  "presentation": 1,
                  "presentation_rect": [
                    32.0,
                    649.0,
                    450.0,
                    19
                  ],
                  "varname": "vtm_ui_beat_source_caption",
                  "hidden": 0,
                  "fontname": "Segoe UI"
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
                    0.06666666666666667,
                    0.10588235294117647,
                    0.1568627450980392,
                    1.0
                  ],
                  "textcolor": [
                    0.9450980392156862,
                    0.9607843137254902,
                    0.984313725490196,
                    1.0
                  ],
                  "fontsize": 12.0,
                  "presentation": 1,
                  "presentation_rect": [
                    32.0,
                    678.0,
                    292.0,
                    28.0
                  ],
                  "varname": "vtm_ui_beat_type",
                  "hidden": 0,
                  "fontname": "Segoe UI"
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
                    0.06666666666666667,
                    0.10588235294117647,
                    0.1568627450980392,
                    1.0
                  ],
                  "textcolor": [
                    0.9450980392156862,
                    0.9607843137254902,
                    0.984313725490196,
                    1.0
                  ],
                  "fontsize": 12.0,
                  "presentation": 1,
                  "presentation_rect": [
                    336.0,
                    678.0,
                    164.0,
                    28.0
                  ],
                  "varname": "vtm_ui_beat_channel",
                  "hidden": 0,
                  "fontname": "Segoe UI"
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
                  "texton": "Actualizează",
                  "mode": 1,
                  "parameter_enable": 0,
                  "rounded": 8.0,
                  "fontsize": 11.0,
                  "fontface": 1,
                  "textcolor": [
                    0.9450980392156862,
                    0.9607843137254902,
                    0.984313725490196,
                    1.0
                  ],
                  "textoncolor": [
                    0.9450980392156862,
                    0.9607843137254902,
                    0.984313725490196,
                    1.0
                  ],
                  "bgcolor": [
                    0.06666666666666667,
                    0.10588235294117647,
                    0.1568627450980392,
                    1.0
                  ],
                  "bgoncolor": [
                    0.06666666666666667,
                    0.10588235294117647,
                    0.1568627450980392,
                    1.0
                  ],
                  "usegradient": 0,
                  "usebgoncolor": 1,
                  "outputmode": 1,
                  "text": "Actualizează",
                  "presentation": 1,
                  "presentation_rect": [
                    512.0,
                    678.0,
                    96.0,
                    28.0
                  ],
                  "varname": "vtm_ui_beat_refresh",
                  "hidden": 0,
                  "fontname": "Segoe UI",
                  "usetextovercolor": 1,
                  "textovercolor": [
                    0.9450980392156862,
                    0.9607843137254902,
                    0.984313725490196,
                    1.0
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
                  "text": "Marirea vizuala nu schimba sunetul sau detectia."
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
                  "text": "sprintf Nivel: %.1f dB"
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
                  "ignoreclick": 1
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
                  "texton": "Închide",
                  "mode": 1,
                  "parameter_enable": 0,
                  "rounded": 8.0,
                  "fontsize": 12.0,
                  "fontface": 1,
                  "textcolor": [
                    0.9450980392156862,
                    0.9607843137254902,
                    0.984313725490196,
                    1.0
                  ],
                  "textoncolor": [
                    0.8509803921568627,
                    0.9725490196078431,
                    1.0,
                    1.0
                  ],
                  "bgcolor": [
                    0.06666666666666667,
                    0.10588235294117647,
                    0.1568627450980392,
                    1.0
                  ],
                  "bgoncolor": [
                    0.12941176470588237,
                    0.28627450980392155,
                    0.3411764705882353,
                    1.0
                  ],
                  "usegradient": 0,
                  "usebgoncolor": 1,
                  "outputmode": 1,
                  "text": "Setări",
                  "presentation": 1,
                  "presentation_rect": [
                    540.0,
                    12.0,
                    84.0,
                    30.0
                  ],
                  "varname": "vtm_ui_settings",
                  "fontname": "Segoe UI",
                  "usetextovercolor": 1,
                  "textovercolor": [
                    0.9450980392156862,
                    0.9607843137254902,
                    0.984313725490196,
                    1.0
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
                  "text": "expr 370 + 390 * $i1"
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
                  "text": "+ 640"
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
                  "text": "+ 370"
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
              },
              {
                "box": {
                  "id": "theme",
                  "maxclass": "textbutton",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "patching_rect": [
                    620.0,
                    2170.0,
                    185.0,
                    22.0
                  ],
                  "texton": "Temă: luminoasă",
                  "mode": 1,
                  "parameter_enable": 1,
                  "rounded": 8.0,
                  "fontsize": 12.0,
                  "fontface": 1,
                  "textcolor": [
                    0.9450980392156862,
                    0.9607843137254902,
                    0.984313725490196,
                    1.0
                  ],
                  "textoncolor": [
                    0.8509803921568627,
                    0.9725490196078431,
                    1.0,
                    1.0
                  ],
                  "bgcolor": [
                    0.06666666666666667,
                    0.10588235294117647,
                    0.1568627450980392,
                    1.0
                  ],
                  "bgoncolor": [
                    0.12941176470588237,
                    0.28627450980392155,
                    0.3411764705882353,
                    1.0
                  ],
                  "usegradient": 0,
                  "usebgoncolor": 1,
                  "outputmode": 1,
                  "text": "Temă: întunecată",
                  "presentation": 1,
                  "presentation_rect": [
                    386.0,
                    12.0,
                    144.0,
                    30.0
                  ],
                  "varname": "vtm_theme",
                  "parameter_mappable": 0,
                  "saved_attribute_attributes": {
                    "valueof": {
                      "parameter_longname": "VTM Theme",
                      "parameter_shortname": "VTM Theme",
                      "parameter_type": 1,
                      "parameter_invisible": 1,
                      "parameter_initial_enable": 1,
                      "parameter_initial": [
                        0
                      ],
                      "parameter_order": 12,
                      "parameter_mmin": 0.0,
                      "parameter_mmax": 1.0
                    }
                  },
                  "hint": "Schimbă tema. Alegerea se salvează cu proiectul Live (Ctrl+S).",
                  "fontname": "Segoe UI",
                  "usetextovercolor": 1,
                  "textovercolor": [
                    0.9450980392156862,
                    0.9607843137254902,
                    0.984313725490196,
                    1.0
                  ]
                }
              },
              {
                "box": {
                  "id": "status-mark",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    820.0,
                    2170.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 14.0,
                  "textcolor": [
                    0.9450980392156862,
                    0.9607843137254902,
                    0.984313725490196,
                    1.0
                  ],
                  "fontface": 1,
                  "text": ">",
                  "presentation": 1,
                  "presentation_rect": [
                    29.0,
                    77.0,
                    28.0,
                    23.0
                  ],
                  "varname": "vtm_ui_status_mark",
                  "fontname": "Segoe UI"
                }
              },
              {
                "box": {
                  "id": "voice-card",
                  "maxclass": "panel",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    1020.0,
                    2170.0,
                    185.0,
                    22.0
                  ],
                  "bgcolor": [
                    0.10588235294117647,
                    0.1411764705882353,
                    0.19607843137254902,
                    1.0
                  ],
                  "border": 0,
                  "rounded": 12,
                  "background": 1,
                  "ignoreclick": 1,
                  "presentation": 1,
                  "presentation_rect": [
                    16.0,
                    190.0,
                    608.0,
                    80.0
                  ],
                  "varname": "vtm_ui_voice_card"
                }
              },
              {
                "box": {
                  "id": "beat-card",
                  "maxclass": "panel",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    20.0,
                    2215.0,
                    185.0,
                    22.0
                  ],
                  "bgcolor": [
                    0.10588235294117647,
                    0.1411764705882353,
                    0.19607843137254902,
                    1.0
                  ],
                  "border": 0,
                  "rounded": 12,
                  "background": 1,
                  "ignoreclick": 1,
                  "presentation": 1,
                  "presentation_rect": [
                    16.0,
                    278.0,
                    608.0,
                    64.0
                  ],
                  "varname": "vtm_ui_beat_card"
                }
              },
              {
                "box": {
                  "id": "settings-heading",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    220.0,
                    2215.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 16.0,
                  "textcolor": [
                    0.9450980392156862,
                    0.9607843137254902,
                    0.984313725490196,
                    1.0
                  ],
                  "fontface": 1,
                  "text": "Setări uzuale",
                  "presentation": 1,
                  "presentation_rect": [
                    16.0,
                    376.0,
                    420.0,
                    23
                  ],
                  "varname": "vtm_ui_settings_heading",
                  "fontname": "Segoe UI"
                }
              },
              {
                "box": {
                  "id": "advanced",
                  "maxclass": "textbutton",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "patching_rect": [
                    420.0,
                    2215.0,
                    185.0,
                    22.0
                  ],
                  "texton": "Înapoi la setări",
                  "mode": 1,
                  "parameter_enable": 0,
                  "rounded": 8.0,
                  "fontsize": 12.0,
                  "fontface": 1,
                  "textcolor": [
                    0.9450980392156862,
                    0.9607843137254902,
                    0.984313725490196,
                    1.0
                  ],
                  "textoncolor": [
                    0.8509803921568627,
                    0.9725490196078431,
                    1.0,
                    1.0
                  ],
                  "bgcolor": [
                    0.06666666666666667,
                    0.10588235294117647,
                    0.1568627450980392,
                    1.0
                  ],
                  "bgoncolor": [
                    0.12941176470588237,
                    0.28627450980392155,
                    0.3411764705882353,
                    1.0
                  ],
                  "usegradient": 0,
                  "usebgoncolor": 1,
                  "outputmode": 1,
                  "text": "Avansat",
                  "presentation": 1,
                  "presentation_rect": [
                    472.0,
                    372.0,
                    152.0,
                    30.0
                  ],
                  "varname": "vtm_ui_advanced",
                  "hint": "Compensare, calibrare, mărire vizuală și diagnostic.",
                  "fontname": "Segoe UI",
                  "usetextovercolor": 1,
                  "textovercolor": [
                    0.9450980392156862,
                    0.9607843137254902,
                    0.984313725490196,
                    1.0
                  ]
                }
              },
              {
                "box": {
                  "id": "rhythm-card",
                  "maxclass": "panel",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    620.0,
                    2215.0,
                    185.0,
                    22.0
                  ],
                  "bgcolor": [
                    0.10588235294117647,
                    0.1411764705882353,
                    0.19607843137254902,
                    1.0
                  ],
                  "border": 0,
                  "rounded": 12,
                  "background": 1,
                  "ignoreclick": 1,
                  "presentation": 1,
                  "presentation_rect": [
                    16.0,
                    410.0,
                    608.0,
                    80.0
                  ],
                  "varname": "vtm_ui_rhythm_card",
                  "hidden": 0
                }
              },
              {
                "box": {
                  "id": "rhythm-hint",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    820.0,
                    2215.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 11.0,
                  "textcolor": [
                    0.6784313725490196,
                    0.7294117647058823,
                    0.807843137254902,
                    1.0
                  ],
                  "fontface": 0,
                  "text": "Abaterea permisă față de grilă.",
                  "presentation": 1,
                  "presentation_rect": [
                    316.0,
                    429.0,
                    288.0,
                    42.0
                  ],
                  "varname": "vtm_ui_rhythm_hint",
                  "hidden": 0,
                  "fontname": "Segoe UI"
                }
              },
              {
                "box": {
                  "id": "mic-card",
                  "maxclass": "panel",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    1020.0,
                    2215.0,
                    185.0,
                    22.0
                  ],
                  "bgcolor": [
                    0.10588235294117647,
                    0.1411764705882353,
                    0.19607843137254902,
                    1.0
                  ],
                  "border": 0,
                  "rounded": 12,
                  "background": 1,
                  "ignoreclick": 1,
                  "presentation": 1,
                  "presentation_rect": [
                    16.0,
                    502.0,
                    608.0,
                    124.0
                  ],
                  "varname": "vtm_ui_mic_card",
                  "hidden": 0
                }
              },
              {
                "box": {
                  "id": "mic-heading",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    20.0,
                    2260.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 14.0,
                  "textcolor": [
                    0.9450980392156862,
                    0.9607843137254902,
                    0.984313725490196,
                    1.0
                  ],
                  "fontface": 1,
                  "text": "Microfon și detecție",
                  "presentation": 1,
                  "presentation_rect": [
                    32.0,
                    512.0,
                    350.0,
                    20.0
                  ],
                  "varname": "vtm_ui_mic_heading",
                  "hidden": 0,
                  "fontname": "Segoe UI"
                }
              },
              {
                "box": {
                  "id": "gate-help",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    220.0,
                    2260.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 11.0,
                  "textcolor": [
                    0.6784313725490196,
                    0.7294117647058823,
                    0.807843137254902,
                    1.0
                  ],
                  "fontface": 0,
                  "text": "Mai negativ =\nmai sensibil",
                  "presentation": 1,
                  "presentation_rect": [
                    32.0,
                    595.0,
                    130.0,
                    30
                  ],
                  "varname": "vtm_ui_gate_help",
                  "hidden": 0,
                  "fontname": "Segoe UI"
                }
              },
              {
                "box": {
                  "id": "meter-caption",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    420.0,
                    2260.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 11.0,
                  "textcolor": [
                    0.6784313725490196,
                    0.7294117647058823,
                    0.807843137254902,
                    1.0
                  ],
                  "fontface": 0,
                  "text": "Nivel brut și prag ales · reper vizual",
                  "presentation": 1,
                  "presentation_rect": [
                    174.0,
                    536.0,
                    432.0,
                    17
                  ],
                  "varname": "vtm_ui_meter_caption",
                  "hidden": 0,
                  "fontname": "Segoe UI"
                }
              },
              {
                "box": {
                  "id": "input-meter",
                  "maxclass": "multislider",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "patching_rect": [
                    620.0,
                    2260.0,
                    185.0,
                    22.0
                  ],
                  "size": 1,
                  "listresize": 0,
                  "settype": 1,
                  "setstyle": 1,
                  "orientation": 0,
                  "setminmax": [
                    -60.0,
                    0.0
                  ],
                  "slidercolor": [
                    0.40784313725490196,
                    0.8431372549019608,
                    0.9294117647058824,
                    1.0
                  ],
                  "bgcolor": [
                    0.06666666666666667,
                    0.10588235294117647,
                    0.1568627450980392,
                    1.0
                  ],
                  "thickness": 2,
                  "signed": 0,
                  "parameter_enable": 0,
                  "ignoreclick": 1,
                  "presentation": 1,
                  "presentation_rect": [
                    174.0,
                    558.0,
                    432.0,
                    13.0
                  ],
                  "varname": "vtm_ui_input_meter",
                  "hidden": 0,
                  "hint": "Nivel brut de vârf pe 600 ms; marcajul arată pragul ales. Detectorul folosește și filtrare, anvelopă, zgomot și rearmare. Depășirea marcajului nu garantează un atac."
                }
              },
              {
                "box": {
                  "id": "threshold-meter",
                  "maxclass": "multislider",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "patching_rect": [
                    820.0,
                    2260.0,
                    185.0,
                    22.0
                  ],
                  "size": 1,
                  "listresize": 0,
                  "settype": 1,
                  "setstyle": 0,
                  "orientation": 0,
                  "setminmax": [
                    -60.0,
                    0.0
                  ],
                  "slidercolor": [
                    1.0,
                    0.8,
                    0.47058823529411764,
                    1.0
                  ],
                  "bgcolor": [
                    0.06666666666666667,
                    0.10588235294117647,
                    0.1568627450980392,
                    1.0
                  ],
                  "thickness": 2,
                  "signed": 0,
                  "parameter_enable": 0,
                  "ignoreclick": 1,
                  "presentation": 1,
                  "presentation_rect": [
                    174.0,
                    576.0,
                    432.0,
                    6.0
                  ],
                  "varname": "vtm_ui_threshold_meter",
                  "hidden": 0,
                  "hint": "Nivel brut de vârf pe 600 ms; marcajul arată pragul ales. Detectorul folosește și filtrare, anvelopă, zgomot și rearmare. Depășirea marcajului nu garantează un atac."
                }
              },
              {
                "box": {
                  "id": "meter-low",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    1020.0,
                    2260.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 10.0,
                  "textcolor": [
                    0.6784313725490196,
                    0.7294117647058823,
                    0.807843137254902,
                    1.0
                  ],
                  "fontface": 0,
                  "text": "−60 dB",
                  "presentation": 1,
                  "presentation_rect": [
                    174.0,
                    585.0,
                    72.0,
                    15
                  ],
                  "varname": "vtm_ui_meter_low",
                  "hidden": 0,
                  "fontname": "Segoe UI"
                }
              },
              {
                "box": {
                  "id": "meter-high",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    20.0,
                    2305.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 10.0,
                  "textcolor": [
                    0.6784313725490196,
                    0.7294117647058823,
                    0.807843137254902,
                    1.0
                  ],
                  "fontface": 0,
                  "text": "0 dB",
                  "presentation": 1,
                  "presentation_rect": [
                    572.0,
                    585.0,
                    34.0,
                    15
                  ],
                  "varname": "vtm_ui_meter_high",
                  "hidden": 0,
                  "fontname": "Segoe UI"
                }
              },
              {
                "box": {
                  "id": "level-feedback",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    220.0,
                    2305.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 11.0,
                  "textcolor": [
                    0.6784313725490196,
                    0.7294117647058823,
                    0.807843137254902,
                    1.0
                  ],
                  "fontface": 0,
                  "text": "Nivel sub pragul ales",
                  "presentation": 1,
                  "presentation_rect": [
                    174.0,
                    605.0,
                    432.0,
                    17
                  ],
                  "varname": "vtm_ui_level_feedback",
                  "hidden": 0,
                  "fontname": "Segoe UI"
                }
              },
              {
                "box": {
                  "id": "source-card",
                  "maxclass": "panel",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    420.0,
                    2305.0,
                    185.0,
                    22.0
                  ],
                  "bgcolor": [
                    0.10588235294117647,
                    0.1411764705882353,
                    0.19607843137254902,
                    1.0
                  ],
                  "border": 0,
                  "rounded": 12,
                  "background": 1,
                  "ignoreclick": 1,
                  "presentation": 1,
                  "presentation_rect": [
                    16.0,
                    638.0,
                    608.0,
                    82.0
                  ],
                  "varname": "vtm_ui_source_card",
                  "hidden": 0
                }
              },
              {
                "box": {
                  "id": "calibration-card",
                  "maxclass": "panel",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    620.0,
                    2305.0,
                    185.0,
                    22.0
                  ],
                  "bgcolor": [
                    0.10588235294117647,
                    0.1411764705882353,
                    0.19607843137254902,
                    1.0
                  ],
                  "border": 0,
                  "rounded": 12,
                  "background": 1,
                  "ignoreclick": 1,
                  "presentation": 1,
                  "presentation_rect": [
                    16.0,
                    410.0,
                    608.0,
                    144.0
                  ],
                  "varname": "vtm_ui_calibration_card",
                  "hidden": 1
                }
              },
              {
                "box": {
                  "id": "calibration-heading",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    820.0,
                    2305.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 14.0,
                  "textcolor": [
                    0.9450980392156862,
                    0.9607843137254902,
                    0.984313725490196,
                    1.0
                  ],
                  "fontface": 1,
                  "text": "Compensare și calibrare",
                  "presentation": 1,
                  "presentation_rect": [
                    32.0,
                    422.0,
                    500.0,
                    20.0
                  ],
                  "varname": "vtm_ui_calibration_heading",
                  "hidden": 1,
                  "fontname": "Segoe UI"
                }
              },
              {
                "box": {
                  "id": "auto-calibrate",
                  "maxclass": "textbutton",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "patching_rect": [
                    1020.0,
                    2305.0,
                    185.0,
                    22.0
                  ],
                  "texton": "Calibrare auto: ON",
                  "mode": 1,
                  "parameter_enable": 1,
                  "rounded": 8.0,
                  "fontsize": 11.0,
                  "fontface": 1,
                  "textcolor": [
                    0.9450980392156862,
                    0.9607843137254902,
                    0.984313725490196,
                    1.0
                  ],
                  "textoncolor": [
                    0.8509803921568627,
                    0.9725490196078431,
                    1.0,
                    1.0
                  ],
                  "bgcolor": [
                    0.06666666666666667,
                    0.10588235294117647,
                    0.1568627450980392,
                    1.0
                  ],
                  "bgoncolor": [
                    0.12941176470588237,
                    0.28627450980392155,
                    0.3411764705882353,
                    1.0
                  ],
                  "usegradient": 0,
                  "usebgoncolor": 1,
                  "outputmode": 1,
                  "text": "Calibrare auto: OFF",
                  "presentation": 1,
                  "presentation_rect": [
                    400.0,
                    476.0,
                    200.0,
                    30.0
                  ],
                  "varname": "vtm_auto_calibrate",
                  "hidden": 1,
                  "parameter_mappable": 0,
                  "saved_attribute_attributes": {
                    "valueof": {
                      "parameter_longname": "VTM Automatic calibration",
                      "parameter_shortname": "VTM Automatic calibration",
                      "parameter_type": 1,
                      "parameter_invisible": 1,
                      "parameter_initial_enable": 1,
                      "parameter_initial": [
                        1
                      ],
                      "parameter_order": 13,
                      "parameter_mmin": 0.0,
                      "parameter_mmax": 1.0
                    }
                  },
                  "hint": "Măsoară când lipsește compensarea: instrumental pornit, fără voce, REC și Oprire auto OFF. Apoi păstrează valoarea salvată.",
                  "fontname": "Segoe UI",
                  "usetextovercolor": 1,
                  "textovercolor": [
                    0.9450980392156862,
                    0.9607843137254902,
                    0.984313725490196,
                    1.0
                  ]
                }
              },
              {
                "box": {
                  "id": "calibration-help",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    20.0,
                    2350.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 11.0,
                  "textcolor": [
                    0.6784313725490196,
                    0.7294117647058823,
                    0.807843137254902,
                    1.0
                  ],
                  "fontface": 0,
                  "text": "Redă instrumentalul fără voce. REC și Oprire auto trebuie să fie OFF.",
                  "presentation": 1,
                  "presentation_rect": [
                    32.0,
                    516.0,
                    560.0,
                    30
                  ],
                  "varname": "vtm_ui_calibration_help",
                  "hidden": 1,
                  "fontname": "Segoe UI"
                }
              },
              {
                "box": {
                  "id": "zoom-card",
                  "maxclass": "panel",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    220.0,
                    2350.0,
                    185.0,
                    22.0
                  ],
                  "bgcolor": [
                    0.10588235294117647,
                    0.1411764705882353,
                    0.19607843137254902,
                    1.0
                  ],
                  "border": 0,
                  "rounded": 12,
                  "background": 1,
                  "ignoreclick": 1,
                  "presentation": 1,
                  "presentation_rect": [
                    16.0,
                    566.0,
                    608.0,
                    80.0
                  ],
                  "varname": "vtm_ui_zoom_card",
                  "hidden": 1
                }
              },
              {
                "box": {
                  "id": "zoom-heading",
                  "maxclass": "comment",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    420.0,
                    2350.0,
                    185.0,
                    22.0
                  ],
                  "fontsize": 13.0,
                  "textcolor": [
                    0.9450980392156862,
                    0.9607843137254902,
                    0.984313725490196,
                    1.0
                  ],
                  "fontface": 1,
                  "text": "Mărire vizuală · sunetul rămâne neschimbat",
                  "presentation": 1,
                  "presentation_rect": [
                    32.0,
                    575.0,
                    560.0,
                    20.0
                  ],
                  "varname": "vtm_ui_zoom_heading",
                  "hidden": 1,
                  "fontname": "Segoe UI"
                }
              },
              {
                "box": {
                  "id": "diagnostic-card",
                  "maxclass": "panel",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    620.0,
                    2350.0,
                    185.0,
                    22.0
                  ],
                  "bgcolor": [
                    0.10588235294117647,
                    0.1411764705882353,
                    0.19607843137254902,
                    1.0
                  ],
                  "border": 0,
                  "rounded": 12,
                  "background": 1,
                  "ignoreclick": 1,
                  "presentation": 1,
                  "presentation_rect": [
                    16.0,
                    658.0,
                    608.0,
                    62.0
                  ],
                  "varname": "vtm_ui_diagnostic_card",
                  "hidden": 1
                }
              },
              {
                "box": {
                  "id": "mark-0",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    2350.0,
                    185.0,
                    22.0
                  ],
                  "text": "set II"
                }
              },
              {
                "box": {
                  "id": "mark-1",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    2350.0,
                    185.0,
                    22.0
                  ],
                  "text": "set >"
                }
              },
              {
                "box": {
                  "id": "mark-2",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    2395.0,
                    185.0,
                    22.0
                  ],
                  "text": "set ~"
                }
              },
              {
                "box": {
                  "id": "mark-3",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    2395.0,
                    185.0,
                    22.0
                  ],
                  "text": "set •"
                }
              },
              {
                "box": {
                  "id": "mark-4",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    2395.0,
                    185.0,
                    22.0
                  ],
                  "text": "set OK"
                }
              },
              {
                "box": {
                  "id": "mark-5",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    620.0,
                    2395.0,
                    185.0,
                    22.0
                  ],
                  "text": "set ~"
                }
              },
              {
                "box": {
                  "id": "mark-6",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    2395.0,
                    185.0,
                    22.0
                  ],
                  "text": "set !"
                }
              },
              {
                "box": {
                  "id": "mark-7",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    2395.0,
                    185.0,
                    22.0
                  ],
                  "text": "set OK"
                }
              },
              {
                "box": {
                  "id": "mark-8",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    2440.0,
                    185.0,
                    22.0
                  ],
                  "text": "set >"
                }
              },
              {
                "box": {
                  "id": "mark-9",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    2440.0,
                    185.0,
                    22.0
                  ],
                  "text": "set !"
                }
              },
              {
                "box": {
                  "id": "mark-10",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    2440.0,
                    185.0,
                    22.0
                  ],
                  "text": "set !"
                }
              },
              {
                "box": {
                  "id": "ui-sign",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    620.0,
                    2440.0,
                    185.0,
                    22.0
                  ],
                  "text": "expr ($f1 > 0.05) - ($f1 < -0.05)"
                }
              },
              {
                "box": {
                  "id": "ui-sign-select",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 4,
                  "patching_rect": [
                    820.0,
                    2440.0,
                    185.0,
                    22.0
                  ],
                  "text": "sel -1 0 1"
                }
              },
              {
                "box": {
                  "id": "ui-sign-0",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    2440.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Mai devreme față de grilă"
                }
              },
              {
                "box": {
                  "id": "ui-sign-1",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    2485.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Pe reperul grilei"
                }
              },
              {
                "box": {
                  "id": "ui-sign-2",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    2485.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Mai târziu față de grilă"
                }
              },
              {
                "box": {
                  "id": "ui-sign-clear",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    2485.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Față de grila din Ableton"
                }
              },
              {
                "box": {
                  "id": "ui-level-clip",
                  "maxclass": "newobj",
                  "numinlets": 3,
                  "numoutlets": 1,
                  "patching_rect": [
                    620.0,
                    2485.0,
                    185.0,
                    22.0
                  ],
                  "text": "clip -60. 0."
                }
              },
              {
                "box": {
                  "id": "ui-level-set",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    2485.0,
                    185.0,
                    22.0
                  ],
                  "text": "prepend setlist"
                }
              },
              {
                "box": {
                  "id": "ui-threshold-set",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    2485.0,
                    185.0,
                    22.0
                  ],
                  "text": "prepend setlist"
                }
              },
              {
                "box": {
                  "id": "ui-level-pak",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    2530.0,
                    185.0,
                    22.0
                  ],
                  "text": "pak -100. -32."
                }
              },
              {
                "box": {
                  "id": "ui-level-unpack",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "patching_rect": [
                    220.0,
                    2530.0,
                    185.0,
                    22.0
                  ],
                  "text": "unpack 0. 0."
                }
              },
              {
                "box": {
                  "id": "ui-level-class",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    2530.0,
                    185.0,
                    22.0
                  ],
                  "text": "expr ($f1 >= 0.) * 2 + ($f1 < 0.) * ($f1 >= $f2)"
                }
              },
              {
                "box": {
                  "id": "ui-level-change",
                  "maxclass": "newobj",
                  "numinlets": 3,
                  "numoutlets": 3,
                  "patching_rect": [
                    620.0,
                    2530.0,
                    185.0,
                    22.0
                  ],
                  "text": "change -1"
                }
              },
              {
                "box": {
                  "id": "ui-level-select",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 4,
                  "patching_rect": [
                    820.0,
                    2530.0,
                    185.0,
                    22.0
                  ],
                  "text": "sel 0 1 2"
                }
              },
              {
                "box": {
                  "id": "ui-level-label-0",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    2530.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Nivel sub pragul ales"
                }
              },
              {
                "box": {
                  "id": "ui-level-label-1",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    2575.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Nivel peste prag · atacul este verificat separat"
                }
              },
              {
                "box": {
                  "id": "ui-level-label-2",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    2575.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Nivel prea mare · redu intrarea microfonului"
                }
              },
              {
                "box": {
                  "id": "ui-tolerance-pak",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    2575.0,
                    185.0,
                    22.0
                  ],
                  "text": "pak 100. 300."
                }
              },
              {
                "box": {
                  "id": "ui-tolerance-unpack",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "patching_rect": [
                    620.0,
                    2575.0,
                    185.0,
                    22.0
                  ],
                  "text": "unpack 0. 0."
                }
              },
              {
                "box": {
                  "id": "ui-tolerance-invalid",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    2575.0,
                    185.0,
                    22.0
                  ],
                  "text": "expr $f1 > $f2"
                }
              },
              {
                "box": {
                  "id": "ui-tolerance-select",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "patching_rect": [
                    1020.0,
                    2575.0,
                    185.0,
                    22.0
                  ],
                  "text": "sel 0 1"
                }
              },
              {
                "box": {
                  "id": "ui-tolerance-label-0",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    2620.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Abaterea permisă față de grilă."
                }
              },
              {
                "box": {
                  "id": "ui-tolerance-label-1",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    2620.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Depășește limita grilei. Scade toleranța."
                }
              },
              {
                "box": {
                  "id": "ui-page-select",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "patching_rect": [
                    420.0,
                    2620.0,
                    185.0,
                    22.0
                  ],
                  "text": "sel 0 1"
                }
              },
              {
                "box": {
                  "id": "ui-page-0",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    620.0,
                    2620.0,
                    185.0,
                    22.0
                  ],
                  "text": "script show vtm_ui_rhythm_card, script show vtm_ui_grid_caption, script show vtm_grid_ui, script show vtm_ui_redms_label, script show vtm_redms, script show vtm_ui_rhythm_hint, script show vtm_ui_mic_card, script show vtm_ui_mic_heading, script show vtm_ui_gatedb_label, script show vtm_gatedb, script show vtm_ui_gate_help, script show vtm_ui_meter_caption, script show vtm_ui_input_meter, script show vtm_ui_threshold_meter, script show vtm_ui_meter_low, script show vtm_ui_meter_high, script show vtm_ui_level_feedback, script show vtm_ui_source_card, script show vtm_ui_beat_source_caption, script show vtm_ui_beat_type, script show vtm_ui_beat_channel, script show vtm_ui_beat_refresh, script hide vtm_ui_calibration_card, script hide vtm_ui_calibration_heading, script hide vtm_ui_offsetms_label, script hide vtm_offsetms, script hide vtm_ui_calibrate, script hide vtm_auto_calibrate, script hide vtm_ui_calibration_help, script hide vtm_ui_zoom_card, script hide vtm_ui_zoom_heading, script hide vtm_ui_voice_gain_caption, script hide vtm_voice_gain, script hide vtm_ui_beat_gain_caption, script hide vtm_beat_gain, script hide vtm_ui_diagnostic_card, script hide vtm_ui_api_text, script hide vtm_ui_test, script hide vtm_ui_tests_text, script hide vtm_ui_limit_text"
                }
              },
              {
                "box": {
                  "id": "ui-page-title-0",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    2620.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Setări uzuale"
                }
              },
              {
                "box": {
                  "id": "ui-page-1",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    2620.0,
                    185.0,
                    22.0
                  ],
                  "text": "script hide vtm_ui_rhythm_card, script hide vtm_ui_grid_caption, script hide vtm_grid_ui, script hide vtm_ui_redms_label, script hide vtm_redms, script hide vtm_ui_rhythm_hint, script hide vtm_ui_mic_card, script hide vtm_ui_mic_heading, script hide vtm_ui_gatedb_label, script hide vtm_gatedb, script hide vtm_ui_gate_help, script hide vtm_ui_meter_caption, script hide vtm_ui_input_meter, script hide vtm_ui_threshold_meter, script hide vtm_ui_meter_low, script hide vtm_ui_meter_high, script hide vtm_ui_level_feedback, script hide vtm_ui_source_card, script hide vtm_ui_beat_source_caption, script hide vtm_ui_beat_type, script hide vtm_ui_beat_channel, script hide vtm_ui_beat_refresh, script show vtm_ui_calibration_card, script show vtm_ui_calibration_heading, script show vtm_ui_offsetms_label, script show vtm_offsetms, script show vtm_ui_calibrate, script show vtm_auto_calibrate, script show vtm_ui_calibration_help, script show vtm_ui_zoom_card, script show vtm_ui_zoom_heading, script show vtm_ui_voice_gain_caption, script show vtm_voice_gain, script show vtm_ui_beat_gain_caption, script show vtm_beat_gain, script show vtm_ui_diagnostic_card, script show vtm_ui_api_text, script show vtm_ui_test, script show vtm_ui_tests_text, script show vtm_ui_limit_text"
                }
              },
              {
                "box": {
                  "id": "ui-page-title-1",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    2665.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Setări avansate"
                }
              },
              {
                "box": {
                  "id": "ui-state-trigger",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "patching_rect": [
                    220.0,
                    2665.0,
                    185.0,
                    22.0
                  ],
                  "text": "t i i"
                }
              },
              {
                "box": {
                  "id": "ui-state-memory",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    2665.0,
                    185.0,
                    22.0
                  ],
                  "text": "i 1"
                }
              },
              {
                "box": {
                  "id": "ui-theme-trigger",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "patching_rect": [
                    620.0,
                    2665.0,
                    185.0,
                    22.0
                  ],
                  "text": "t b i"
                }
              },
              {
                "box": {
                  "id": "ui-theme-select",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "patching_rect": [
                    820.0,
                    2665.0,
                    185.0,
                    22.0
                  ],
                  "text": "sel 0 1"
                }
              },
              {
                "box": {
                  "id": "ui-device-theme-out",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    260.0,
                    900.0,
                    25.0,
                    25.0
                  ],
                  "text": "outlet"
                }
              },
              {
                "box": {
                  "id": "ui-theme-replay",
                  "maxclass": "newobj",
                  "numinlets": 3,
                  "numoutlets": 3,
                  "patching_rect": [
                    1020.0,
                    2665.0,
                    185.0,
                    22.0
                  ],
                  "saved_object_attributes": {
                    "parameter_enable": 0
                  },
                  "text": "pattr @bindto vtm_theme @thru 0 @autorestore 0"
                }
              },
              {
                "box": {
                  "id": "ui-view-initial",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    2710.0,
                    185.0,
                    22.0
                  ],
                  "text": "set 0"
                }
              },
              {
                "box": {
                  "id": "ui-page-initial",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    2710.0,
                    185.0,
                    22.0
                  ],
                  "text": "0"
                }
              },
              {
                "box": {
                  "id": "ui-state-theme-0",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    2710.0,
                    185.0,
                    22.0
                  ],
                  "text": "i 0"
                }
              },
              {
                "box": {
                  "id": "ui-state-color-select-0",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "patching_rect": [
                    620.0,
                    2710.0,
                    185.0,
                    22.0
                  ],
                  "text": "sel 0 1"
                }
              },
              {
                "box": {
                  "id": "ui-light-color-0",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    2710.0,
                    185.0,
                    22.0
                  ],
                  "text": "textcolor 0.3215686274509804 0.39215686274509803 0.4666666666666667 1.0"
                }
              },
              {
                "box": {
                  "id": "ui-state-theme-1",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    2710.0,
                    185.0,
                    22.0
                  ],
                  "text": "i 0"
                }
              },
              {
                "box": {
                  "id": "ui-state-color-select-1",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "patching_rect": [
                    20.0,
                    2755.0,
                    185.0,
                    22.0
                  ],
                  "text": "sel 0 1"
                }
              },
              {
                "box": {
                  "id": "ui-light-color-1",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    2755.0,
                    185.0,
                    22.0
                  ],
                  "text": "textcolor 0.3215686274509804 0.39215686274509803 0.4666666666666667 1.0"
                }
              },
              {
                "box": {
                  "id": "ui-state-theme-2",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    2755.0,
                    185.0,
                    22.0
                  ],
                  "text": "i 0"
                }
              },
              {
                "box": {
                  "id": "ui-state-color-select-2",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "patching_rect": [
                    620.0,
                    2755.0,
                    185.0,
                    22.0
                  ],
                  "text": "sel 0 1"
                }
              },
              {
                "box": {
                  "id": "ui-light-color-2",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    2755.0,
                    185.0,
                    22.0
                  ],
                  "text": "textcolor 0.5294117647058824 0.3137254901960784 0.0 1.0"
                }
              },
              {
                "box": {
                  "id": "ui-state-theme-3",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    2755.0,
                    185.0,
                    22.0
                  ],
                  "text": "i 0"
                }
              },
              {
                "box": {
                  "id": "ui-state-color-select-3",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "patching_rect": [
                    20.0,
                    2800.0,
                    185.0,
                    22.0
                  ],
                  "text": "sel 0 1"
                }
              },
              {
                "box": {
                  "id": "ui-light-color-3",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    2800.0,
                    185.0,
                    22.0
                  ],
                  "text": "textcolor 0.0 0.42745098039215684 0.5137254901960784 1.0"
                }
              },
              {
                "box": {
                  "id": "ui-state-theme-4",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    2800.0,
                    185.0,
                    22.0
                  ],
                  "text": "i 0"
                }
              },
              {
                "box": {
                  "id": "ui-state-color-select-4",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "patching_rect": [
                    620.0,
                    2800.0,
                    185.0,
                    22.0
                  ],
                  "text": "sel 0 1"
                }
              },
              {
                "box": {
                  "id": "ui-light-color-4",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    2800.0,
                    185.0,
                    22.0
                  ],
                  "text": "textcolor 0.03137254901960784 0.4470588235294118 0.3215686274509804 1.0"
                }
              },
              {
                "box": {
                  "id": "ui-state-theme-5",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    2800.0,
                    185.0,
                    22.0
                  ],
                  "text": "i 0"
                }
              },
              {
                "box": {
                  "id": "ui-state-color-select-5",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "patching_rect": [
                    20.0,
                    2845.0,
                    185.0,
                    22.0
                  ],
                  "text": "sel 0 1"
                }
              },
              {
                "box": {
                  "id": "ui-light-color-5",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    2845.0,
                    185.0,
                    22.0
                  ],
                  "text": "textcolor 0.5294117647058824 0.3137254901960784 0.0 1.0"
                }
              },
              {
                "box": {
                  "id": "ui-state-theme-6",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    2845.0,
                    185.0,
                    22.0
                  ],
                  "text": "i 0"
                }
              },
              {
                "box": {
                  "id": "ui-state-color-select-6",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "patching_rect": [
                    620.0,
                    2845.0,
                    185.0,
                    22.0
                  ],
                  "text": "sel 0 1"
                }
              },
              {
                "box": {
                  "id": "ui-light-color-6",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    2845.0,
                    185.0,
                    22.0
                  ],
                  "text": "textcolor 0.7137254901960784 0.19215686274509805 0.28627450980392155 1.0"
                }
              },
              {
                "box": {
                  "id": "ui-state-theme-7",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    2845.0,
                    185.0,
                    22.0
                  ],
                  "text": "i 0"
                }
              },
              {
                "box": {
                  "id": "ui-state-color-select-7",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "patching_rect": [
                    20.0,
                    2890.0,
                    185.0,
                    22.0
                  ],
                  "text": "sel 0 1"
                }
              },
              {
                "box": {
                  "id": "ui-light-color-7",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    2890.0,
                    185.0,
                    22.0
                  ],
                  "text": "textcolor 0.0 0.42745098039215684 0.5137254901960784 1.0"
                }
              },
              {
                "box": {
                  "id": "ui-state-theme-8",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    2890.0,
                    185.0,
                    22.0
                  ],
                  "text": "i 0"
                }
              },
              {
                "box": {
                  "id": "ui-state-color-select-8",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "patching_rect": [
                    620.0,
                    2890.0,
                    185.0,
                    22.0
                  ],
                  "text": "sel 0 1"
                }
              },
              {
                "box": {
                  "id": "ui-light-color-8",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    2890.0,
                    185.0,
                    22.0
                  ],
                  "text": "textcolor 0.5294117647058824 0.3137254901960784 0.0 1.0"
                }
              },
              {
                "box": {
                  "id": "ui-state-theme-9",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    2890.0,
                    185.0,
                    22.0
                  ],
                  "text": "i 0"
                }
              },
              {
                "box": {
                  "id": "ui-state-color-select-9",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "patching_rect": [
                    20.0,
                    2935.0,
                    185.0,
                    22.0
                  ],
                  "text": "sel 0 1"
                }
              },
              {
                "box": {
                  "id": "ui-light-color-9",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    2935.0,
                    185.0,
                    22.0
                  ],
                  "text": "textcolor 0.7137254901960784 0.19215686274509805 0.28627450980392155 1.0"
                }
              },
              {
                "box": {
                  "id": "ui-state-theme-10",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    2935.0,
                    185.0,
                    22.0
                  ],
                  "text": "i 0"
                }
              },
              {
                "box": {
                  "id": "ui-state-color-select-10",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "patching_rect": [
                    620.0,
                    2935.0,
                    185.0,
                    22.0
                  ],
                  "text": "sel 0 1"
                }
              },
              {
                "box": {
                  "id": "ui-light-color-10",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    2935.0,
                    185.0,
                    22.0
                  ],
                  "text": "textcolor 0.5294117647058824 0.3137254901960784 0.0 1.0"
                }
              },
              {
                "box": {
                  "id": "ui-palette-0",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    2935.0,
                    185.0,
                    22.0
                  ],
                  "text": "script send vtm_ui_studio_canvas bgcolor 0.06666666666666667 0.09019607843137255 0.13333333333333333 1.0, script send vtm_ui_title textcolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_ui_version textcolor 0.6784313725490196 0.7294117647058823 0.807843137254902 1.0, script send vtm_ui_state_card bgcolor 0.10588235294117647 0.1411764705882353 0.19607843137254902 1.0, script send vtm_ui_state_text textcolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_ui_clock_text textcolor 0.6784313725490196 0.7294117647058823 0.807843137254902 1.0, script send vtm_ui_api_text textcolor 0.6784313725490196 0.7294117647058823 0.807843137254902 1.0, script send vtm_ui_delta_text textcolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_ui_sign_caption textcolor 0.6784313725490196 0.7294117647058823 0.807843137254902 1.0, script send vtm_ui_count_caption textcolor 0.6784313725490196 0.7294117647058823 0.807843137254902 1.0, script send vtm_ui_count_text textcolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_ui_tests_text textcolor 0.6784313725490196 0.7294117647058823 0.807843137254902 1.0, script send vtm_enabled bgcolor 0.06666666666666667 0.10588235294117647 0.1568627450980392 1.0, script send vtm_enabled textcolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_enabled textovercolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_enabled bgoncolor 0.12941176470588237 0.28627450980392155 0.3411764705882353 1.0, script send vtm_enabled textoncolor 0.8509803921568627 0.9725490196078431 1.0 1.0, script send vtm_ui_autostop bgcolor 0.06666666666666667 0.10588235294117647 0.1568627450980392 1.0, script send vtm_ui_autostop textcolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_ui_autostop textovercolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_ui_autostop bgoncolor 0.3176470588235294 0.25098039215686274 0.13333333333333333 1.0, script send vtm_ui_autostop textoncolor 1.0 0.8588235294117647 0.615686274509804 1.0, script send vtm_ui_test bgcolor 0.06666666666666667 0.10588235294117647 0.1568627450980392 1.0, script send vtm_ui_test textcolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_ui_test textovercolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_ui_test bgoncolor 0.06666666666666667 0.10588235294117647 0.1568627450980392 1.0, script send vtm_ui_test textoncolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_ui_reset bgcolor 0.06666666666666667 0.10588235294117647 0.1568627450980392 1.0, script send vtm_ui_reset textcolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_ui_reset textovercolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_ui_reset bgoncolor 0.06666666666666667 0.10588235294117647 0.1568627450980392 1.0, script send vtm_ui_reset textoncolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_ui_level_text textcolor 0.6784313725490196 0.7294117647058823 0.807843137254902 1.0, script send vtm_ui_grid_caption textcolor 0.6784313725490196 0.7294117647058823 0.807843137254902 1.0, script send vtm_grid_ui bgcolor 0.06666666666666667 0.10588235294117647 0.1568627450980392 1.0, script send vtm_grid_ui textcolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_ui_redms_label textcolor 0.6784313725490196 0.7294117647058823 0.807843137254902 1.0, script send vtm_redms bgcolor 0.06666666666666667 0.10588235294117647 0.1568627450980392 1.0, script send vtm_redms textcolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_ui_offsetms_label textcolor 0.6784313725490196 0.7294117647058823 0.807843137254902 1.0, script send vtm_offsetms bgcolor 0.06666666666666667 0.10588235294117647 0.1568627450980392 1.0, script send vtm_offsetms textcolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_ui_gatedb_label textcolor 0.6784313725490196 0.7294117647058823 0.807843137254902 1.0, script send vtm_gatedb bgcolor 0.06666666666666667 0.10588235294117647 0.1568627450980392 1.0, script send vtm_gatedb textcolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_ui_calibrate bgcolor 0.06666666666666667 0.10588235294117647 0.1568627450980392 1.0, script send vtm_ui_calibrate textcolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_ui_calibrate textovercolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_ui_calibrate bgoncolor 0.06666666666666667 0.10588235294117647 0.1568627450980392 1.0, script send vtm_ui_calibrate textoncolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_ui_limit_text textcolor 0.6784313725490196 0.7294117647058823 0.807843137254902 1.0, script send vtm_ui_footer2 textcolor 0.6784313725490196 0.7294117647058823 0.807843137254902 1.0, script send vtm_ui_voice_caption textcolor 0.40784313725490196 0.8431372549019608 0.9294117647058824 1.0, script send vtm_ui_voice_gain_caption textcolor 0.6784313725490196 0.7294117647058823 0.807843137254902 1.0, script send vtm_ui_beat_caption textcolor 0.39215686274509803 0.8470588235294118 0.6705882352941176 1.0, script send vtm_ui_beat_level textcolor 0.6784313725490196 0.7294117647058823 0.807843137254902 1.0, script send vtm_ui_beat_gain_caption textcolor 0.6784313725490196 0.7294117647058823 0.807843137254902 1.0, script send vtm_ui_voice_scope bgcolor 0.10588235294117647 0.1411764705882353 0.19607843137254902 1.0, script send vtm_ui_voice_scope activebgcolor 0.10588235294117647 0.1411764705882353 0.19607843137254902 1.0, script send vtm_ui_voice_scope linecolor 0.40784313725490196 0.8431372549019608 0.9294117647058824 1.0, script send vtm_ui_voice_scope activelinecolor 0.40784313725490196 0.8431372549019608 0.9294117647058824 1.0, script send vtm_voice_gain activebgcolor 0.06666666666666667 0.10588235294117647 0.1568627450980392 1.0, script send vtm_voice_gain lcdbgcolor 0.06666666666666667 0.10588235294117647 0.1568627450980392 1.0, script send vtm_voice_gain textcolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_voice_gain lcdcolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_voice_gain inactivelcdcolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_voice_gain bordercolor 0.20392156862745098 0.26666666666666666 0.34509803921568627 1.0, script send vtm_voice_gain focusbordercolor 0.40784313725490196 0.8431372549019608 0.9294117647058824 1.0, script send vtm_ui_grid_scope bgcolor 0.10588235294117647 0.1411764705882353 0.19607843137254902 1.0, script send vtm_ui_grid_scope activebgcolor 0.10588235294117647 0.1411764705882353 0.19607843137254902 1.0, script send vtm_ui_grid_scope linecolor 1.0 0.8 0.47058823529411764 1.0, script send vtm_ui_grid_scope activelinecolor 1.0 0.8 0.47058823529411764 1.0, script send vtm_ui_beat_scope bgcolor 0.10588235294117647 0.1411764705882353 0.19607843137254902 1.0, script send vtm_ui_beat_scope activebgcolor 0.10588235294117647 0.1411764705882353 0.19607843137254902 1.0, script send vtm_ui_beat_scope linecolor 0.39215686274509803 0.8470588235294118 0.6705882352941176 1.0, script send vtm_ui_beat_scope activelinecolor 0.39215686274509803 0.8470588235294118 0.6705882352941176 1.0, script send vtm_beat_gain activebgcolor 0.06666666666666667 0.10588235294117647 0.1568627450980392 1.0, script send vtm_beat_gain lcdbgcolor 0.06666666666666667 0.10588235294117647 0.1568627450980392 1.0, script send vtm_beat_gain textcolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_beat_gain lcdcolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_beat_gain inactivelcdcolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_beat_gain bordercolor 0.20392156862745098 0.26666666666666666 0.34509803921568627 1.0, script send vtm_beat_gain focusbordercolor 0.40784313725490196 0.8431372549019608 0.9294117647058824 1.0, script send vtm_ui_time_old textcolor 0.6784313725490196 0.7294117647058823 0.807843137254902 1.0, script send vtm_ui_time_mid textcolor 0.6784313725490196 0.7294117647058823 0.807843137254902 1.0, script send vtm_ui_time_now textcolor 0.6784313725490196 0.7294117647058823 0.807843137254902 1.0, script send vtm_ui_beat_source_caption textcolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_ui_beat_type bgcolor 0.06666666666666667 0.10588235294117647 0.1568627450980392 1.0, script send vtm_ui_beat_type textcolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_ui_beat_channel bgcolor 0.06666666666666667 0.10588235294117647 0.1568627450980392 1.0, script send vtm_ui_beat_channel textcolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_ui_beat_refresh bgcolor 0.06666666666666667 0.10588235294117647 0.1568627450980392 1.0, script send vtm_ui_beat_refresh textcolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_ui_beat_refresh textovercolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_ui_beat_refresh bgoncolor 0.06666666666666667 0.10588235294117647 0.1568627450980392 1.0, script send vtm_ui_beat_refresh textoncolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_ui_settings bgcolor 0.06666666666666667 0.10588235294117647 0.1568627450980392 1.0, script send vtm_ui_settings textcolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_ui_settings textovercolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_ui_settings bgoncolor 0.12941176470588237 0.28627450980392155 0.3411764705882353 1.0, script send vtm_ui_settings textoncolor 0.8509803921568627 0.9725490196078431 1.0 1.0, script send vtm_theme bgcolor 0.06666666666666667 0.10588235294117647 0.1568627450980392 1.0, script send vtm_theme textcolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_theme textovercolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_theme bgoncolor 0.12941176470588237 0.28627450980392155 0.3411764705882353 1.0, script send vtm_theme textoncolor 0.8509803921568627 0.9725490196078431 1.0 1.0, script send vtm_ui_status_mark textcolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_ui_voice_card bgcolor 0.10588235294117647 0.1411764705882353 0.19607843137254902 1.0, script send vtm_ui_beat_card bgcolor 0.10588235294117647 0.1411764705882353 0.19607843137254902 1.0, script send vtm_ui_settings_heading textcolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_ui_advanced bgcolor 0.06666666666666667 0.10588235294117647 0.1568627450980392 1.0, script send vtm_ui_advanced textcolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_ui_advanced textovercolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_ui_advanced bgoncolor 0.12941176470588237 0.28627450980392155 0.3411764705882353 1.0, script send vtm_ui_advanced textoncolor 0.8509803921568627 0.9725490196078431 1.0 1.0, script send vtm_ui_rhythm_card bgcolor 0.10588235294117647 0.1411764705882353 0.19607843137254902 1.0, script send vtm_ui_rhythm_hint textcolor 0.6784313725490196 0.7294117647058823 0.807843137254902 1.0, script send vtm_ui_mic_card bgcolor 0.10588235294117647 0.1411764705882353 0.19607843137254902 1.0, script send vtm_ui_mic_heading textcolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_ui_gate_help textcolor 0.6784313725490196 0.7294117647058823 0.807843137254902 1.0, script send vtm_ui_meter_caption textcolor 0.6784313725490196 0.7294117647058823 0.807843137254902 1.0, script send vtm_ui_input_meter bgcolor 0.06666666666666667 0.10588235294117647 0.1568627450980392 1.0, script send vtm_ui_input_meter slidercolor 0.40784313725490196 0.8431372549019608 0.9294117647058824 1.0, script send vtm_ui_threshold_meter bgcolor 0.06666666666666667 0.10588235294117647 0.1568627450980392 1.0, script send vtm_ui_threshold_meter slidercolor 1.0 0.8 0.47058823529411764 1.0, script send vtm_ui_meter_low textcolor 0.6784313725490196 0.7294117647058823 0.807843137254902 1.0, script send vtm_ui_meter_high textcolor 0.6784313725490196 0.7294117647058823 0.807843137254902 1.0, script send vtm_ui_level_feedback textcolor 0.6784313725490196 0.7294117647058823 0.807843137254902 1.0, script send vtm_ui_source_card bgcolor 0.10588235294117647 0.1411764705882353 0.19607843137254902 1.0, script send vtm_ui_calibration_card bgcolor 0.10588235294117647 0.1411764705882353 0.19607843137254902 1.0, script send vtm_ui_calibration_heading textcolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_auto_calibrate bgcolor 0.06666666666666667 0.10588235294117647 0.1568627450980392 1.0, script send vtm_auto_calibrate textcolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_auto_calibrate textovercolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_auto_calibrate bgoncolor 0.12941176470588237 0.28627450980392155 0.3411764705882353 1.0, script send vtm_auto_calibrate textoncolor 0.8509803921568627 0.9725490196078431 1.0 1.0, script send vtm_ui_calibration_help textcolor 0.6784313725490196 0.7294117647058823 0.807843137254902 1.0, script send vtm_ui_zoom_card bgcolor 0.10588235294117647 0.1411764705882353 0.19607843137254902 1.0, script send vtm_ui_zoom_heading textcolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_ui_diagnostic_card bgcolor 0.10588235294117647 0.1411764705882353 0.19607843137254902 1.0"
                }
              },
              {
                "box": {
                  "id": "ui-palette-1",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    2980.0,
                    185.0,
                    22.0
                  ],
                  "text": "script send vtm_ui_studio_canvas bgcolor 0.9372549019607843 0.9529411764705882 0.9725490196078431 1.0, script send vtm_ui_title textcolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_ui_version textcolor 0.3215686274509804 0.39215686274509803 0.4666666666666667 1.0, script send vtm_ui_state_card bgcolor 1.0 1.0 1.0 1.0, script send vtm_ui_state_text textcolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_ui_clock_text textcolor 0.3215686274509804 0.39215686274509803 0.4666666666666667 1.0, script send vtm_ui_api_text textcolor 0.3215686274509804 0.39215686274509803 0.4666666666666667 1.0, script send vtm_ui_delta_text textcolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_ui_sign_caption textcolor 0.3215686274509804 0.39215686274509803 0.4666666666666667 1.0, script send vtm_ui_count_caption textcolor 0.3215686274509804 0.39215686274509803 0.4666666666666667 1.0, script send vtm_ui_count_text textcolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_ui_tests_text textcolor 0.3215686274509804 0.39215686274509803 0.4666666666666667 1.0, script send vtm_enabled bgcolor 0.9058823529411765 0.9333333333333333 0.9607843137254902 1.0, script send vtm_enabled textcolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_enabled textovercolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_enabled bgoncolor 0.803921568627451 0.9176470588235294 0.9490196078431372 1.0, script send vtm_enabled textoncolor 0.0 0.23529411764705882 0.30196078431372547 1.0, script send vtm_ui_autostop bgcolor 0.9058823529411765 0.9333333333333333 0.9607843137254902 1.0, script send vtm_ui_autostop textcolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_ui_autostop textovercolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_ui_autostop bgoncolor 0.984313725490196 0.8980392156862745 0.7411764705882353 1.0, script send vtm_ui_autostop textoncolor 0.4588235294117647 0.2549019607843137 0.0 1.0, script send vtm_ui_test bgcolor 0.9058823529411765 0.9333333333333333 0.9607843137254902 1.0, script send vtm_ui_test textcolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_ui_test textovercolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_ui_test bgoncolor 0.9058823529411765 0.9333333333333333 0.9607843137254902 1.0, script send vtm_ui_test textoncolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_ui_reset bgcolor 0.9058823529411765 0.9333333333333333 0.9607843137254902 1.0, script send vtm_ui_reset textcolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_ui_reset textovercolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_ui_reset bgoncolor 0.9058823529411765 0.9333333333333333 0.9607843137254902 1.0, script send vtm_ui_reset textoncolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_ui_level_text textcolor 0.3215686274509804 0.39215686274509803 0.4666666666666667 1.0, script send vtm_ui_grid_caption textcolor 0.3215686274509804 0.39215686274509803 0.4666666666666667 1.0, script send vtm_grid_ui bgcolor 0.9058823529411765 0.9333333333333333 0.9607843137254902 1.0, script send vtm_grid_ui textcolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_ui_redms_label textcolor 0.3215686274509804 0.39215686274509803 0.4666666666666667 1.0, script send vtm_redms bgcolor 0.9058823529411765 0.9333333333333333 0.9607843137254902 1.0, script send vtm_redms textcolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_ui_offsetms_label textcolor 0.3215686274509804 0.39215686274509803 0.4666666666666667 1.0, script send vtm_offsetms bgcolor 0.9058823529411765 0.9333333333333333 0.9607843137254902 1.0, script send vtm_offsetms textcolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_ui_gatedb_label textcolor 0.3215686274509804 0.39215686274509803 0.4666666666666667 1.0, script send vtm_gatedb bgcolor 0.9058823529411765 0.9333333333333333 0.9607843137254902 1.0, script send vtm_gatedb textcolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_ui_calibrate bgcolor 0.9058823529411765 0.9333333333333333 0.9607843137254902 1.0, script send vtm_ui_calibrate textcolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_ui_calibrate textovercolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_ui_calibrate bgoncolor 0.9058823529411765 0.9333333333333333 0.9607843137254902 1.0, script send vtm_ui_calibrate textoncolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_ui_limit_text textcolor 0.3215686274509804 0.39215686274509803 0.4666666666666667 1.0, script send vtm_ui_footer2 textcolor 0.3215686274509804 0.39215686274509803 0.4666666666666667 1.0, script send vtm_ui_voice_caption textcolor 0.0 0.42745098039215684 0.5137254901960784 1.0, script send vtm_ui_voice_gain_caption textcolor 0.3215686274509804 0.39215686274509803 0.4666666666666667 1.0, script send vtm_ui_beat_caption textcolor 0.03137254901960784 0.4470588235294118 0.3215686274509804 1.0, script send vtm_ui_beat_level textcolor 0.3215686274509804 0.39215686274509803 0.4666666666666667 1.0, script send vtm_ui_beat_gain_caption textcolor 0.3215686274509804 0.39215686274509803 0.4666666666666667 1.0, script send vtm_ui_voice_scope bgcolor 1.0 1.0 1.0 1.0, script send vtm_ui_voice_scope activebgcolor 1.0 1.0 1.0 1.0, script send vtm_ui_voice_scope linecolor 0.0 0.42745098039215684 0.5137254901960784 1.0, script send vtm_ui_voice_scope activelinecolor 0.0 0.42745098039215684 0.5137254901960784 1.0, script send vtm_voice_gain activebgcolor 0.9058823529411765 0.9333333333333333 0.9607843137254902 1.0, script send vtm_voice_gain lcdbgcolor 0.9058823529411765 0.9333333333333333 0.9607843137254902 1.0, script send vtm_voice_gain textcolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_voice_gain lcdcolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_voice_gain inactivelcdcolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_voice_gain bordercolor 0.807843137254902 0.8549019607843137 0.9019607843137255 1.0, script send vtm_voice_gain focusbordercolor 0.0 0.42745098039215684 0.5137254901960784 1.0, script send vtm_ui_grid_scope bgcolor 1.0 1.0 1.0 1.0, script send vtm_ui_grid_scope activebgcolor 1.0 1.0 1.0 1.0, script send vtm_ui_grid_scope linecolor 0.5294117647058824 0.3137254901960784 0.0 1.0, script send vtm_ui_grid_scope activelinecolor 0.5294117647058824 0.3137254901960784 0.0 1.0, script send vtm_ui_beat_scope bgcolor 1.0 1.0 1.0 1.0, script send vtm_ui_beat_scope activebgcolor 1.0 1.0 1.0 1.0, script send vtm_ui_beat_scope linecolor 0.03137254901960784 0.4470588235294118 0.3215686274509804 1.0, script send vtm_ui_beat_scope activelinecolor 0.03137254901960784 0.4470588235294118 0.3215686274509804 1.0, script send vtm_beat_gain activebgcolor 0.9058823529411765 0.9333333333333333 0.9607843137254902 1.0, script send vtm_beat_gain lcdbgcolor 0.9058823529411765 0.9333333333333333 0.9607843137254902 1.0, script send vtm_beat_gain textcolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_beat_gain lcdcolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_beat_gain inactivelcdcolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_beat_gain bordercolor 0.807843137254902 0.8549019607843137 0.9019607843137255 1.0, script send vtm_beat_gain focusbordercolor 0.0 0.42745098039215684 0.5137254901960784 1.0, script send vtm_ui_time_old textcolor 0.3215686274509804 0.39215686274509803 0.4666666666666667 1.0, script send vtm_ui_time_mid textcolor 0.3215686274509804 0.39215686274509803 0.4666666666666667 1.0, script send vtm_ui_time_now textcolor 0.3215686274509804 0.39215686274509803 0.4666666666666667 1.0, script send vtm_ui_beat_source_caption textcolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_ui_beat_type bgcolor 0.9058823529411765 0.9333333333333333 0.9607843137254902 1.0, script send vtm_ui_beat_type textcolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_ui_beat_channel bgcolor 0.9058823529411765 0.9333333333333333 0.9607843137254902 1.0, script send vtm_ui_beat_channel textcolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_ui_beat_refresh bgcolor 0.9058823529411765 0.9333333333333333 0.9607843137254902 1.0, script send vtm_ui_beat_refresh textcolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_ui_beat_refresh textovercolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_ui_beat_refresh bgoncolor 0.9058823529411765 0.9333333333333333 0.9607843137254902 1.0, script send vtm_ui_beat_refresh textoncolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_ui_settings bgcolor 0.9058823529411765 0.9333333333333333 0.9607843137254902 1.0, script send vtm_ui_settings textcolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_ui_settings textovercolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_ui_settings bgoncolor 0.803921568627451 0.9176470588235294 0.9490196078431372 1.0, script send vtm_ui_settings textoncolor 0.0 0.23529411764705882 0.30196078431372547 1.0, script send vtm_theme bgcolor 0.9058823529411765 0.9333333333333333 0.9607843137254902 1.0, script send vtm_theme textcolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_theme textovercolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_theme bgoncolor 0.803921568627451 0.9176470588235294 0.9490196078431372 1.0, script send vtm_theme textoncolor 0.0 0.23529411764705882 0.30196078431372547 1.0, script send vtm_ui_status_mark textcolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_ui_voice_card bgcolor 1.0 1.0 1.0 1.0, script send vtm_ui_beat_card bgcolor 1.0 1.0 1.0 1.0, script send vtm_ui_settings_heading textcolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_ui_advanced bgcolor 0.9058823529411765 0.9333333333333333 0.9607843137254902 1.0, script send vtm_ui_advanced textcolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_ui_advanced textovercolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_ui_advanced bgoncolor 0.803921568627451 0.9176470588235294 0.9490196078431372 1.0, script send vtm_ui_advanced textoncolor 0.0 0.23529411764705882 0.30196078431372547 1.0, script send vtm_ui_rhythm_card bgcolor 1.0 1.0 1.0 1.0, script send vtm_ui_rhythm_hint textcolor 0.3215686274509804 0.39215686274509803 0.4666666666666667 1.0, script send vtm_ui_mic_card bgcolor 1.0 1.0 1.0 1.0, script send vtm_ui_mic_heading textcolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_ui_gate_help textcolor 0.3215686274509804 0.39215686274509803 0.4666666666666667 1.0, script send vtm_ui_meter_caption textcolor 0.3215686274509804 0.39215686274509803 0.4666666666666667 1.0, script send vtm_ui_input_meter bgcolor 0.9058823529411765 0.9333333333333333 0.9607843137254902 1.0, script send vtm_ui_input_meter slidercolor 0.0 0.42745098039215684 0.5137254901960784 1.0, script send vtm_ui_threshold_meter bgcolor 0.9058823529411765 0.9333333333333333 0.9607843137254902 1.0, script send vtm_ui_threshold_meter slidercolor 0.5294117647058824 0.3137254901960784 0.0 1.0, script send vtm_ui_meter_low textcolor 0.3215686274509804 0.39215686274509803 0.4666666666666667 1.0, script send vtm_ui_meter_high textcolor 0.3215686274509804 0.39215686274509803 0.4666666666666667 1.0, script send vtm_ui_level_feedback textcolor 0.3215686274509804 0.39215686274509803 0.4666666666666667 1.0, script send vtm_ui_source_card bgcolor 1.0 1.0 1.0 1.0, script send vtm_ui_calibration_card bgcolor 1.0 1.0 1.0 1.0, script send vtm_ui_calibration_heading textcolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_auto_calibrate bgcolor 0.9058823529411765 0.9333333333333333 0.9607843137254902 1.0, script send vtm_auto_calibrate textcolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_auto_calibrate textovercolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_auto_calibrate bgoncolor 0.803921568627451 0.9176470588235294 0.9490196078431372 1.0, script send vtm_auto_calibrate textoncolor 0.0 0.23529411764705882 0.30196078431372547 1.0, script send vtm_ui_calibration_help textcolor 0.3215686274509804 0.39215686274509803 0.4666666666666667 1.0, script send vtm_ui_zoom_card bgcolor 1.0 1.0 1.0 1.0, script send vtm_ui_zoom_heading textcolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_ui_diagnostic_card bgcolor 1.0 1.0 1.0 1.0"
                }
              },
              {
                "box": {
                  "id": "ui-level-memory",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    2980.0,
                    185.0,
                    22.0
                  ],
                  "text": "f -100."
                }
              },
              {
                "box": {
                  "id": "ui-level-refresh",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "patching_rect": [
                    420.0,
                    2980.0,
                    185.0,
                    22.0
                  ],
                  "text": "t b b"
                }
              },
              {
                "box": {
                  "id": "ui-level-refresh-reset",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    620.0,
                    2980.0,
                    185.0,
                    22.0
                  ],
                  "text": "set -1"
                }
              },
              {
                "box": {
                  "id": "ui-level-theme-0",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    2980.0,
                    185.0,
                    22.0
                  ],
                  "text": "i 0"
                }
              },
              {
                "box": {
                  "id": "ui-level-color-select-0",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "patching_rect": [
                    1020.0,
                    2980.0,
                    185.0,
                    22.0
                  ],
                  "text": "sel 0 1"
                }
              },
              {
                "box": {
                  "id": "ui-level-color-0-0",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    3025.0,
                    185.0,
                    22.0
                  ],
                  "text": "textcolor 0.6784313725490196 0.7294117647058823 0.807843137254902 1.0"
                }
              },
              {
                "box": {
                  "id": "ui-meter-color-0-0",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    3025.0,
                    185.0,
                    22.0
                  ],
                  "text": "slidercolor 0.40784313725490196 0.8431372549019608 0.9294117647058824 1.0"
                }
              },
              {
                "box": {
                  "id": "ui-level-color-0-1",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    3025.0,
                    185.0,
                    22.0
                  ],
                  "text": "textcolor 0.3215686274509804 0.39215686274509803 0.4666666666666667 1.0"
                }
              },
              {
                "box": {
                  "id": "ui-meter-color-0-1",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    620.0,
                    3025.0,
                    185.0,
                    22.0
                  ],
                  "text": "slidercolor 0.0 0.42745098039215684 0.5137254901960784 1.0"
                }
              },
              {
                "box": {
                  "id": "ui-level-theme-1",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    3025.0,
                    185.0,
                    22.0
                  ],
                  "text": "i 0"
                }
              },
              {
                "box": {
                  "id": "ui-level-color-select-1",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "patching_rect": [
                    1020.0,
                    3025.0,
                    185.0,
                    22.0
                  ],
                  "text": "sel 0 1"
                }
              },
              {
                "box": {
                  "id": "ui-level-color-1-0",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    3070.0,
                    185.0,
                    22.0
                  ],
                  "text": "textcolor 0.40784313725490196 0.8431372549019608 0.9294117647058824 1.0"
                }
              },
              {
                "box": {
                  "id": "ui-meter-color-1-0",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    3070.0,
                    185.0,
                    22.0
                  ],
                  "text": "slidercolor 0.40784313725490196 0.8431372549019608 0.9294117647058824 1.0"
                }
              },
              {
                "box": {
                  "id": "ui-level-color-1-1",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    3070.0,
                    185.0,
                    22.0
                  ],
                  "text": "textcolor 0.0 0.42745098039215684 0.5137254901960784 1.0"
                }
              },
              {
                "box": {
                  "id": "ui-meter-color-1-1",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    620.0,
                    3070.0,
                    185.0,
                    22.0
                  ],
                  "text": "slidercolor 0.0 0.42745098039215684 0.5137254901960784 1.0"
                }
              },
              {
                "box": {
                  "id": "ui-level-theme-2",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    3070.0,
                    185.0,
                    22.0
                  ],
                  "text": "i 0"
                }
              },
              {
                "box": {
                  "id": "ui-level-color-select-2",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 3,
                  "patching_rect": [
                    1020.0,
                    3070.0,
                    185.0,
                    22.0
                  ],
                  "text": "sel 0 1"
                }
              },
              {
                "box": {
                  "id": "ui-level-color-2-0",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    3115.0,
                    185.0,
                    22.0
                  ],
                  "text": "textcolor 1.0 0.5411764705882353 0.6078431372549019 1.0"
                }
              },
              {
                "box": {
                  "id": "ui-meter-color-2-0",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    3115.0,
                    185.0,
                    22.0
                  ],
                  "text": "slidercolor 1.0 0.5411764705882353 0.6078431372549019 1.0"
                }
              },
              {
                "box": {
                  "id": "ui-level-color-2-1",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    3115.0,
                    185.0,
                    22.0
                  ],
                  "text": "textcolor 0.7137254901960784 0.19215686274509805 0.28627450980392155 1.0"
                }
              },
              {
                "box": {
                  "id": "ui-meter-color-2-1",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    620.0,
                    3115.0,
                    185.0,
                    22.0
                  ],
                  "text": "slidercolor 0.7137254901960784 0.19215686274509805 0.28627450980392155 1.0"
                }
              },
              {
                "box": {
                  "id": "lat-status-select",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 9,
                  "patching_rect": [
                    820.0,
                    3115.0,
                    185.0,
                    22.0
                  ],
                  "text": "sel 0 1 2 3 4 5 6 7"
                }
              },
              {
                "box": {
                  "id": "lat-help-0",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    3115.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Redă instrumentalul fără voce. REC și Oprire auto trebuie să fie OFF."
                }
              },
              {
                "box": {
                  "id": "lat-help-1",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    3160.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Măsor întârzierea din instrumental. Păstrează liniștea până la rezultatul final."
                }
              },
              {
                "box": {
                  "id": "lat-help-2",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    3160.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Verific dacă măsurarea este concludentă. Păstrează liniștea."
                }
              },
              {
                "box": {
                  "id": "lat-help-3",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    3160.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare aplicată. Salvează proiectul cu Ctrl+S. Compensarea corectează măsurarea\\; nu mută clipul."
                }
              },
              {
                "box": {
                  "id": "lat-help-4",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    620.0,
                    3160.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Reper neconcludent\\; valoarea existentă este păstrată. Reîncearcă într-un pasaj variat\\, fără voce."
                }
              },
              {
                "box": {
                  "id": "lat-help-5",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    3160.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare anulată\\; valoarea existentă este păstrată. Reia cu redarea pornită\\, REC și Oprire auto OFF."
                }
              },
              {
                "box": {
                  "id": "lat-help-6",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    3160.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Pornește redarea\\, cu REC și Oprire auto OFF. Așteaptă sincronizarea\\, apoi reîncearcă."
                }
              },
              {
                "box": {
                  "id": "lat-help-7",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    3205.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Reconfirm întârzierea printr-o captură nouă. Păstrează liniștea și redarea pornită."
                }
              },
              {
                "box": {
                  "id": "lat-diagnostic-store",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 2,
                  "patching_rect": [
                    220.0,
                    3205.0,
                    185.0,
                    22.0
                  ],
                  "text": "zl reg"
                }
              },
              {
                "box": {
                  "id": "lat-diagnostic-route",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 11,
                  "patching_rect": [
                    420.0,
                    3205.0,
                    185.0,
                    22.0
                  ],
                  "text": "route 1 2 3 4 5 6 7 8 9 10"
                }
              },
              {
                "box": {
                  "id": "lat-diagnostic-format-0",
                  "maxclass": "newobj",
                  "numinlets": 8,
                  "numoutlets": 1,
                  "patching_rect": [
                    620.0,
                    3205.0,
                    185.0,
                    22.0
                  ],
                  "text": "sprintf symout Instrumental fără variație măsurabilă. Compensare păstrată. C=%.2f candidat=%.0fms A/B=%.2f/%.2f M=%.2f D=%.0fms N=%.0f S=%.1fms"
                }
              },
              {
                "box": {
                  "id": "lat-diagnostic-set-0",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    3205.0,
                    185.0,
                    22.0
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "lat-diagnostic-format-1",
                  "maxclass": "newobj",
                  "numinlets": 8,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    3205.0,
                    185.0,
                    22.0
                  ],
                  "text": "sprintf symout Microfon fără reper măsurabil. Compensare păstrată. C=%.2f candidat=%.0fms A/B=%.2f/%.2f M=%.2f D=%.0fms N=%.0f S=%.1fms"
                }
              },
              {
                "box": {
                  "id": "lat-diagnostic-set-1",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    3250.0,
                    185.0,
                    22.0
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "lat-diagnostic-format-2",
                  "maxclass": "newobj",
                  "numinlets": 8,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    3250.0,
                    185.0,
                    22.0
                  ],
                  "text": "sprintf symout Potrivire insuficientă între semnale. Compensare păstrată. C=%.2f candidat=%.0fms A/B=%.2f/%.2f M=%.2f D=%.0fms N=%.0f S=%.1fms"
                }
              },
              {
                "box": {
                  "id": "lat-diagnostic-set-2",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    3250.0,
                    185.0,
                    22.0
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "lat-diagnostic-format-3",
                  "maxclass": "newobj",
                  "numinlets": 8,
                  "numoutlets": 1,
                  "patching_rect": [
                    620.0,
                    3250.0,
                    185.0,
                    22.0
                  ],
                  "text": "sprintf symout Mai multe întârzieri plauzibile. Compensare păstrată. C=%.2f candidat=%.0fms A/B=%.2f/%.2f M=%.2f D=%.0fms N=%.0f S=%.1fms"
                }
              },
              {
                "box": {
                  "id": "lat-diagnostic-set-3",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    3250.0,
                    185.0,
                    22.0
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "lat-diagnostic-format-4",
                  "maxclass": "newobj",
                  "numinlets": 8,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    3250.0,
                    185.0,
                    22.0
                  ],
                  "text": "sprintf symout Întârziere instabilă între ferestre. Compensare păstrată. C=%.2f candidat=%.0fms A/B=%.2f/%.2f M=%.2f D=%.0fms N=%.0f S=%.1fms"
                }
              },
              {
                "box": {
                  "id": "lat-diagnostic-set-4",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    3295.0,
                    185.0,
                    22.0
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "lat-diagnostic-format-5",
                  "maxclass": "newobj",
                  "numinlets": 8,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    3295.0,
                    185.0,
                    22.0
                  ],
                  "text": "sprintf symout Candidat la limita intervalului. Compensare păstrată. C=%.2f candidat=%.0fms A/B=%.2f/%.2f M=%.2f D=%.0fms N=%.0f S=%.1fms"
                }
              },
              {
                "box": {
                  "id": "lat-diagnostic-set-5",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    3295.0,
                    185.0,
                    22.0
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "lat-diagnostic-format-6",
                  "maxclass": "newobj",
                  "numinlets": 8,
                  "numoutlets": 1,
                  "patching_rect": [
                    620.0,
                    3295.0,
                    185.0,
                    22.0
                  ],
                  "text": "sprintf symout Confirmare insuficientă între benzi. Compensare păstrată. C=%.2f candidat=%.0fms A/B=%.2f/%.2f M=%.2f D=%.0fms N=%.0f S=%.1fms"
                }
              },
              {
                "box": {
                  "id": "lat-diagnostic-set-6",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    3295.0,
                    185.0,
                    22.0
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "lat-diagnostic-format-7",
                  "maxclass": "newobj",
                  "numinlets": 8,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    3295.0,
                    185.0,
                    22.0
                  ],
                  "text": "sprintf symout Benzile indică întârzieri diferite. Compensare păstrată. C=%.2f candidat=%.0fms A/B=%.2f/%.2f M=%.2f D=%.0fms N=%.0f S=%.1fms"
                }
              },
              {
                "box": {
                  "id": "lat-diagnostic-set-7",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    3340.0,
                    185.0,
                    22.0
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "lat-diagnostic-format-8",
                  "maxclass": "newobj",
                  "numinlets": 8,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    3340.0,
                    185.0,
                    22.0
                  ],
                  "text": "sprintf symout Reconfirmare neconcludentă. Compensare păstrată. C=%.2f candidat=%.0fms A/B=%.2f/%.2f M=%.2f D=%.0fms N=%.0f S=%.1fms"
                }
              },
              {
                "box": {
                  "id": "lat-diagnostic-set-8",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    3340.0,
                    185.0,
                    22.0
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "lat-diagnostic-format-9",
                  "maxclass": "newobj",
                  "numinlets": 8,
                  "numoutlets": 1,
                  "patching_rect": [
                    620.0,
                    3340.0,
                    185.0,
                    22.0
                  ],
                  "text": "sprintf symout Întârzierea diferă între capturi. Compensare păstrată. C=%.2f candidat=%.0fms A/B=%.2f/%.2f M=%.2f D=%.0fms N=%.0f S=%.1fms"
                }
              },
              {
                "box": {
                  "id": "lat-diagnostic-set-9",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    3340.0,
                    185.0,
                    22.0
                  ],
                  "text": "prepend set"
                }
              },
              {
                "box": {
                  "id": "lat-cancel-reason-store",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    3340.0,
                    185.0,
                    22.0
                  ],
                  "text": "i 100"
                }
              },
              {
                "box": {
                  "id": "lat-cancel-reason-select",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 45,
                  "patching_rect": [
                    20.0,
                    3385.0,
                    185.0,
                    22.0
                  ],
                  "text": "sel 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 200 201 202 203 204 205 206 207 208 209 210 211 212 213 300 301 302 303 400 401 402 403 404 405"
                }
              },
              {
                "box": {
                  "id": "lat-cancel-help-100",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    3385.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare anulată: Cauza anulării nu a fost identificată. Valoarea existentă este păstrată. [C100]"
                }
              },
              {
                "box": {
                  "id": "lat-cancel-help-101",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    3385.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare anulată: Pragul microfonului s-a schimbat. Valoarea existentă este păstrată. [C101]"
                }
              },
              {
                "box": {
                  "id": "lat-cancel-help-102",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    620.0,
                    3385.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare anulată: Starea analizei s-a schimbat. Valoarea existentă este păstrată. [C102]"
                }
              },
              {
                "box": {
                  "id": "lat-cancel-help-103",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    3385.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare anulată: Oprirea automată s-a schimbat. Valoarea existentă este păstrată. [C103]"
                }
              },
              {
                "box": {
                  "id": "lat-cancel-help-104",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    3385.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare anulată: Grila ritmică s-a schimbat. Valoarea existentă este păstrată. [C104]"
                }
              },
              {
                "box": {
                  "id": "lat-cancel-help-105",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    3430.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare anulată: Toleranța s-a schimbat. Valoarea existentă este păstrată. [C105]"
                }
              },
              {
                "box": {
                  "id": "lat-cancel-help-106",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    3430.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare anulată: Compensarea a fost modificată. Valoarea existentă este păstrată. [C106]"
                }
              },
              {
                "box": {
                  "id": "lat-cancel-help-107",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    3430.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare anulată: Reset a fost apăsat. Valoarea existentă este păstrată. [C107]"
                }
              },
              {
                "box": {
                  "id": "lat-cancel-help-108",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    620.0,
                    3430.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare anulată: Sursa instrumentalului a fost schimbată. Valoarea existentă este păstrată. [C108]"
                }
              },
              {
                "box": {
                  "id": "lat-cancel-help-109",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    3430.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare anulată: Canalul instrumentalului a fost schimbat. Valoarea existentă este păstrată. [C109]"
                }
              },
              {
                "box": {
                  "id": "lat-cancel-help-110",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    3430.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare anulată: Actualizarea surselor a fost cerută. Valoarea existentă este păstrată. [C110]"
                }
              },
              {
                "box": {
                  "id": "lat-cancel-help-111",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    3475.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare anulată: Ableton a schimbat sursa instrumentalului. Valoarea existentă este păstrată. [C111]"
                }
              },
              {
                "box": {
                  "id": "lat-cancel-help-112",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    3475.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare anulată: Ableton a schimbat canalul instrumentalului. Valoarea existentă este păstrată. [C112]"
                }
              },
              {
                "box": {
                  "id": "lat-cancel-help-113",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    3475.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare anulată: Dispozitivul a fost reinițializat. Valoarea existentă este păstrată. [C113]"
                }
              },
              {
                "box": {
                  "id": "lat-cancel-help-114",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    620.0,
                    3475.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare anulată: Condițiile de calibrare s-au schimbat. Valoarea existentă este păstrată. [C114]"
                }
              },
              {
                "box": {
                  "id": "lat-cancel-help-115",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    3475.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare anulată: Starea procesării audio s-a schimbat. Valoarea existentă este păstrată. [C115]"
                }
              },
              {
                "box": {
                  "id": "lat-cancel-help-116",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    3475.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare anulată: Rata de eșantionare s-a schimbat. Valoarea existentă este păstrată. [C116]"
                }
              },
              {
                "box": {
                  "id": "lat-cancel-help-117",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    3520.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare anulată: Vectorul DSP s-a schimbat. Valoarea existentă este păstrată. [C117]"
                }
              },
              {
                "box": {
                  "id": "lat-cancel-help-118",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    3520.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare anulată: Vectorul audio I/O s-a schimbat. Valoarea existentă este păstrată. [C118]"
                }
              },
              {
                "box": {
                  "id": "lat-cancel-help-119",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    3520.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare anulată: Calibrarea automată a fost dezactivată. Valoarea existentă este păstrată. [C119]"
                }
              },
              {
                "box": {
                  "id": "lat-cancel-help-200",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    620.0,
                    3520.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare anulată: Condițiile de calibrare s-au schimbat fără un motiv disponibil. Valoarea existentă este păstrată. [C200]"
                }
              },
              {
                "box": {
                  "id": "lat-cancel-help-201",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    3520.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare anulată: Analiza a fost oprită. Valoarea existentă este păstrată. [C201]"
                }
              },
              {
                "box": {
                  "id": "lat-cancel-help-202",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    3520.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare anulată: Oprirea automată a fost activată. Valoarea existentă este păstrată. [C202]"
                }
              },
              {
                "box": {
                  "id": "lat-cancel-help-203",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    3565.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare anulată: Redarea a fost oprită. Valoarea existentă este păstrată. [C203]"
                }
              },
              {
                "box": {
                  "id": "lat-cancel-help-204",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    3565.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare anulată: Conexiunea cu Ableton s-a întrerupt. Valoarea existentă este păstrată. [C204]"
                }
              },
              {
                "box": {
                  "id": "lat-cancel-help-205",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    3565.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare anulată: Dispozitivul a fost dezactivat. Valoarea existentă este păstrată. [C205]"
                }
              },
              {
                "box": {
                  "id": "lat-cancel-help-206",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    620.0,
                    3565.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare anulată: Activitatea audio s-a întrerupt. Valoarea existentă este păstrată. [C206]"
                }
              },
              {
                "box": {
                  "id": "lat-cancel-help-207",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    3565.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare anulată: Starea REC nu mai este confirmată. Valoarea existentă este păstrată. [C207]"
                }
              },
              {
                "box": {
                  "id": "lat-cancel-help-208",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    3565.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare anulată: REC a fost activat. Valoarea existentă este păstrată. [C208]"
                }
              },
              {
                "box": {
                  "id": "lat-cancel-help-209",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    3610.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare anulată: Starea Session Record nu mai este confirmată. Valoarea existentă este păstrată. [C209]"
                }
              },
              {
                "box": {
                  "id": "lat-cancel-help-210",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    3610.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare anulată: Session Record a fost activat. Valoarea existentă este păstrată. [C210]"
                }
              },
              {
                "box": {
                  "id": "lat-cancel-help-211",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    3610.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare anulată: Starea înregistrării Session nu mai este confirmată. Valoarea existentă este păstrată. [C211]"
                }
              },
              {
                "box": {
                  "id": "lat-cancel-help-212",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    620.0,
                    3610.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare anulată: Înregistrarea Session a fost activată. Valoarea existentă este păstrată. [C212]"
                }
              },
              {
                "box": {
                  "id": "lat-cancel-help-213",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    3610.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare anulată: Starea redării nu mai este confirmată. Valoarea existentă este păstrată. [C213]"
                }
              },
              {
                "box": {
                  "id": "lat-cancel-help-300",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    3610.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare anulată: Ceasul audio a pierdut sincronizarea. Valoarea existentă este păstrată. [C300]"
                }
              },
              {
                "box": {
                  "id": "lat-cancel-help-301",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    3655.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare anulată: Rata de eșantionare s-a schimbat în DSP. Valoarea existentă este păstrată. [C301]"
                }
              },
              {
                "box": {
                  "id": "lat-cancel-help-302",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    3655.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare anulată: Semnalul de sincronizare a rămas invalid. Valoarea existentă este păstrată. [C302]"
                }
              },
              {
                "box": {
                  "id": "lat-cancel-help-303",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    3655.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare anulată: Poziția ritmică a făcut un salt mare. Valoarea existentă este păstrată. [C303]"
                }
              },
              {
                "box": {
                  "id": "lat-cancel-help-400",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    620.0,
                    3655.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare anulată: Aplicarea rezultatului nu a fost confirmată. Valoarea existentă este păstrată. [C400]"
                }
              },
              {
                "box": {
                  "id": "lat-cancel-help-401",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    3655.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare anulată: Condițiile Ableton s-au schimbat înaintea aplicării. Valoarea existentă este păstrată. [C401]"
                }
              },
              {
                "box": {
                  "id": "lat-cancel-help-402",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    3655.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare anulată: Cererea nu mai era activă la aplicare. Valoarea existentă este păstrată. [C402]"
                }
              },
              {
                "box": {
                  "id": "lat-cancel-help-403",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    3700.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare anulată: Rezultatul aparține altei cereri. Valoarea existentă este păstrată. [C403]"
                }
              },
              {
                "box": {
                  "id": "lat-cancel-help-404",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    3700.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare anulată: Calitatea rezultatului nu era confirmată la aplicare. Valoarea existentă este păstrată. [C404]"
                }
              },
              {
                "box": {
                  "id": "lat-cancel-help-405",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    3700.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare anulată: Rezultatul depășea intervalul permis. Valoarea existentă este păstrată. [C405]"
                }
              },
              {
                "box": {
                  "id": "lat-reason-store",
                  "maxclass": "newobj",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    620.0,
                    3700.0,
                    185.0,
                    22.0
                  ],
                  "text": "i 4"
                }
              },
              {
                "box": {
                  "id": "lat-reason-select",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 15,
                  "patching_rect": [
                    820.0,
                    3700.0,
                    185.0,
                    22.0
                  ],
                  "text": "sel 0 1 2 3 4 5 6 7 8 9 10 11 12 13"
                }
              },
              {
                "box": {
                  "id": "lat-reason-0",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    3700.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Calibrare nepornită. Așteaptă stabilizarea și reîncearcă."
                }
              },
              {
                "box": {
                  "id": "lat-reason-1",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    3745.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Activează analiza pentru calibrare."
                }
              },
              {
                "box": {
                  "id": "lat-reason-2",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    3745.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Lasă Oprire auto OFF în timpul calibrării."
                }
              },
              {
                "box": {
                  "id": "lat-reason-3",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    3745.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Pornește redarea și așteaptă sincronizarea."
                }
              },
              {
                "box": {
                  "id": "lat-reason-4",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    620.0,
                    3745.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Aștept conexiunea cu Ableton pentru calibrare."
                }
              },
              {
                "box": {
                  "id": "lat-reason-5",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    3745.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Activează dispozitivul pentru calibrare."
                }
              },
              {
                "box": {
                  "id": "lat-reason-6",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    3745.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Aștept procesarea audio pentru calibrare."
                }
              },
              {
                "box": {
                  "id": "lat-reason-7",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    3790.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Aștept confirmarea stării REC din Ableton."
                }
              },
              {
                "box": {
                  "id": "lat-reason-8",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    3790.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Oprește REC pentru calibrare."
                }
              },
              {
                "box": {
                  "id": "lat-reason-9",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    3790.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Aștept confirmarea stării Session Record din Ableton."
                }
              },
              {
                "box": {
                  "id": "lat-reason-10",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    620.0,
                    3790.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Oprește Session Record pentru calibrare."
                }
              },
              {
                "box": {
                  "id": "lat-reason-11",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    3790.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Aștept confirmarea stării de înregistrare Session."
                }
              },
              {
                "box": {
                  "id": "lat-reason-12",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    3790.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Înregistrarea Session este activă. Oprește-o pentru calibrare."
                }
              },
              {
                "box": {
                  "id": "lat-reason-13",
                  "maxclass": "message",
                  "numinlets": 2,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    3835.0,
                    185.0,
                    22.0
                  ],
                  "text": "set Aștept confirmarea redării din Ableton."
                }
              },
              {
                "box": {
                  "id": "lat-request-out",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    500.0,
                    20.0,
                    25.0,
                    25.0
                  ],
                  "text": "outlet"
                }
              },
              {
                "box": {
                  "id": "lat-click",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    220.0,
                    3835.0,
                    185.0,
                    22.0
                  ],
                  "text": "t b"
                }
              },
              {
                "box": {
                  "id": "ac-valid",
                  "maxclass": "number",
                  "numinlets": 1,
                  "numoutlets": 2,
                  "patching_rect": [
                    420.0,
                    3835.0,
                    185.0,
                    22.0
                  ],
                  "minimum": 0,
                  "maximum": 1,
                  "parameter_enable": 1,
                  "parameter_mappable": 0,
                  "varname": "vtm_calibration_valid",
                  "saved_attribute_attributes": {
                    "valueof": {
                      "parameter_longname": "VTM Compensation valid",
                      "parameter_shortname": "VTM Compensation valid",
                      "parameter_type": 1,
                      "parameter_invisible": 1,
                      "parameter_initial_enable": 1,
                      "parameter_initial": [
                        0
                      ],
                      "parameter_order": 14,
                      "parameter_mmin": 0.0,
                      "parameter_mmax": 1.0
                    }
                  }
                }
              },
              {
                "box": {
                  "id": "ac-out",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    740.0,
                    20.0,
                    25.0,
                    25.0
                  ],
                  "text": "outlet"
                }
              },
              {
                "box": {
                  "id": "ac-autocalenabled",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    620.0,
                    3835.0,
                    185.0,
                    22.0
                  ],
                  "text": "prepend autocalenabled"
                }
              },
              {
                "box": {
                  "id": "ac-autocalenabled-replay",
                  "maxclass": "newobj",
                  "numinlets": 3,
                  "numoutlets": 3,
                  "patching_rect": [
                    820.0,
                    3835.0,
                    185.0,
                    22.0
                  ],
                  "saved_object_attributes": {
                    "parameter_enable": 0
                  },
                  "text": "pattr @bindto vtm_auto_calibrate @thru 0 @autorestore 0"
                }
              },
              {
                "box": {
                  "id": "ac-autocalenabled-defer",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    1020.0,
                    3835.0,
                    185.0,
                    22.0
                  ],
                  "text": "deferlow"
                }
              },
              {
                "box": {
                  "id": "ac-autocalvalid",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    20.0,
                    3880.0,
                    185.0,
                    22.0
                  ],
                  "text": "prepend autocalvalid"
                }
              },
              {
                "box": {
                  "id": "ac-autocalvalid-replay",
                  "maxclass": "newobj",
                  "numinlets": 3,
                  "numoutlets": 3,
                  "patching_rect": [
                    220.0,
                    3880.0,
                    185.0,
                    22.0
                  ],
                  "saved_object_attributes": {
                    "parameter_enable": 0
                  },
                  "text": "pattr @bindto vtm_calibration_valid @thru 0 @autorestore 0"
                }
              },
              {
                "box": {
                  "id": "ac-autocalvalid-defer",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 1,
                  "patching_rect": [
                    420.0,
                    3880.0,
                    185.0,
                    22.0
                  ],
                  "text": "deferlow"
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
                  ]
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
                  ],
                  "order": 0
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
                  ],
                  "order": 0
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
                  ],
                  "order": 0
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
                  ]
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
                  ],
                  "order": 0
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
                  ],
                  "order": 0
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
                  ],
                  "order": 0
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
              },
              {
                "patchline": {
                  "source": [
                    "state-select",
                    0
                  ],
                  "destination": [
                    "mark-0",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "mark-0",
                    0
                  ],
                  "destination": [
                    "status-mark",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "state-select",
                    1
                  ],
                  "destination": [
                    "mark-1",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "mark-1",
                    0
                  ],
                  "destination": [
                    "status-mark",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "state-select",
                    2
                  ],
                  "destination": [
                    "mark-2",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "mark-2",
                    0
                  ],
                  "destination": [
                    "status-mark",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "state-select",
                    3
                  ],
                  "destination": [
                    "mark-3",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "mark-3",
                    0
                  ],
                  "destination": [
                    "status-mark",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "state-select",
                    4
                  ],
                  "destination": [
                    "mark-4",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "mark-4",
                    0
                  ],
                  "destination": [
                    "status-mark",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "state-select",
                    5
                  ],
                  "destination": [
                    "mark-5",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "mark-5",
                    0
                  ],
                  "destination": [
                    "status-mark",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "state-select",
                    6
                  ],
                  "destination": [
                    "mark-6",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "mark-6",
                    0
                  ],
                  "destination": [
                    "status-mark",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "state-select",
                    7
                  ],
                  "destination": [
                    "mark-7",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "mark-7",
                    0
                  ],
                  "destination": [
                    "status-mark",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "state-select",
                    8
                  ],
                  "destination": [
                    "mark-8",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "mark-8",
                    0
                  ],
                  "destination": [
                    "status-mark",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "state-select",
                    9
                  ],
                  "destination": [
                    "mark-9",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "mark-9",
                    0
                  ],
                  "destination": [
                    "status-mark",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "state-select",
                    10
                  ],
                  "destination": [
                    "mark-10",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "mark-10",
                    0
                  ],
                  "destination": [
                    "status-mark",
                    0
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
                    "ui-sign",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-sign",
                    0
                  ],
                  "destination": [
                    "ui-sign-select",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-sign-select",
                    0
                  ],
                  "destination": [
                    "ui-sign-0",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-sign-0",
                    0
                  ],
                  "destination": [
                    "sign-caption",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-sign-select",
                    1
                  ],
                  "destination": [
                    "ui-sign-1",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-sign-1",
                    0
                  ],
                  "destination": [
                    "sign-caption",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-sign-select",
                    2
                  ],
                  "destination": [
                    "ui-sign-2",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-sign-2",
                    0
                  ],
                  "destination": [
                    "sign-caption",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "hasdelta-select",
                    0
                  ],
                  "destination": [
                    "ui-sign-clear",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-sign-clear",
                    0
                  ],
                  "destination": [
                    "sign-caption",
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
                    "ui-level-clip",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-clip",
                    0
                  ],
                  "destination": [
                    "ui-level-set",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-set",
                    0
                  ],
                  "destination": [
                    "input-meter",
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
                    "ui-threshold-set",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-threshold-set",
                    0
                  ],
                  "destination": [
                    "threshold-meter",
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
                    "ui-level-pak",
                    0
                  ],
                  "order": 2
                }
              },
              {
                "patchline": {
                  "source": [
                    "gatedb",
                    0
                  ],
                  "destination": [
                    "ui-level-pak",
                    1
                  ],
                  "order": 2
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-pak",
                    0
                  ],
                  "destination": [
                    "ui-level-unpack",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-unpack",
                    0
                  ],
                  "destination": [
                    "ui-level-class",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-unpack",
                    1
                  ],
                  "destination": [
                    "ui-level-class",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-class",
                    0
                  ],
                  "destination": [
                    "ui-level-change",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-change",
                    0
                  ],
                  "destination": [
                    "ui-level-select",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-select",
                    0
                  ],
                  "destination": [
                    "ui-level-label-0",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-label-0",
                    0
                  ],
                  "destination": [
                    "level-feedback",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-select",
                    1
                  ],
                  "destination": [
                    "ui-level-label-1",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-label-1",
                    0
                  ],
                  "destination": [
                    "level-feedback",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-select",
                    2
                  ],
                  "destination": [
                    "ui-level-label-2",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-label-2",
                    0
                  ],
                  "destination": [
                    "level-feedback",
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
                    "ui-tolerance-pak",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "route",
                    7
                  ],
                  "destination": [
                    "ui-tolerance-pak",
                    1
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-tolerance-pak",
                    0
                  ],
                  "destination": [
                    "ui-tolerance-unpack",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-tolerance-unpack",
                    0
                  ],
                  "destination": [
                    "ui-tolerance-invalid",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-tolerance-unpack",
                    1
                  ],
                  "destination": [
                    "ui-tolerance-invalid",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-tolerance-invalid",
                    0
                  ],
                  "destination": [
                    "ui-tolerance-select",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-tolerance-select",
                    0
                  ],
                  "destination": [
                    "ui-tolerance-label-0",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-tolerance-label-0",
                    0
                  ],
                  "destination": [
                    "rhythm-hint",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-tolerance-select",
                    1
                  ],
                  "destination": [
                    "ui-tolerance-label-1",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-tolerance-label-1",
                    0
                  ],
                  "destination": [
                    "rhythm-hint",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "advanced",
                    0
                  ],
                  "destination": [
                    "ui-page-select",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-page-select",
                    0
                  ],
                  "destination": [
                    "ui-page-0",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-page-0",
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
                    "ui-page-select",
                    0
                  ],
                  "destination": [
                    "ui-page-title-0",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-page-title-0",
                    0
                  ],
                  "destination": [
                    "settings-heading",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-page-select",
                    1
                  ],
                  "destination": [
                    "ui-page-1",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-page-1",
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
                    "ui-page-select",
                    1
                  ],
                  "destination": [
                    "ui-page-title-1",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-page-title-1",
                    0
                  ],
                  "destination": [
                    "settings-heading",
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
                    "ui-state-trigger",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-state-trigger",
                    1
                  ],
                  "destination": [
                    "ui-state-memory",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-state-trigger",
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
                    "ui-state-memory",
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
                    "theme",
                    0
                  ],
                  "destination": [
                    "ui-theme-trigger",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-theme-trigger",
                    1
                  ],
                  "destination": [
                    "ui-theme-select",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-theme-trigger",
                    1
                  ],
                  "destination": [
                    "ui-device-theme-out",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-theme-trigger",
                    0
                  ],
                  "destination": [
                    "ui-state-memory",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "initialize",
                    6
                  ],
                  "destination": [
                    "ui-theme-replay",
                    0
                  ],
                  "order": 4
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-theme-replay",
                    0
                  ],
                  "destination": [
                    "ui-theme-trigger",
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
                    "ui-view-initial",
                    0
                  ],
                  "order": 5
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-view-initial",
                    0
                  ],
                  "destination": [
                    "settings",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-view-initial",
                    0
                  ],
                  "destination": [
                    "advanced",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "initialize",
                    6
                  ],
                  "destination": [
                    "ui-page-initial",
                    0
                  ],
                  "order": 6
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-page-initial",
                    0
                  ],
                  "destination": [
                    "ui-page-select",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-page-initial",
                    0
                  ],
                  "destination": [
                    "settings-trigger",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "state-select",
                    0
                  ],
                  "destination": [
                    "ui-state-theme-0",
                    0
                  ],
                  "order": 2
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-theme-trigger",
                    1
                  ],
                  "destination": [
                    "ui-state-theme-0",
                    1
                  ],
                  "order": 2
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-state-theme-0",
                    0
                  ],
                  "destination": [
                    "ui-state-color-select-0",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-state-color-select-0",
                    0
                  ],
                  "destination": [
                    "color-0",
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
                    "status-mark",
                    0
                  ],
                  "order": 2
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-state-color-select-0",
                    1
                  ],
                  "destination": [
                    "ui-light-color-0",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-light-color-0",
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
                    "ui-light-color-0",
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
                    "ui-light-color-0",
                    0
                  ],
                  "destination": [
                    "status-mark",
                    0
                  ],
                  "order": 2
                }
              },
              {
                "patchline": {
                  "source": [
                    "state-select",
                    1
                  ],
                  "destination": [
                    "ui-state-theme-1",
                    0
                  ],
                  "order": 2
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-theme-trigger",
                    1
                  ],
                  "destination": [
                    "ui-state-theme-1",
                    1
                  ],
                  "order": 3
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-state-theme-1",
                    0
                  ],
                  "destination": [
                    "ui-state-color-select-1",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-state-color-select-1",
                    0
                  ],
                  "destination": [
                    "color-1",
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
                    "status-mark",
                    0
                  ],
                  "order": 2
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-state-color-select-1",
                    1
                  ],
                  "destination": [
                    "ui-light-color-1",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-light-color-1",
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
                    "ui-light-color-1",
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
                    "ui-light-color-1",
                    0
                  ],
                  "destination": [
                    "status-mark",
                    0
                  ],
                  "order": 2
                }
              },
              {
                "patchline": {
                  "source": [
                    "state-select",
                    2
                  ],
                  "destination": [
                    "ui-state-theme-2",
                    0
                  ],
                  "order": 2
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-theme-trigger",
                    1
                  ],
                  "destination": [
                    "ui-state-theme-2",
                    1
                  ],
                  "order": 4
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-state-theme-2",
                    0
                  ],
                  "destination": [
                    "ui-state-color-select-2",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-state-color-select-2",
                    0
                  ],
                  "destination": [
                    "color-2",
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
                    "status-mark",
                    0
                  ],
                  "order": 2
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-state-color-select-2",
                    1
                  ],
                  "destination": [
                    "ui-light-color-2",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-light-color-2",
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
                    "ui-light-color-2",
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
                    "ui-light-color-2",
                    0
                  ],
                  "destination": [
                    "status-mark",
                    0
                  ],
                  "order": 2
                }
              },
              {
                "patchline": {
                  "source": [
                    "state-select",
                    3
                  ],
                  "destination": [
                    "ui-state-theme-3",
                    0
                  ],
                  "order": 2
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-theme-trigger",
                    1
                  ],
                  "destination": [
                    "ui-state-theme-3",
                    1
                  ],
                  "order": 5
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-state-theme-3",
                    0
                  ],
                  "destination": [
                    "ui-state-color-select-3",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-state-color-select-3",
                    0
                  ],
                  "destination": [
                    "color-3",
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
                    "status-mark",
                    0
                  ],
                  "order": 2
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-state-color-select-3",
                    1
                  ],
                  "destination": [
                    "ui-light-color-3",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-light-color-3",
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
                    "ui-light-color-3",
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
                    "ui-light-color-3",
                    0
                  ],
                  "destination": [
                    "status-mark",
                    0
                  ],
                  "order": 2
                }
              },
              {
                "patchline": {
                  "source": [
                    "state-select",
                    4
                  ],
                  "destination": [
                    "ui-state-theme-4",
                    0
                  ],
                  "order": 2
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-theme-trigger",
                    1
                  ],
                  "destination": [
                    "ui-state-theme-4",
                    1
                  ],
                  "order": 6
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-state-theme-4",
                    0
                  ],
                  "destination": [
                    "ui-state-color-select-4",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-state-color-select-4",
                    0
                  ],
                  "destination": [
                    "color-4",
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
                    "status-mark",
                    0
                  ],
                  "order": 2
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-state-color-select-4",
                    1
                  ],
                  "destination": [
                    "ui-light-color-4",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-light-color-4",
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
                    "ui-light-color-4",
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
                    "ui-light-color-4",
                    0
                  ],
                  "destination": [
                    "status-mark",
                    0
                  ],
                  "order": 2
                }
              },
              {
                "patchline": {
                  "source": [
                    "state-select",
                    5
                  ],
                  "destination": [
                    "ui-state-theme-5",
                    0
                  ],
                  "order": 2
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-theme-trigger",
                    1
                  ],
                  "destination": [
                    "ui-state-theme-5",
                    1
                  ],
                  "order": 7
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-state-theme-5",
                    0
                  ],
                  "destination": [
                    "ui-state-color-select-5",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-state-color-select-5",
                    0
                  ],
                  "destination": [
                    "color-5",
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
                    "status-mark",
                    0
                  ],
                  "order": 2
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-state-color-select-5",
                    1
                  ],
                  "destination": [
                    "ui-light-color-5",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-light-color-5",
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
                    "ui-light-color-5",
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
                    "ui-light-color-5",
                    0
                  ],
                  "destination": [
                    "status-mark",
                    0
                  ],
                  "order": 2
                }
              },
              {
                "patchline": {
                  "source": [
                    "state-select",
                    6
                  ],
                  "destination": [
                    "ui-state-theme-6",
                    0
                  ],
                  "order": 2
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-theme-trigger",
                    1
                  ],
                  "destination": [
                    "ui-state-theme-6",
                    1
                  ],
                  "order": 8
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-state-theme-6",
                    0
                  ],
                  "destination": [
                    "ui-state-color-select-6",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-state-color-select-6",
                    0
                  ],
                  "destination": [
                    "color-6",
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
                    "status-mark",
                    0
                  ],
                  "order": 2
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-state-color-select-6",
                    1
                  ],
                  "destination": [
                    "ui-light-color-6",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-light-color-6",
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
                    "ui-light-color-6",
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
                    "ui-light-color-6",
                    0
                  ],
                  "destination": [
                    "status-mark",
                    0
                  ],
                  "order": 2
                }
              },
              {
                "patchline": {
                  "source": [
                    "state-select",
                    7
                  ],
                  "destination": [
                    "ui-state-theme-7",
                    0
                  ],
                  "order": 2
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-theme-trigger",
                    1
                  ],
                  "destination": [
                    "ui-state-theme-7",
                    1
                  ],
                  "order": 9
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-state-theme-7",
                    0
                  ],
                  "destination": [
                    "ui-state-color-select-7",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-state-color-select-7",
                    0
                  ],
                  "destination": [
                    "color-7",
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
                    "status-mark",
                    0
                  ],
                  "order": 2
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-state-color-select-7",
                    1
                  ],
                  "destination": [
                    "ui-light-color-7",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-light-color-7",
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
                    "ui-light-color-7",
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
                    "ui-light-color-7",
                    0
                  ],
                  "destination": [
                    "status-mark",
                    0
                  ],
                  "order": 2
                }
              },
              {
                "patchline": {
                  "source": [
                    "state-select",
                    8
                  ],
                  "destination": [
                    "ui-state-theme-8",
                    0
                  ],
                  "order": 2
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-theme-trigger",
                    1
                  ],
                  "destination": [
                    "ui-state-theme-8",
                    1
                  ],
                  "order": 10
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-state-theme-8",
                    0
                  ],
                  "destination": [
                    "ui-state-color-select-8",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-state-color-select-8",
                    0
                  ],
                  "destination": [
                    "color-8",
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
                    "status-mark",
                    0
                  ],
                  "order": 2
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-state-color-select-8",
                    1
                  ],
                  "destination": [
                    "ui-light-color-8",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-light-color-8",
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
                    "ui-light-color-8",
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
                    "ui-light-color-8",
                    0
                  ],
                  "destination": [
                    "status-mark",
                    0
                  ],
                  "order": 2
                }
              },
              {
                "patchline": {
                  "source": [
                    "state-select",
                    9
                  ],
                  "destination": [
                    "ui-state-theme-9",
                    0
                  ],
                  "order": 2
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-theme-trigger",
                    1
                  ],
                  "destination": [
                    "ui-state-theme-9",
                    1
                  ],
                  "order": 11
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-state-theme-9",
                    0
                  ],
                  "destination": [
                    "ui-state-color-select-9",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-state-color-select-9",
                    0
                  ],
                  "destination": [
                    "color-9",
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
                    "status-mark",
                    0
                  ],
                  "order": 2
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-state-color-select-9",
                    1
                  ],
                  "destination": [
                    "ui-light-color-9",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-light-color-9",
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
                    "ui-light-color-9",
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
                    "ui-light-color-9",
                    0
                  ],
                  "destination": [
                    "status-mark",
                    0
                  ],
                  "order": 2
                }
              },
              {
                "patchline": {
                  "source": [
                    "state-select",
                    10
                  ],
                  "destination": [
                    "ui-state-theme-10",
                    0
                  ],
                  "order": 2
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-theme-trigger",
                    1
                  ],
                  "destination": [
                    "ui-state-theme-10",
                    1
                  ],
                  "order": 12
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-state-theme-10",
                    0
                  ],
                  "destination": [
                    "ui-state-color-select-10",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-state-color-select-10",
                    0
                  ],
                  "destination": [
                    "color-10",
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
                    "status-mark",
                    0
                  ],
                  "order": 2
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-state-color-select-10",
                    1
                  ],
                  "destination": [
                    "ui-light-color-10",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-light-color-10",
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
                    "ui-light-color-10",
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
                    "ui-light-color-10",
                    0
                  ],
                  "destination": [
                    "status-mark",
                    0
                  ],
                  "order": 2
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-theme-select",
                    0
                  ],
                  "destination": [
                    "ui-palette-0",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-palette-0",
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
                    "ui-theme-select",
                    1
                  ],
                  "destination": [
                    "ui-palette-1",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-palette-1",
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
                    "level-db",
                    0
                  ],
                  "destination": [
                    "ui-level-memory",
                    1
                  ],
                  "order": 3
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-theme-trigger",
                    0
                  ],
                  "destination": [
                    "ui-level-refresh",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-refresh",
                    1
                  ],
                  "destination": [
                    "ui-level-refresh-reset",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-refresh-reset",
                    0
                  ],
                  "destination": [
                    "ui-level-change",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-refresh",
                    0
                  ],
                  "destination": [
                    "ui-level-memory",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-memory",
                    0
                  ],
                  "destination": [
                    "ui-level-pak",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-select",
                    0
                  ],
                  "destination": [
                    "ui-level-theme-0",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-theme-trigger",
                    1
                  ],
                  "destination": [
                    "ui-level-theme-0",
                    1
                  ],
                  "order": 13
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-theme-0",
                    0
                  ],
                  "destination": [
                    "ui-level-color-select-0",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-color-select-0",
                    0
                  ],
                  "destination": [
                    "ui-level-color-0-0",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-color-0-0",
                    0
                  ],
                  "destination": [
                    "level-feedback",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-color-0-0",
                    0
                  ],
                  "destination": [
                    "level-text",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-color-select-0",
                    0
                  ],
                  "destination": [
                    "ui-meter-color-0-0",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-meter-color-0-0",
                    0
                  ],
                  "destination": [
                    "input-meter",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-color-select-0",
                    1
                  ],
                  "destination": [
                    "ui-level-color-0-1",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-color-0-1",
                    0
                  ],
                  "destination": [
                    "level-feedback",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-color-0-1",
                    0
                  ],
                  "destination": [
                    "level-text",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-color-select-0",
                    1
                  ],
                  "destination": [
                    "ui-meter-color-0-1",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-meter-color-0-1",
                    0
                  ],
                  "destination": [
                    "input-meter",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-select",
                    1
                  ],
                  "destination": [
                    "ui-level-theme-1",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-theme-trigger",
                    1
                  ],
                  "destination": [
                    "ui-level-theme-1",
                    1
                  ],
                  "order": 14
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-theme-1",
                    0
                  ],
                  "destination": [
                    "ui-level-color-select-1",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-color-select-1",
                    0
                  ],
                  "destination": [
                    "ui-level-color-1-0",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-color-1-0",
                    0
                  ],
                  "destination": [
                    "level-feedback",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-color-1-0",
                    0
                  ],
                  "destination": [
                    "level-text",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-color-select-1",
                    0
                  ],
                  "destination": [
                    "ui-meter-color-1-0",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-meter-color-1-0",
                    0
                  ],
                  "destination": [
                    "input-meter",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-color-select-1",
                    1
                  ],
                  "destination": [
                    "ui-level-color-1-1",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-color-1-1",
                    0
                  ],
                  "destination": [
                    "level-feedback",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-color-1-1",
                    0
                  ],
                  "destination": [
                    "level-text",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-color-select-1",
                    1
                  ],
                  "destination": [
                    "ui-meter-color-1-1",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-meter-color-1-1",
                    0
                  ],
                  "destination": [
                    "input-meter",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-select",
                    2
                  ],
                  "destination": [
                    "ui-level-theme-2",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-theme-trigger",
                    1
                  ],
                  "destination": [
                    "ui-level-theme-2",
                    1
                  ],
                  "order": 15
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-theme-2",
                    0
                  ],
                  "destination": [
                    "ui-level-color-select-2",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-color-select-2",
                    0
                  ],
                  "destination": [
                    "ui-level-color-2-0",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-color-2-0",
                    0
                  ],
                  "destination": [
                    "level-feedback",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-color-2-0",
                    0
                  ],
                  "destination": [
                    "level-text",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-color-select-2",
                    0
                  ],
                  "destination": [
                    "ui-meter-color-2-0",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-meter-color-2-0",
                    0
                  ],
                  "destination": [
                    "input-meter",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-color-select-2",
                    1
                  ],
                  "destination": [
                    "ui-level-color-2-1",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-color-2-1",
                    0
                  ],
                  "destination": [
                    "level-feedback",
                    0
                  ],
                  "order": 0
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-color-2-1",
                    0
                  ],
                  "destination": [
                    "level-text",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-level-color-select-2",
                    1
                  ],
                  "destination": [
                    "ui-meter-color-2-1",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "ui-meter-color-2-1",
                    0
                  ],
                  "destination": [
                    "input-meter",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "route",
                    19
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
                    "route",
                    20
                  ],
                  "destination": [
                    "lat-status-select",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-status-select",
                    0
                  ],
                  "destination": [
                    "lat-help-0",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-help-0",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-status-select",
                    1
                  ],
                  "destination": [
                    "lat-help-1",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-help-1",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-status-select",
                    2
                  ],
                  "destination": [
                    "lat-help-2",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-help-2",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-status-select",
                    3
                  ],
                  "destination": [
                    "lat-help-3",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-help-3",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-help-4",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-help-5",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-help-6",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-status-select",
                    7
                  ],
                  "destination": [
                    "lat-help-7",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-help-7",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "route",
                    22
                  ],
                  "destination": [
                    "lat-diagnostic-store",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-status-select",
                    4
                  ],
                  "destination": [
                    "lat-diagnostic-store",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-diagnostic-store",
                    0
                  ],
                  "destination": [
                    "lat-diagnostic-route",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-diagnostic-route",
                    0
                  ],
                  "destination": [
                    "lat-diagnostic-format-0",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-diagnostic-format-0",
                    0
                  ],
                  "destination": [
                    "lat-diagnostic-set-0",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-diagnostic-set-0",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-diagnostic-route",
                    1
                  ],
                  "destination": [
                    "lat-diagnostic-format-1",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-diagnostic-format-1",
                    0
                  ],
                  "destination": [
                    "lat-diagnostic-set-1",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-diagnostic-set-1",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-diagnostic-route",
                    2
                  ],
                  "destination": [
                    "lat-diagnostic-format-2",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-diagnostic-format-2",
                    0
                  ],
                  "destination": [
                    "lat-diagnostic-set-2",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-diagnostic-set-2",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-diagnostic-route",
                    3
                  ],
                  "destination": [
                    "lat-diagnostic-format-3",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-diagnostic-format-3",
                    0
                  ],
                  "destination": [
                    "lat-diagnostic-set-3",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-diagnostic-set-3",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-diagnostic-route",
                    4
                  ],
                  "destination": [
                    "lat-diagnostic-format-4",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-diagnostic-format-4",
                    0
                  ],
                  "destination": [
                    "lat-diagnostic-set-4",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-diagnostic-set-4",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-diagnostic-route",
                    5
                  ],
                  "destination": [
                    "lat-diagnostic-format-5",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-diagnostic-format-5",
                    0
                  ],
                  "destination": [
                    "lat-diagnostic-set-5",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-diagnostic-set-5",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-diagnostic-route",
                    6
                  ],
                  "destination": [
                    "lat-diagnostic-format-6",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-diagnostic-format-6",
                    0
                  ],
                  "destination": [
                    "lat-diagnostic-set-6",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-diagnostic-set-6",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-diagnostic-route",
                    7
                  ],
                  "destination": [
                    "lat-diagnostic-format-7",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-diagnostic-format-7",
                    0
                  ],
                  "destination": [
                    "lat-diagnostic-set-7",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-diagnostic-set-7",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-diagnostic-route",
                    8
                  ],
                  "destination": [
                    "lat-diagnostic-format-8",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-diagnostic-format-8",
                    0
                  ],
                  "destination": [
                    "lat-diagnostic-set-8",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-diagnostic-set-8",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-diagnostic-route",
                    9
                  ],
                  "destination": [
                    "lat-diagnostic-format-9",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-diagnostic-format-9",
                    0
                  ],
                  "destination": [
                    "lat-diagnostic-set-9",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-diagnostic-set-9",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-diagnostic-route",
                    10
                  ],
                  "destination": [
                    "lat-help-4",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "route",
                    23
                  ],
                  "destination": [
                    "lat-cancel-reason-store",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-status-select",
                    5
                  ],
                  "destination": [
                    "lat-cancel-reason-store",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-reason-store",
                    0
                  ],
                  "destination": [
                    "lat-cancel-reason-select",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-reason-select",
                    0
                  ],
                  "destination": [
                    "lat-cancel-help-100",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-help-100",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-reason-select",
                    1
                  ],
                  "destination": [
                    "lat-cancel-help-101",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-help-101",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-reason-select",
                    2
                  ],
                  "destination": [
                    "lat-cancel-help-102",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-help-102",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-reason-select",
                    3
                  ],
                  "destination": [
                    "lat-cancel-help-103",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-help-103",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-reason-select",
                    4
                  ],
                  "destination": [
                    "lat-cancel-help-104",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-help-104",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-reason-select",
                    5
                  ],
                  "destination": [
                    "lat-cancel-help-105",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-help-105",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-reason-select",
                    6
                  ],
                  "destination": [
                    "lat-cancel-help-106",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-help-106",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-reason-select",
                    7
                  ],
                  "destination": [
                    "lat-cancel-help-107",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-help-107",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-reason-select",
                    8
                  ],
                  "destination": [
                    "lat-cancel-help-108",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-help-108",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-reason-select",
                    9
                  ],
                  "destination": [
                    "lat-cancel-help-109",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-help-109",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-reason-select",
                    10
                  ],
                  "destination": [
                    "lat-cancel-help-110",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-help-110",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-reason-select",
                    11
                  ],
                  "destination": [
                    "lat-cancel-help-111",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-help-111",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-reason-select",
                    12
                  ],
                  "destination": [
                    "lat-cancel-help-112",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-help-112",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-reason-select",
                    13
                  ],
                  "destination": [
                    "lat-cancel-help-113",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-help-113",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-reason-select",
                    14
                  ],
                  "destination": [
                    "lat-cancel-help-114",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-help-114",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-reason-select",
                    15
                  ],
                  "destination": [
                    "lat-cancel-help-115",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-help-115",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-reason-select",
                    16
                  ],
                  "destination": [
                    "lat-cancel-help-116",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-help-116",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-reason-select",
                    17
                  ],
                  "destination": [
                    "lat-cancel-help-117",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-help-117",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-reason-select",
                    18
                  ],
                  "destination": [
                    "lat-cancel-help-118",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-help-118",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-reason-select",
                    19
                  ],
                  "destination": [
                    "lat-cancel-help-119",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-help-119",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-reason-select",
                    20
                  ],
                  "destination": [
                    "lat-cancel-help-200",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-help-200",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-reason-select",
                    21
                  ],
                  "destination": [
                    "lat-cancel-help-201",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-help-201",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-reason-select",
                    22
                  ],
                  "destination": [
                    "lat-cancel-help-202",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-help-202",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-reason-select",
                    23
                  ],
                  "destination": [
                    "lat-cancel-help-203",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-help-203",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-reason-select",
                    24
                  ],
                  "destination": [
                    "lat-cancel-help-204",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-help-204",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-reason-select",
                    25
                  ],
                  "destination": [
                    "lat-cancel-help-205",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-help-205",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-reason-select",
                    26
                  ],
                  "destination": [
                    "lat-cancel-help-206",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-help-206",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-reason-select",
                    27
                  ],
                  "destination": [
                    "lat-cancel-help-207",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-help-207",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-reason-select",
                    28
                  ],
                  "destination": [
                    "lat-cancel-help-208",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-help-208",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-reason-select",
                    29
                  ],
                  "destination": [
                    "lat-cancel-help-209",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-help-209",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-reason-select",
                    30
                  ],
                  "destination": [
                    "lat-cancel-help-210",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-help-210",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-reason-select",
                    31
                  ],
                  "destination": [
                    "lat-cancel-help-211",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-help-211",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-reason-select",
                    32
                  ],
                  "destination": [
                    "lat-cancel-help-212",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-help-212",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-reason-select",
                    33
                  ],
                  "destination": [
                    "lat-cancel-help-213",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-help-213",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-reason-select",
                    34
                  ],
                  "destination": [
                    "lat-cancel-help-300",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-help-300",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-reason-select",
                    35
                  ],
                  "destination": [
                    "lat-cancel-help-301",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-help-301",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-reason-select",
                    36
                  ],
                  "destination": [
                    "lat-cancel-help-302",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-help-302",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-reason-select",
                    37
                  ],
                  "destination": [
                    "lat-cancel-help-303",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-help-303",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-reason-select",
                    38
                  ],
                  "destination": [
                    "lat-cancel-help-400",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-help-400",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-reason-select",
                    39
                  ],
                  "destination": [
                    "lat-cancel-help-401",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-help-401",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-reason-select",
                    40
                  ],
                  "destination": [
                    "lat-cancel-help-402",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-help-402",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-reason-select",
                    41
                  ],
                  "destination": [
                    "lat-cancel-help-403",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-help-403",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-reason-select",
                    42
                  ],
                  "destination": [
                    "lat-cancel-help-404",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-help-404",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-reason-select",
                    43
                  ],
                  "destination": [
                    "lat-cancel-help-405",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-help-405",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-cancel-reason-select",
                    44
                  ],
                  "destination": [
                    "lat-help-5",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "route",
                    21
                  ],
                  "destination": [
                    "lat-reason-store",
                    1
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-status-select",
                    6
                  ],
                  "destination": [
                    "lat-reason-store",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-reason-store",
                    0
                  ],
                  "destination": [
                    "lat-reason-select",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-reason-select",
                    0
                  ],
                  "destination": [
                    "lat-reason-0",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-reason-0",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-reason-select",
                    1
                  ],
                  "destination": [
                    "lat-reason-1",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-reason-1",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-reason-select",
                    2
                  ],
                  "destination": [
                    "lat-reason-2",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-reason-2",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-reason-select",
                    3
                  ],
                  "destination": [
                    "lat-reason-3",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-reason-3",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-reason-select",
                    4
                  ],
                  "destination": [
                    "lat-reason-4",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-reason-4",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-reason-select",
                    5
                  ],
                  "destination": [
                    "lat-reason-5",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-reason-5",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-reason-select",
                    6
                  ],
                  "destination": [
                    "lat-reason-6",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-reason-6",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-reason-select",
                    7
                  ],
                  "destination": [
                    "lat-reason-7",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-reason-7",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-reason-select",
                    8
                  ],
                  "destination": [
                    "lat-reason-8",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-reason-8",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-reason-select",
                    9
                  ],
                  "destination": [
                    "lat-reason-9",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-reason-9",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-reason-select",
                    10
                  ],
                  "destination": [
                    "lat-reason-10",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-reason-10",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-reason-select",
                    11
                  ],
                  "destination": [
                    "lat-reason-11",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-reason-11",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-reason-select",
                    12
                  ],
                  "destination": [
                    "lat-reason-12",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-reason-12",
                    0
                  ],
                  "destination": [
                    "calibration-help",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-reason-select",
                    13
                  ],
                  "destination": [
                    "lat-reason-13",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-reason-13",
                    0
                  ],
                  "destination": [
                    "calibration-help",
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
                    "lat-click",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "lat-click",
                    0
                  ],
                  "destination": [
                    "lat-request-out",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "route",
                    24
                  ],
                  "destination": [
                    "ac-valid",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "auto-calibrate",
                    0
                  ],
                  "destination": [
                    "ac-autocalenabled",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ac-autocalenabled",
                    0
                  ],
                  "destination": [
                    "ac-out",
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
                    "ac-autocalenabled-defer",
                    0
                  ],
                  "order": 1
                }
              },
              {
                "patchline": {
                  "source": [
                    "ac-autocalenabled-defer",
                    0
                  ],
                  "destination": [
                    "ac-autocalenabled-replay",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ac-autocalenabled-replay",
                    0
                  ],
                  "destination": [
                    "ac-autocalenabled",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ac-valid",
                    0
                  ],
                  "destination": [
                    "ac-autocalvalid",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ac-autocalvalid",
                    0
                  ],
                  "destination": [
                    "ac-out",
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
                    "ac-autocalvalid-defer",
                    0
                  ],
                  "order": 2
                }
              },
              {
                "patchline": {
                  "source": [
                    "ac-autocalvalid-defer",
                    0
                  ],
                  "destination": [
                    "ac-autocalvalid-replay",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "ac-autocalvalid-replay",
                    0
                  ],
                  "destination": [
                    "ac-autocalvalid",
                    0
                  ]
                }
              }
            ],
            "autosave": 0,
            "title": "Vocal Timing Monitor | 0.9 RC1.7.1 Studio",
            "openrect": [
              60.0,
              50.0,
              640,
              370
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
      },
      {
        "box": {
          "id": "ui-device-theme-select",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            20.0,
            1765.0,
            185.0,
            22.0
          ],
          "text": "sel 0 1"
        }
      },
      {
        "box": {
          "id": "ui-device-window",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            220.0,
            1765.0,
            185.0,
            22.0
          ],
          "text": "thispatcher"
        }
      },
      {
        "box": {
          "id": "ui-device-palette-0",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            420.0,
            1765.0,
            185.0,
            22.0
          ],
          "text": "script send vtm_device_canvas bgfillcolor 0.06666666666666667 0.09019607843137255 0.13333333333333333 1.0, script send vtm_device_title textcolor 0.40784313725490196 0.8431372549019608 0.9294117647058824 1.0, script send vtm_device_version textcolor 0.6784313725490196 0.7294117647058823 0.807843137254902 1.0, script send vtm_device_note1 textcolor 0.6784313725490196 0.7294117647058823 0.807843137254902 1.0, script send vtm_device_note2 textcolor 0.6784313725490196 0.7294117647058823 0.807843137254902 1.0, script send vtm_device_open bgcolor 0.06666666666666667 0.10588235294117647 0.1568627450980392 1.0, script send vtm_device_open textcolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0, script send vtm_device_open bgoncolor 0.12941176470588237 0.28627450980392155 0.3411764705882353 1.0, script send vtm_device_open textoncolor 0.8509803921568627 0.9725490196078431 1.0 1.0, script send vtm_device_open textovercolor 0.9450980392156862 0.9607843137254902 0.984313725490196 1.0"
        }
      },
      {
        "box": {
          "id": "ui-device-palette-1",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            620.0,
            1765.0,
            185.0,
            22.0
          ],
          "text": "script send vtm_device_canvas bgfillcolor 0.9372549019607843 0.9529411764705882 0.9725490196078431 1.0, script send vtm_device_title textcolor 0.0 0.42745098039215684 0.5137254901960784 1.0, script send vtm_device_version textcolor 0.3215686274509804 0.39215686274509803 0.4666666666666667 1.0, script send vtm_device_note1 textcolor 0.3215686274509804 0.39215686274509803 0.4666666666666667 1.0, script send vtm_device_note2 textcolor 0.3215686274509804 0.39215686274509803 0.4666666666666667 1.0, script send vtm_device_open bgcolor 0.9058823529411765 0.9333333333333333 0.9607843137254902 1.0, script send vtm_device_open textcolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0, script send vtm_device_open bgoncolor 0.803921568627451 0.9176470588235294 0.9490196078431372 1.0, script send vtm_device_open textoncolor 0.0 0.23529411764705882 0.30196078431372547 1.0, script send vtm_device_open textovercolor 0.09019607843137255 0.1568627450980392 0.2196078431372549 1.0"
        }
      },
      {
        "box": {
          "id": "lat-engine",
          "maxclass": "newobj",
          "numinlets": 5,
          "numoutlets": 13,
          "patching_rect": [
            820.0,
            1765.0,
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
                  "numinlets": 5,
                  "numoutlets": 13,
                  "patching_rect": [
                    20.0,
                    20.0,
                    850.0,
                    500.0
                  ],
                  "code": "// Acoustic reference calibration. It never learns latency from vocal grid errors.\n// in1/2: microphone; in3/4: selected digital instrumental; in5: host phase.\n// Data is instance-local and overwritten fully before it is read.\nParam requestseq(0);\nParam permit(0);\nParam cancelseq(0);\nParam cancelreason(0);\nParam guardreason(0);\nData micdata(14336);\nData refdata(14336);\nData scores(801);\nData bandinfo(40);\nHistory lastrequest(0);\nHistory lastcancel(0);\nHistory lastsr(0);\nHistory prevphase(0);\nHistory validrun(0);\nHistory clocklocked(0);\nHistory clockbad(0);\nHistory clockinc(0);\nHistory stage(0);\nHistory state(0);\nHistory clock(0);\nHistory ticks(0);\nHistory count(0);\nHistory msum(0);\nHistory rsum(0);\nHistory menv(0);\nHistory renv(0);\nHistory mlprev(0);\nHistory mrprev(0);\nHistory rlprev(0);\nHistory rrprev(0);\nHistory mlhp(0);\nHistory mrhp(0);\nHistory rlhp(0);\nHistory rrhp(0);\nHistory lagindex(0);\nHistory pos(0);\nHistory sx(0);\nHistory sy(0);\nHistory sxx(0);\nHistory syy(0);\nHistory sxy(0);\nHistory tx(0);\nHistory ty(0);\nHistory txx(0);\nHistory tyy(0);\nHistory txy(0);\nHistory best(-1);\nHistory bestlag(0);\nHistory besta(-1);\nHistory bestb(-1);\nHistory laga(0);\nHistory lagb(0);\nHistory runner(-1);\nHistory scan(0);\nHistory resultms(0);\nHistory quality(0);\nHistory rejection(0);\nHistory refviable(0);\nHistory micviable(0);\nHistory bandindex(0);\nHistory confirmationround(0);\nHistory anchorlag(0);\nHistory anchorband(0);\nHistory anchorquality(0);\nHistory diagnosticlag(0);\nHistory diagnostica(0);\nHistory diagnosticb(0);\nHistory diagnosticmargin(0);\nHistory diagnosticdiff(0);\nHistory confirmedbands(0);\nHistory bandspread(0);\nHistory b1mlprev(0);\nHistory b1mlhp1(0);\nHistory b1mlhp2(0);\nHistory b1mllp1(0);\nHistory b1mllp2(0);\nHistory b1mrprev(0);\nHistory b1mrhp1(0);\nHistory b1mrhp2(0);\nHistory b1mrlp1(0);\nHistory b1mrlp2(0);\nHistory b1rlprev(0);\nHistory b1rlhp1(0);\nHistory b1rlhp2(0);\nHistory b1rllp1(0);\nHistory b1rllp2(0);\nHistory b1rrprev(0);\nHistory b1rrhp1(0);\nHistory b1rrhp2(0);\nHistory b1rrlp1(0);\nHistory b1rrlp2(0);\nHistory b1menv(0);\nHistory b1renv(0);\nHistory b1msum(0);\nHistory b1rsum(0);\nHistory b2mlprev(0);\nHistory b2mlhp1(0);\nHistory b2mlhp2(0);\nHistory b2mllp1(0);\nHistory b2mllp2(0);\nHistory b2mrprev(0);\nHistory b2mrhp1(0);\nHistory b2mrhp2(0);\nHistory b2mrlp1(0);\nHistory b2mrlp2(0);\nHistory b2rlprev(0);\nHistory b2rlhp1(0);\nHistory b2rlhp2(0);\nHistory b2rllp1(0);\nHistory b2rllp2(0);\nHistory b2rrprev(0);\nHistory b2rrhp1(0);\nHistory b2rrhp2(0);\nHistory b2rrlp1(0);\nHistory b2rrlp2(0);\nHistory b2menv(0);\nHistory b2renv(0);\nHistory b2msum(0);\nHistory b2rsum(0);\nHistory b3mlprev(0);\nHistory b3mlhp1(0);\nHistory b3mlhp2(0);\nHistory b3mllp1(0);\nHistory b3mllp2(0);\nHistory b3mrprev(0);\nHistory b3mrhp1(0);\nHistory b3mrhp2(0);\nHistory b3mrlp1(0);\nHistory b3mrlp2(0);\nHistory b3rlprev(0);\nHistory b3rlhp1(0);\nHistory b3rlhp2(0);\nHistory b3rllp1(0);\nHistory b3rllp2(0);\nHistory b3rrprev(0);\nHistory b3rrhp1(0);\nHistory b3rrhp2(0);\nHistory b3rrlp1(0);\nHistory b3rrlp2(0);\nHistory b3menv(0);\nHistory b3renv(0);\nHistory b3msum(0);\nHistory b3rsum(0);\n\n\nphase = clamp(in5, 0, 1);\npd = phase - prevphase;\ninc = pd < -0.5 ? pd + 1 : pd;\nincok = (inc >= 19.8 / (60 * samplerate)) && (inc <= 404 / (60 * samplerate));\nnv = incok ? min(validrun + 1, samplerate) : 0;\n// Calibration timestamps use audio sample counts, not beat phase. Require\n// initial lock, but tolerate <2 ms of invalid phase increments after lock.\n// A large phase discontinuity still cancels immediately.\nnclockbad = incok ? 0 : min(clockbad + 1, samplerate);\nnclockinc = incok ? (clockinc > 0 ? clockinc + (inc - clockinc) / (samplerate * 0.1) : inc) : clockinc;\njumpthreshold = max(clockinc, 19.8 / (60 * samplerate)) * samplerate * 0.002;\nhardjump = (clocklocked > 0) && (abs(inc) > jumpthreshold);\nnclocklocked = (clocklocked > 0) || (nv >= samplerate * 0.010);\nif (hardjump || (nclockbad >= samplerate * 0.002)) { nclocklocked = 0; }\nsynced = nclocklocked > 0;\nns = stage;\nnst = state;\nnc = clock;\nnt = ticks;\nnn = count;\nnm = msum;\nnr = rsum;\nli = lagindex;\npp = pos;\nax = sx; ay = sy; axx = sxx; ayy = syy; axy = sxy;\nbx = tx; by = ty; bxx = txx; byy = tyy; bxy = txy;\nnbest = best; nlag = bestlag;\nna = besta; nb = bestb; nla = laga; nlb = lagb;\nnrunner = runner; nscan = scan;\nnresult = resultms;\nnquality = quality;\nnreject = rejection;\nnrefviable = refviable;\nnmicviable = micviable;\nnbi = bandindex;\nnround = confirmationround; nanchorlag = anchorlag; nanchorband = anchorband; nanchorquality = anchorquality;\nndlag = diagnosticlag; nda = diagnostica; ndb = diagnosticb;\nndmargin = diagnosticmargin; nddiff = diagnosticdiff;\nnconfirmed = confirmedbands; nspread = bandspread;\n\n// Matched 65 Hz high-pass and 4 ms energy envelopes on both reference paths.\nhp = exp(-6.28318530718 * 65 / samplerate);\nam = in1 - mlprev + hp * mlhp;\nbm = in2 - mrprev + hp * mrhp;\nar = in3 - rlprev + hp * rlhp;\nbr = in4 - rrprev + hp * rrhp;\ncoef = exp(-1 / (samplerate * 0.004));\nme = max(abs(am), abs(bm)) + coef * (menv - max(abs(am), abs(bm)));\nre = max(abs(ar), abs(br)) + coef * (renv - max(abs(ar), abs(br)));\n\n// Three matched, overlapping bands reduce dependence on broad spectral balance.\n// Each has cascaded first-order high-pass and low-pass stages on both paths.\nb1hp = exp(-6.28318530718 * 250 / samplerate);\nb1lp = exp(-6.28318530718 * 700 / samplerate);\nb1mlh1 = in1 - b1mlprev + b1hp * b1mlhp1;\nb1mlh2 = b1mlh1 - b1mlhp1 + b1hp * b1mlhp2;\nb1mll1 = (1 - b1lp) * b1mlh2 + b1lp * b1mllp1;\nb1mll2 = (1 - b1lp) * b1mll1 + b1lp * b1mllp2;\nb1mrh1 = in2 - b1mrprev + b1hp * b1mrhp1;\nb1mrh2 = b1mrh1 - b1mrhp1 + b1hp * b1mrhp2;\nb1mrl1 = (1 - b1lp) * b1mrh2 + b1lp * b1mrlp1;\nb1mrl2 = (1 - b1lp) * b1mrl1 + b1lp * b1mrlp2;\nb1rlh1 = in3 - b1rlprev + b1hp * b1rlhp1;\nb1rlh2 = b1rlh1 - b1rlhp1 + b1hp * b1rlhp2;\nb1rll1 = (1 - b1lp) * b1rlh2 + b1lp * b1rllp1;\nb1rll2 = (1 - b1lp) * b1rll1 + b1lp * b1rllp2;\nb1rrh1 = in4 - b1rrprev + b1hp * b1rrhp1;\nb1rrh2 = b1rrh1 - b1rrhp1 + b1hp * b1rrhp2;\nb1rrl1 = (1 - b1lp) * b1rrh2 + b1lp * b1rrlp1;\nb1rrl2 = (1 - b1lp) * b1rrl1 + b1lp * b1rrlp2;\nb1me = max(abs(b1mll2), abs(b1mrl2)) + coef * (b1menv - max(abs(b1mll2), abs(b1mrl2)));\nb1re = max(abs(b1rll2), abs(b1rrl2)) + coef * (b1renv - max(abs(b1rll2), abs(b1rrl2)));\nb1nm = b1msum; b1nr = b1rsum;\nb2hp = exp(-6.28318530718 * 700 / samplerate);\nb2lp = exp(-6.28318530718 * 2000 / samplerate);\nb2mlh1 = in1 - b2mlprev + b2hp * b2mlhp1;\nb2mlh2 = b2mlh1 - b2mlhp1 + b2hp * b2mlhp2;\nb2mll1 = (1 - b2lp) * b2mlh2 + b2lp * b2mllp1;\nb2mll2 = (1 - b2lp) * b2mll1 + b2lp * b2mllp2;\nb2mrh1 = in2 - b2mrprev + b2hp * b2mrhp1;\nb2mrh2 = b2mrh1 - b2mrhp1 + b2hp * b2mrhp2;\nb2mrl1 = (1 - b2lp) * b2mrh2 + b2lp * b2mrlp1;\nb2mrl2 = (1 - b2lp) * b2mrl1 + b2lp * b2mrlp2;\nb2rlh1 = in3 - b2rlprev + b2hp * b2rlhp1;\nb2rlh2 = b2rlh1 - b2rlhp1 + b2hp * b2rlhp2;\nb2rll1 = (1 - b2lp) * b2rlh2 + b2lp * b2rllp1;\nb2rll2 = (1 - b2lp) * b2rll1 + b2lp * b2rllp2;\nb2rrh1 = in4 - b2rrprev + b2hp * b2rrhp1;\nb2rrh2 = b2rrh1 - b2rrhp1 + b2hp * b2rrhp2;\nb2rrl1 = (1 - b2lp) * b2rrh2 + b2lp * b2rrlp1;\nb2rrl2 = (1 - b2lp) * b2rrl1 + b2lp * b2rrlp2;\nb2me = max(abs(b2mll2), abs(b2mrl2)) + coef * (b2menv - max(abs(b2mll2), abs(b2mrl2)));\nb2re = max(abs(b2rll2), abs(b2rrl2)) + coef * (b2renv - max(abs(b2rll2), abs(b2rrl2)));\nb2nm = b2msum; b2nr = b2rsum;\nb3hp = exp(-6.28318530718 * 2000 / samplerate);\nb3lp = exp(-6.28318530718 * 6000 / samplerate);\nb3mlh1 = in1 - b3mlprev + b3hp * b3mlhp1;\nb3mlh2 = b3mlh1 - b3mlhp1 + b3hp * b3mlhp2;\nb3mll1 = (1 - b3lp) * b3mlh2 + b3lp * b3mllp1;\nb3mll2 = (1 - b3lp) * b3mll1 + b3lp * b3mllp2;\nb3mrh1 = in2 - b3mrprev + b3hp * b3mrhp1;\nb3mrh2 = b3mrh1 - b3mrhp1 + b3hp * b3mrhp2;\nb3mrl1 = (1 - b3lp) * b3mrh2 + b3lp * b3mrlp1;\nb3mrl2 = (1 - b3lp) * b3mrl1 + b3lp * b3mrlp2;\nb3rlh1 = in3 - b3rlprev + b3hp * b3rlhp1;\nb3rlh2 = b3rlh1 - b3rlhp1 + b3hp * b3rlhp2;\nb3rll1 = (1 - b3lp) * b3rlh2 + b3lp * b3rllp1;\nb3rll2 = (1 - b3lp) * b3rll1 + b3lp * b3rllp2;\nb3rrh1 = in4 - b3rrprev + b3hp * b3rrhp1;\nb3rrh2 = b3rrh1 - b3rrhp1 + b3hp * b3rrhp2;\nb3rrl1 = (1 - b3lp) * b3rrh2 + b3lp * b3rrlp1;\nb3rrl2 = (1 - b3lp) * b3rrl1 + b3lp * b3rrlp2;\nb3me = max(abs(b3mll2), abs(b3mrl2)) + coef * (b3menv - max(abs(b3mll2), abs(b3mrl2)));\nb3re = max(abs(b3rll2), abs(b3rrl2)) + coef * (b3renv - max(abs(b3rll2), abs(b3rrl2)));\nb3nm = b3msum; b3nr = b3rsum;\n\nrequest = requestseq != lastrequest;\ncancel = (cancelseq != lastcancel) || ((lastsr > 0) && (samplerate != lastsr));\nif (request) {\n    ns = 0; nbi = 0; nconfirmed = 0; nspread = 0; nround = 0; nanchorlag = 0; nanchorband = 0; nanchorquality = 0;\n    nquality = 0; nreject = 0; nrefviable = 0; nmicviable = 0;\n    if ((permit > 0) && synced && !cancel) {\n        ns = 1; nst = 1;\n        nc = 0; nt = 0; nn = 0; nm = 0; nr = 0;\n        li = 0; pp = 0;\n        b1nm = 0; b1nr = 0;\n        b2nm = 0; b2nr = 0;\n        b3nm = 0; b3nr = 0;\n\n        ax = 0; ay = 0; axx = 0; ayy = 0; axy = 0;\n        bx = 0; by = 0; bxx = 0; byy = 0; bxy = 0;\n        nbest = -1; nlag = 0; na = -1; nb = -1; nla = 0; nlb = 0;\n        nrunner = -1; nscan = 0;\n    } else {\n        nst = 6;\n    }\n}\nif ((ns > 0) && ((permit <= 0) || !synced || cancel)) {\n    ns = 0; nst = 5; nquality = 0;\n    // Latch the failure cause in the terminal packet; later guard recovery or\n    // repeated polling must not erase the explanation.\n    nreject = 100 + cancelreason;\n    if ((permit <= 0) && ((cancelseq == lastcancel) || (cancelreason == 14))) { nreject = 200 + guardreason; }\n    if (!synced) { nreject = hardjump ? 303 : 302; }\n    if ((lastsr > 0) && (samplerate != lastsr)) { nreject = 301; }\n}\n\nif (ns == 1) {\n    // Average at a rational 1 kHz clock: valid at 44.1, 48 and 96 kHz.\n    nc = nc + 1000;\n    nt = nt + 1;\n    nm = nm + me;\n    nr = nr + re;\n    b1nm = b1nm + b1me; b1nr = b1nr + b1re;\n    b2nm = b2nm + b2me; b2nr = b2nr + b2re;\n    b3nm = b3nm + b3me; b3nr = b3nr + b3re;\n\n    if (nc >= samplerate) {\n        nc = nc - samplerate;\n        poke(micdata, nm / nt, nn);\n        poke(refdata, nr / nt, nn);\n        poke(micdata, b1nm / nt, 1 * 3584 + nn);\n        poke(refdata, b1nr / nt, 1 * 3584 + nn);\n        b1nm = 0; b1nr = 0;\n        poke(micdata, b2nm / nt, 2 * 3584 + nn);\n        poke(refdata, b2nr / nt, 2 * 3584 + nn);\n        b2nm = 0; b2nr = 0;\n        poke(micdata, b3nm / nt, 3 * 3584 + nn);\n        poke(refdata, b3nr / nt, 3 * 3584 + nn);\n        b3nm = 0; b3nr = 0;\n\n        nn = nn + 1; nt = 0; nm = 0; nr = 0;\n        if (nn >= 3584) {\n            ns = 2; nst = 2;\n        }\n    }\n} else if (ns == 2) {\n    // Bounded work: 64 multiply/accumulate iterations per audio sample.\n    // Independent 1024 ms windows must agree on the same delay.\n    for (q = 0; q < 64; q += 1) {\n        if (pp < 2048) {\n            idx = pp < 1024 ? 512 + pp : 2048 + pp - 1024;\n            x = peek(refdata, nbi * 3584 + idx);\n            y = peek(micdata, nbi * 3584 + idx + li - 400);\n            if (pp < 1024) {\n                ax = ax + x; ay = ay + y;\n                axx = axx + x*x; ayy = ayy + y*y; axy = axy + x*y;\n            } else {\n                bx = bx + x; by = by + y;\n                bxx = bxx + x*x; byy = byy + y*y; bxy = bxy + x*y;\n            }\n            pp = pp + 1;\n        }\n    }\n    if (pp >= 2048) {\n        vx = max(0, axx - ax*ax/1024);\n        vy = max(0, ayy - ay*ay/1024);\n        wx = max(0, bxx - bx*bx/1024);\n        wy = max(0, byy - by*by/1024);\n        nrefviable = max(nrefviable, (vx > 0.00000001) && (wx > 0.00000001));\n        nmicviable = max(nmicviable, (vy > 0.00000001) && (wy > 0.00000001));\n        ca = (vx > 0.00000001) && (vy > 0.00000001) ? (axy - ax*ay/1024) / sqrt(max(0.0000000000000001, vx*vy)) : -1;\n        cb = (wx > 0.00000001) && (wy > 0.00000001) ? (bxy - bx*by/1024) / sqrt(max(0.0000000000000001, wx*wy)) : -1;\n        score = min(ca, cb);\n        poke(scores, score, li);\n        if (score > nbest) { nbest = score; nlag = li; }\n        if (ca > na) { na = ca; nla = li; }\n        if (cb > nb) { nb = cb; nlb = li; }\n        li = li + 1;\n        pp = 0;\n        ax = 0; ay = 0; axx = 0; ayy = 0; axy = 0;\n        bx = 0; by = 0; bxx = 0; byy = 0; bxy = 0;\n        if (li >= 801) { ns = 3; }\n    }\n} else if (ns == 3) {\n    // A rhythmic / repeated pattern can have several plausible delays.\n    // Reject competing peaks rather than choosing a convenient grid alignment.\n    for (q = 0; q < 64; q += 1) {\n        if (nscan < 801) {\n            value = peek(scores, nscan);\n            if ((abs(nscan - nlag) > 20) && (value > nrunner)) { nrunner = value; }\n            nscan = nscan + 1;\n        }\n    }\n    if (nscan >= 801) {\n        nquality = max(0, min(1, nbest));\n        accepted = (nbest >= 0.85) && ((nbest - nrunner) >= 0.12) && (abs(nla - nlb) <= 3) && (nlag > 2) && (nlag < 798);\n        // Each band keeps the previous strict single-band acceptance checks.\n        nreject = !nrefviable ? 1 : (!nmicviable ? 2 : (nbest < 0.85 ? 3 : ((nbest - nrunner) < 0.12 ? 4 : (abs(nla - nlb) > 3 ? 5 : ((nlag <= 2) || (nlag >= 798) ? 6 : 0)))));\n        estimate = nlag - 400;\n        if (accepted) {\n            left = peek(scores, nlag - 1);\n            right = peek(scores, nlag + 1);\n            bend = left - 2 * nbest + right;\n            fraction = abs(bend) > 0.00000001 ? clamp(0.5 * (left - right) / bend, -0.5, 0.5) : 0;\n            estimate = estimate + fraction;\n        }\n        // Store per-band evidence before reusing the bounded correlation workspace.\n        poke(bandinfo, accepted, nbi * 10);\n        poke(bandinfo, estimate, nbi * 10 + 1);\n        poke(bandinfo, nbest, nbi * 10 + 2);\n        poke(bandinfo, nlag - 400, nbi * 10 + 3);\n        poke(bandinfo, na, nbi * 10 + 4);\n        poke(bandinfo, nb, nbi * 10 + 5);\n        poke(bandinfo, nbest - nrunner, nbi * 10 + 6);\n        poke(bandinfo, abs(nla - nlb), nbi * 10 + 7);\n        poke(bandinfo, nreject, nbi * 10 + 8);\n        nbi = nbi + 1;\n        if (nbi < 4) {\n            ns = 2; nst = 2;\n            li = 0; pp = 0;\n            nbest = -1; nlag = 0; na = -1; nb = -1; nla = 0; nlb = 0;\n            nrunner = -1; nscan = 0; nrefviable = 0; nmicviable = 0;\n        } else {\n            ns = 4;\n        }\n    }\n} else if (ns == 4) {\n    // Require at least two individually conclusive bands and agreement of ALL\n    // conclusive bands. Do not cherry-pick a cluster or accept a lone best lag.\n    nconfirmed = 0; minlag = 1000; maxlag = -1000;\n    bestquality = -2; bestvalidquality = -2; chosen = 0; chosenvalid = 0;\n    for (q = 0; q < 4; q += 1) {\n        pass = peek(bandinfo, q * 10);\n        candidatequality = peek(bandinfo, q * 10 + 2);\n        if (candidatequality > bestquality) { bestquality = candidatequality; chosen = q; }\n        if (pass > 0) {\n            nconfirmed = nconfirmed + 1;\n            candidate = peek(bandinfo, q * 10 + 1);\n            minlag = min(minlag, candidate); maxlag = max(maxlag, candidate);\n            if (candidatequality > bestvalidquality) { bestvalidquality = candidatequality; chosenvalid = q; }\n        }\n    }\n    if (nconfirmed > 0) { chosen = chosenvalid; }\n    nspread = nconfirmed > 1 ? maxlag - minlag : 0;\n    nquality = clamp(peek(bandinfo, chosen * 10 + 2), 0, 1);\n    ndlag = peek(bandinfo, chosen * 10 + 3);\n    nda = peek(bandinfo, chosen * 10 + 4); ndb = peek(bandinfo, chosen * 10 + 5);\n    ndmargin = peek(bandinfo, chosen * 10 + 6); nddiff = peek(bandinfo, chosen * 10 + 7);\n    nreject = peek(bandinfo, chosen * 10 + 8);\n    ns = 0;\n    if (nround > 0) {\n        // Independent new acquisition: the SAME band must qualify again.\n        // All conclusive second-capture paths and the first estimate must agree.\n        anchorpass = peek(bandinfo, nanchorband * 10);\n        anchorsecond = peek(bandinfo, nanchorband * 10 + 1);\n        totalspread = max(maxlag, nanchorlag) - min(minlag, nanchorlag);\n        if ((anchorpass > 0) && (nconfirmed > 0) && (totalspread <= 3)) {\n            nresult = 0.5 * (nanchorlag + anchorsecond);\n            nquality = min(nanchorquality, clamp(peek(bandinfo, nanchorband * 10 + 2), 0, 1));\n            nst = 3; nreject = 0; nspread = totalspread;\n        } else {\n            nst = 4;\n            nreject = 9;\n            if ((nconfirmed >= 2) && (nspread > 3)) { nreject = 8; }\n            if ((anchorpass > 0) && (abs(anchorsecond - nanchorlag) > 3)) { nreject = 10; nspread = totalspread; }\n        }\n    } else if ((nconfirmed >= 2) && (nspread <= 3)) {\n        nresult = peek(bandinfo, chosen * 10 + 1); nst = 3; nreject = 0;\n    } else if (nconfirmed == 1) {\n        // A lone band is provisional, never an immediate compensation.\n        // Reuse the fixed buffers only after a completely new 3.584 s capture.\n        nround = 1; nanchorband = chosen;\n        nanchorlag = peek(bandinfo, chosen * 10 + 1);\n        nanchorquality = peek(bandinfo, chosen * 10 + 2);\n        ns = 1; nst = 7; nquality = 0; nreject = 0; nbi = 0;\n        nc = 0; nt = 0; nn = 0; nm = 0; nr = 0;\n        b1nm = 0; b1nr = 0; b2nm = 0; b2nr = 0; b3nm = 0; b3nr = 0;\n        li = 0; pp = 0;\n        ax = 0; ay = 0; axx = 0; ayy = 0; axy = 0;\n        bx = 0; by = 0; bxx = 0; byy = 0; bxy = 0;\n        nbest = -1; nlag = 0; na = -1; nb = -1; nla = 0; nlb = 0;\n        nrunner = -1; nscan = 0; nrefviable = 0; nmicviable = 0;\n    } else {\n        nst = 4;\n        if (nconfirmed >= 2) { nreject = 8; }\n    }\n}\n\nout1 = nst;\nout2 = nresult;\nout3 = nquality;\nout4 = ns > 0;\nout5 = requestseq;\n// Read-only diagnostics; candidate is never an accepted compensation.\nout6 = nreject;\nout7 = ndlag;\nout8 = nda;\nout9 = ndb;\nout10 = ndmargin;\nout11 = nddiff;\nout12 = nconfirmed;\nout13 = nspread;\n\nlastrequest = requestseq; lastcancel = cancelseq; lastsr = samplerate;\nprevphase = phase; validrun = nv;\nclocklocked = nclocklocked; clockbad = nclockbad; clockinc = nclockinc;\nstage = ns; state = nst;\nclock = nc; ticks = nt; count = nn; msum = nm; rsum = nr;\nmenv = me; renv = re;\nmlprev = in1; mrprev = in2; rlprev = in3; rrprev = in4;\nmlhp = am; mrhp = bm; rlhp = ar; rrhp = br;\nlagindex = li; pos = pp;\nsx = ax; sy = ay; sxx = axx; syy = ayy; sxy = axy;\ntx = bx; ty = by; txx = bxx; tyy = byy; txy = bxy;\nbest = nbest; bestlag = nlag; besta = na; bestb = nb; laga = nla; lagb = nlb;\nrunner = nrunner; scan = nscan; resultms = nresult; quality = nquality;\n\nrejection = nreject; refviable = nrefviable; micviable = nmicviable;\n\nbandindex = nbi;\nconfirmationround = nround; anchorlag = nanchorlag; anchorband = nanchorband; anchorquality = nanchorquality;\ndiagnosticlag = ndlag; diagnostica = nda; diagnosticb = ndb;\ndiagnosticmargin = ndmargin; diagnosticdiff = nddiff;\nconfirmedbands = nconfirmed; bandspread = nspread;\nb1mlprev = in1; b1mlhp1 = b1mlh1; b1mlhp2 = b1mlh2; b1mllp1 = b1mll1; b1mllp2 = b1mll2;\nb1mrprev = in2; b1mrhp1 = b1mrh1; b1mrhp2 = b1mrh2; b1mrlp1 = b1mrl1; b1mrlp2 = b1mrl2;\nb1rlprev = in3; b1rlhp1 = b1rlh1; b1rlhp2 = b1rlh2; b1rllp1 = b1rll1; b1rllp2 = b1rll2;\nb1rrprev = in4; b1rrhp1 = b1rrh1; b1rrhp2 = b1rrh2; b1rrlp1 = b1rrl1; b1rrlp2 = b1rrl2;\nb1menv = b1me; b1renv = b1re; b1msum = b1nm; b1rsum = b1nr;\nb2mlprev = in1; b2mlhp1 = b2mlh1; b2mlhp2 = b2mlh2; b2mllp1 = b2mll1; b2mllp2 = b2mll2;\nb2mrprev = in2; b2mrhp1 = b2mrh1; b2mrhp2 = b2mrh2; b2mrlp1 = b2mrl1; b2mrlp2 = b2mrl2;\nb2rlprev = in3; b2rlhp1 = b2rlh1; b2rlhp2 = b2rlh2; b2rllp1 = b2rll1; b2rllp2 = b2rll2;\nb2rrprev = in4; b2rrhp1 = b2rrh1; b2rrhp2 = b2rrh2; b2rrlp1 = b2rrl1; b2rrlp2 = b2rrl2;\nb2menv = b2me; b2renv = b2re; b2msum = b2nm; b2rsum = b2nr;\nb3mlprev = in1; b3mlhp1 = b3mlh1; b3mlhp2 = b3mlh2; b3mllp1 = b3mll1; b3mllp2 = b3mll2;\nb3mrprev = in2; b3mrhp1 = b3mrh1; b3mrhp2 = b3mrh2; b3mrlp1 = b3mrl1; b3mrlp2 = b3mrl2;\nb3rlprev = in3; b3rlhp1 = b3rlh1; b3rlhp2 = b3rlh2; b3rllp1 = b3rll1; b3rllp2 = b3rll2;\nb3rrprev = in4; b3rrhp1 = b3rrh1; b3rrhp2 = b3rrh2; b3rrlp1 = b3rrl1; b3rrlp2 = b3rrl2;\nb3menv = b3me; b3renv = b3re; b3msum = b3nm; b3rsum = b3nr;\n"
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
                  "id": "in4",
                  "maxclass": "newobj",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "patching_rect": [
                    620.0,
                    460.0,
                    185.0,
                    22.0
                  ],
                  "text": "in 4"
                }
              },
              {
                "box": {
                  "id": "in5",
                  "maxclass": "newobj",
                  "numinlets": 0,
                  "numoutlets": 1,
                  "patching_rect": [
                    820.0,
                    460.0,
                    185.0,
                    22.0
                  ],
                  "text": "in 5"
                }
              },
              {
                "box": {
                  "id": "out1",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    1020.0,
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
                    20.0,
                    505.0,
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
                    220.0,
                    505.0,
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
                    420.0,
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
                    620.0,
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
                    820.0,
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
                    1020.0,
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
                    20.0,
                    550.0,
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
                    220.0,
                    550.0,
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
                    420.0,
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
                    620.0,
                    550.0,
                    185.0,
                    22.0
                  ],
                  "text": "out 11"
                }
              },
              {
                "box": {
                  "id": "out12",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    820.0,
                    550.0,
                    185.0,
                    22.0
                  ],
                  "text": "out 12"
                }
              },
              {
                "box": {
                  "id": "out13",
                  "maxclass": "newobj",
                  "numinlets": 1,
                  "numoutlets": 0,
                  "patching_rect": [
                    1020.0,
                    550.0,
                    185.0,
                    22.0
                  ],
                  "text": "out 13"
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
                    "in4",
                    0
                  ],
                  "destination": [
                    "code",
                    3
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "in5",
                    0
                  ],
                  "destination": [
                    "code",
                    4
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
              },
              {
                "patchline": {
                  "source": [
                    "code",
                    11
                  ],
                  "destination": [
                    "out12",
                    0
                  ]
                }
              },
              {
                "patchline": {
                  "source": [
                    "code",
                    12
                  ],
                  "destination": [
                    "out13",
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
            "signal",
            "signal",
            "signal"
          ],
          "text": "gen~"
        }
      },
      {
        "box": {
          "id": "lat-permit-pak",
          "maxclass": "newobj",
          "numinlets": 9,
          "numoutlets": 1,
          "patching_rect": [
            1020.0,
            1765.0,
            185.0,
            22.0
          ],
          "text": "pak 1 0 0 0 1 0 -1 -1 -1"
        }
      },
      {
        "box": {
          "id": "lat-permit-unpack",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 9,
          "patching_rect": [
            20.0,
            1810.0,
            185.0,
            22.0
          ],
          "text": "unpack 0 0 0 0 0 0 0 0 0"
        }
      },
      {
        "box": {
          "id": "lat-permit-expr",
          "maxclass": "newobj",
          "numinlets": 9,
          "numoutlets": 1,
          "patching_rect": [
            220.0,
            1810.0,
            185.0,
            22.0
          ],
          "text": "expr ($i1 > 0) && ($i2 == 0) && ($i3 > 0) && ($i4 > 0) && ($i5 > 0) && ($i6 > 0) && ($i7 == 0) && ($i8 == 0) && ($i9 == 0)"
        }
      },
      {
        "box": {
          "id": "lat-reason-expr",
          "maxclass": "newobj",
          "numinlets": 9,
          "numoutlets": 1,
          "patching_rect": [
            420.0,
            1810.0,
            185.0,
            22.0
          ],
          "text": "expr ($i1 <= 0) * 1 + (!($i1 <= 0)) * (($i2 != 0) * 2 + (!($i2 != 0)) * (($i3 < 0) * 13 + (!($i3 < 0)) * (($i3 == 0) * 3 + (!($i3 == 0)) * (($i4 <= 0) * 4 + (!($i4 <= 0)) * (($i5 <= 0) * 5 + (!($i5 <= 0)) * (($i6 <= 0) * 6 + (!($i6 <= 0)) * (($i7 < 0) * 7 + (!($i7 < 0)) * (($i7 > 0) * 8 + (!($i7 > 0)) * (($i8 < 0) * 9 + (!($i8 < 0)) * (($i8 > 0) * 10 + (!($i8 > 0)) * (($i9 < 0) * 11 + (!($i9 < 0)) * (($i9 > 0) * 12 + (!($i9 > 0)) * (0)))))))))))))"
        }
      },
      {
        "box": {
          "id": "lat-reason-tag",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            620.0,
            1810.0,
            185.0,
            22.0
          ],
          "text": "prepend latencyreason"
        }
      },
      {
        "box": {
          "id": "lat-guard-reason-tag",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            820.0,
            1810.0,
            185.0,
            22.0
          ],
          "text": "prepend guardreason"
        }
      },
      {
        "box": {
          "id": "lat-permit",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 3,
          "patching_rect": [
            1020.0,
            1810.0,
            185.0,
            22.0
          ],
          "text": "change -1"
        }
      },
      {
        "box": {
          "id": "lat-permit-tag",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            20.0,
            1855.0,
            185.0,
            22.0
          ],
          "text": "prepend permit"
        }
      },
      {
        "box": {
          "id": "lat-unknown",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            220.0,
            1855.0,
            185.0,
            22.0
          ],
          "text": "-1"
        }
      },
      {
        "box": {
          "id": "lat-observe-0",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [
            420.0,
            1855.0,
            185.0,
            22.0
          ],
          "text": "live.observer record_mode"
        }
      },
      {
        "box": {
          "id": "lat-observe-1",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [
            620.0,
            1855.0,
            185.0,
            22.0
          ],
          "text": "live.observer session_record"
        }
      },
      {
        "box": {
          "id": "lat-observe-2",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [
            820.0,
            1855.0,
            185.0,
            22.0
          ],
          "text": "live.observer session_record_status"
        }
      },
      {
        "box": {
          "id": "lat-observe-3",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [
            1020.0,
            1855.0,
            185.0,
            22.0
          ],
          "text": "live.observer is_playing"
        }
      },
      {
        "box": {
          "id": "lat-api-bound",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            20.0,
            1900.0,
            185.0,
            22.0
          ],
          "text": "sel 1"
        }
      },
      {
        "box": {
          "id": "lat-requery-defer",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            220.0,
            1900.0,
            185.0,
            22.0
          ],
          "text": "deferlow"
        }
      },
      {
        "box": {
          "id": "lat-requery-gate",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            420.0,
            1900.0,
            185.0,
            22.0
          ],
          "text": "gate 1 0"
        }
      },
      {
        "box": {
          "id": "lat-requery-trigger",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 4,
          "patching_rect": [
            620.0,
            1900.0,
            185.0,
            22.0
          ],
          "text": "t b b b b"
        }
      },
      {
        "box": {
          "id": "lat-property-0",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            820.0,
            1900.0,
            185.0,
            22.0
          ],
          "text": "property record_mode"
        }
      },
      {
        "box": {
          "id": "lat-property-1",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            1020.0,
            1900.0,
            185.0,
            22.0
          ],
          "text": "property session_record"
        }
      },
      {
        "box": {
          "id": "lat-property-2",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            20.0,
            1945.0,
            185.0,
            22.0
          ],
          "text": "property session_record_status"
        }
      },
      {
        "box": {
          "id": "lat-property-3",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            220.0,
            1945.0,
            185.0,
            22.0
          ],
          "text": "property is_playing"
        }
      },
      {
        "box": {
          "id": "lat-request-counter",
          "maxclass": "newobj",
          "numinlets": 5,
          "numoutlets": 4,
          "patching_rect": [
            420.0,
            1945.0,
            185.0,
            22.0
          ],
          "text": "counter 1 1000000000"
        }
      },
      {
        "box": {
          "id": "lat-request-trigger",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            620.0,
            1945.0,
            185.0,
            22.0
          ],
          "text": "t i i b"
        }
      },
      {
        "box": {
          "id": "lat-pending-on",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            820.0,
            1945.0,
            185.0,
            22.0
          ],
          "text": "1"
        }
      },
      {
        "box": {
          "id": "lat-request-tag",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            1020.0,
            1945.0,
            185.0,
            22.0
          ],
          "text": "prepend requestseq"
        }
      },
      {
        "box": {
          "id": "lat-cancel-counter",
          "maxclass": "newobj",
          "numinlets": 5,
          "numoutlets": 4,
          "patching_rect": [
            20.0,
            1990.0,
            185.0,
            22.0
          ],
          "text": "counter 1 1000000000"
        }
      },
      {
        "box": {
          "id": "lat-cancel-tag",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            220.0,
            1990.0,
            185.0,
            22.0
          ],
          "text": "prepend cancelseq"
        }
      },
      {
        "box": {
          "id": "lat-cancel-bang",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            420.0,
            1990.0,
            185.0,
            22.0
          ],
          "text": "t b i"
        }
      },
      {
        "box": {
          "id": "lat-cancel-reason-tag",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            620.0,
            1990.0,
            185.0,
            22.0
          ],
          "text": "prepend cancelreason"
        }
      },
      {
        "box": {
          "id": "lat-cancel-filter-1",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 3,
          "patching_rect": [
            820.0,
            1990.0,
            185.0,
            22.0
          ],
          "text": "change -999999."
        }
      },
      {
        "box": {
          "id": "lat-cancel-code-1",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            1020.0,
            1990.0,
            185.0,
            22.0
          ],
          "text": "1"
        }
      },
      {
        "box": {
          "id": "lat-cancel-filter-2",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 3,
          "patching_rect": [
            20.0,
            2035.0,
            185.0,
            22.0
          ],
          "text": "change -999999."
        }
      },
      {
        "box": {
          "id": "lat-cancel-code-2",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            220.0,
            2035.0,
            185.0,
            22.0
          ],
          "text": "2"
        }
      },
      {
        "box": {
          "id": "lat-cancel-filter-3",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 3,
          "patching_rect": [
            420.0,
            2035.0,
            185.0,
            22.0
          ],
          "text": "change -999999."
        }
      },
      {
        "box": {
          "id": "lat-cancel-code-3",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            620.0,
            2035.0,
            185.0,
            22.0
          ],
          "text": "3"
        }
      },
      {
        "box": {
          "id": "lat-cancel-filter-4",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 3,
          "patching_rect": [
            820.0,
            2035.0,
            185.0,
            22.0
          ],
          "text": "change -999999."
        }
      },
      {
        "box": {
          "id": "lat-cancel-code-4",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            1020.0,
            2035.0,
            185.0,
            22.0
          ],
          "text": "4"
        }
      },
      {
        "box": {
          "id": "lat-cancel-filter-5",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 3,
          "patching_rect": [
            20.0,
            2080.0,
            185.0,
            22.0
          ],
          "text": "change -999999."
        }
      },
      {
        "box": {
          "id": "lat-cancel-code-5",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            220.0,
            2080.0,
            185.0,
            22.0
          ],
          "text": "5"
        }
      },
      {
        "box": {
          "id": "lat-cancel-filter-6",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 3,
          "patching_rect": [
            420.0,
            2080.0,
            185.0,
            22.0
          ],
          "text": "change -999999."
        }
      },
      {
        "box": {
          "id": "lat-cancel-code-6",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            620.0,
            2080.0,
            185.0,
            22.0
          ],
          "text": "6"
        }
      },
      {
        "box": {
          "id": "lat-cancel-code-7",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            820.0,
            2080.0,
            185.0,
            22.0
          ],
          "text": "7"
        }
      },
      {
        "box": {
          "id": "lat-cancel-filter-8",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [
            1020.0,
            2080.0,
            185.0,
            22.0
          ],
          "text": "zl change"
        }
      },
      {
        "box": {
          "id": "lat-cancel-code-8",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            20.0,
            2125.0,
            185.0,
            22.0
          ],
          "text": "8"
        }
      },
      {
        "box": {
          "id": "lat-cancel-filter-9",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [
            220.0,
            2125.0,
            185.0,
            22.0
          ],
          "text": "zl change"
        }
      },
      {
        "box": {
          "id": "lat-cancel-code-9",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            420.0,
            2125.0,
            185.0,
            22.0
          ],
          "text": "9"
        }
      },
      {
        "box": {
          "id": "lat-cancel-code-10",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            620.0,
            2125.0,
            185.0,
            22.0
          ],
          "text": "10"
        }
      },
      {
        "box": {
          "id": "lat-cancel-filter-11",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [
            820.0,
            2125.0,
            185.0,
            22.0
          ],
          "text": "zl change"
        }
      },
      {
        "box": {
          "id": "lat-cancel-code-11",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            1020.0,
            2125.0,
            185.0,
            22.0
          ],
          "text": "11"
        }
      },
      {
        "box": {
          "id": "lat-cancel-filter-12",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [
            20.0,
            2170.0,
            185.0,
            22.0
          ],
          "text": "zl change"
        }
      },
      {
        "box": {
          "id": "lat-cancel-code-12",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            220.0,
            2170.0,
            185.0,
            22.0
          ],
          "text": "12"
        }
      },
      {
        "box": {
          "id": "lat-cancel-code-13",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            420.0,
            2170.0,
            185.0,
            22.0
          ],
          "text": "13"
        }
      },
      {
        "box": {
          "id": "lat-disallowed",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            620.0,
            2170.0,
            185.0,
            22.0
          ],
          "text": "sel 0"
        }
      },
      {
        "box": {
          "id": "lat-cancel-code-14",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            820.0,
            2170.0,
            185.0,
            22.0
          ],
          "text": "14"
        }
      },
      {
        "box": {
          "id": "lat-dsp-change-0",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 3,
          "patching_rect": [
            1020.0,
            2170.0,
            185.0,
            22.0
          ],
          "text": "change -1"
        }
      },
      {
        "box": {
          "id": "lat-cancel-code-15",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            20.0,
            2215.0,
            185.0,
            22.0
          ],
          "text": "15"
        }
      },
      {
        "box": {
          "id": "lat-dsp-change-1",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 3,
          "patching_rect": [
            220.0,
            2215.0,
            185.0,
            22.0
          ],
          "text": "change -1"
        }
      },
      {
        "box": {
          "id": "lat-cancel-code-16",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            420.0,
            2215.0,
            185.0,
            22.0
          ],
          "text": "16"
        }
      },
      {
        "box": {
          "id": "lat-dsp-change-2",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 3,
          "patching_rect": [
            620.0,
            2215.0,
            185.0,
            22.0
          ],
          "text": "change -1"
        }
      },
      {
        "box": {
          "id": "lat-cancel-code-17",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            820.0,
            2215.0,
            185.0,
            22.0
          ],
          "text": "17"
        }
      },
      {
        "box": {
          "id": "lat-dsp-change-3",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 3,
          "patching_rect": [
            1020.0,
            2215.0,
            185.0,
            22.0
          ],
          "text": "change -1"
        }
      },
      {
        "box": {
          "id": "lat-cancel-code-18",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            20.0,
            2260.0,
            185.0,
            22.0
          ],
          "text": "18"
        }
      },
      {
        "box": {
          "id": "lat-poll",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 12,
          "patching_rect": [
            220.0,
            2260.0,
            185.0,
            22.0
          ],
          "text": "t b b b b b b b b b b b b"
        }
      },
      {
        "box": {
          "id": "lat-snapshot-0",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            420.0,
            2260.0,
            185.0,
            22.0
          ],
          "text": "snapshot~"
        }
      },
      {
        "box": {
          "id": "lat-snapshot-5",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            620.0,
            2260.0,
            185.0,
            22.0
          ],
          "text": "snapshot~"
        }
      },
      {
        "box": {
          "id": "lat-snapshot-4",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            820.0,
            2260.0,
            185.0,
            22.0
          ],
          "text": "snapshot~"
        }
      },
      {
        "box": {
          "id": "lat-snapshot-2",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            1020.0,
            2260.0,
            185.0,
            22.0
          ],
          "text": "snapshot~"
        }
      },
      {
        "box": {
          "id": "lat-snapshot-1",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            20.0,
            2305.0,
            185.0,
            22.0
          ],
          "text": "snapshot~"
        }
      },
      {
        "box": {
          "id": "lat-snapshot-6",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            220.0,
            2305.0,
            185.0,
            22.0
          ],
          "text": "snapshot~"
        }
      },
      {
        "box": {
          "id": "lat-snapshot-7",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            420.0,
            2305.0,
            185.0,
            22.0
          ],
          "text": "snapshot~"
        }
      },
      {
        "box": {
          "id": "lat-snapshot-8",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            620.0,
            2305.0,
            185.0,
            22.0
          ],
          "text": "snapshot~"
        }
      },
      {
        "box": {
          "id": "lat-snapshot-9",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            820.0,
            2305.0,
            185.0,
            22.0
          ],
          "text": "snapshot~"
        }
      },
      {
        "box": {
          "id": "lat-snapshot-10",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            1020.0,
            2305.0,
            185.0,
            22.0
          ],
          "text": "snapshot~"
        }
      },
      {
        "box": {
          "id": "lat-snapshot-11",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            20.0,
            2350.0,
            185.0,
            22.0
          ],
          "text": "snapshot~"
        }
      },
      {
        "box": {
          "id": "lat-snapshot-12",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            220.0,
            2350.0,
            185.0,
            22.0
          ],
          "text": "snapshot~"
        }
      },
      {
        "box": {
          "id": "lat-diagnostic-pack",
          "maxclass": "newobj",
          "numinlets": 9,
          "numoutlets": 1,
          "patching_rect": [
            420.0,
            2350.0,
            185.0,
            22.0
          ],
          "text": "pack 0 0. 0. 0. 0. 0. 0. 0. 0."
        }
      },
      {
        "box": {
          "id": "lat-cancel-ui-tag",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            620.0,
            2350.0,
            185.0,
            22.0
          ],
          "text": "prepend latencycancelreason"
        }
      },
      {
        "box": {
          "id": "lat-diagnostic-tag",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            820.0,
            2350.0,
            185.0,
            22.0
          ],
          "text": "prepend latencydiagnostics"
        }
      },
      {
        "box": {
          "id": "lat-result-store",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            1020.0,
            2350.0,
            185.0,
            22.0
          ],
          "text": "f 0."
        }
      },
      {
        "box": {
          "id": "lat-status-int",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            20.0,
            2395.0,
            185.0,
            22.0
          ],
          "text": "i"
        }
      },
      {
        "box": {
          "id": "lat-status-change",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 3,
          "patching_rect": [
            220.0,
            2395.0,
            185.0,
            22.0
          ],
          "text": "change -1"
        }
      },
      {
        "box": {
          "id": "lat-status-token-pak",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            420.0,
            2395.0,
            185.0,
            22.0
          ],
          "text": "pak 0 0"
        }
      },
      {
        "box": {
          "id": "lat-status-token-unpack",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            620.0,
            2395.0,
            185.0,
            22.0
          ],
          "text": "unpack 0 0"
        }
      },
      {
        "box": {
          "id": "lat-status-token-expr",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            820.0,
            2395.0,
            185.0,
            22.0
          ],
          "text": "expr $i1 == $i2"
        }
      },
      {
        "box": {
          "id": "lat-status-token-gate",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            1020.0,
            2395.0,
            185.0,
            22.0
          ],
          "text": "gate 1 1"
        }
      },
      {
        "box": {
          "id": "lat-status-reset",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            20.0,
            2440.0,
            185.0,
            22.0
          ],
          "text": "set -1"
        }
      },
      {
        "box": {
          "id": "lat-status-tag",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            220.0,
            2440.0,
            185.0,
            22.0
          ],
          "text": "prepend latencystatus"
        }
      },
      {
        "box": {
          "id": "lat-success",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            420.0,
            2440.0,
            185.0,
            22.0
          ],
          "text": "sel 3"
        }
      },
      {
        "box": {
          "id": "lat-accept-defer",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            620.0,
            2440.0,
            185.0,
            22.0
          ],
          "text": "deferlow"
        }
      },
      {
        "box": {
          "id": "lat-accept-pak",
          "maxclass": "newobj",
          "numinlets": 6,
          "numoutlets": 1,
          "patching_rect": [
            820.0,
            2440.0,
            185.0,
            22.0
          ],
          "text": "pak 0 0 0 0 0. 0."
        }
      },
      {
        "box": {
          "id": "lat-accept-unpack",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 6,
          "patching_rect": [
            1020.0,
            2440.0,
            185.0,
            22.0
          ],
          "text": "unpack 0 0 0 0 0. 0."
        }
      },
      {
        "box": {
          "id": "lat-commit-reason-expr",
          "maxclass": "newobj",
          "numinlets": 6,
          "numoutlets": 1,
          "patching_rect": [
            20.0,
            2485.0,
            185.0,
            22.0
          ],
          "text": "expr ($i1 <= 0) * 401 + (!($i1 <= 0)) * (($i2 <= 0) * 402 + (!($i2 <= 0)) * ((($i3 != $i4) || ($i4 <= 0)) * 403 + (!(($i3 != $i4) || ($i4 <= 0))) * (($f5 < 0.85) * 404 + (!($f5 < 0.85)) * ((($f6 <= -398.) || ($f6 >= 398.)) * 405 + (!(($f6 <= -398.) || ($f6 >= 398.))) * (400)))))"
        }
      },
      {
        "box": {
          "id": "lat-commit-reason-store",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            220.0,
            2485.0,
            185.0,
            22.0
          ],
          "text": "i 400"
        }
      },
      {
        "box": {
          "id": "lat-accept-expr",
          "maxclass": "newobj",
          "numinlets": 6,
          "numoutlets": 1,
          "patching_rect": [
            420.0,
            2485.0,
            185.0,
            22.0
          ],
          "text": "expr ($i1 > 0) && ($i2 > 0) && ($i3 == $i4) && ($i4 > 0) && ($f5 >= 0.85) && ($f6 > -398.) && ($f6 < 398.)"
        }
      },
      {
        "box": {
          "id": "lat-accept-gate",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            620.0,
            2485.0,
            185.0,
            22.0
          ],
          "text": "gate 1 0"
        }
      },
      {
        "box": {
          "id": "lat-commit-check",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            820.0,
            2485.0,
            185.0,
            22.0
          ],
          "text": "i 0"
        }
      },
      {
        "box": {
          "id": "lat-commit-select",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            1020.0,
            2485.0,
            185.0,
            22.0
          ],
          "text": "sel 0 1"
        }
      },
      {
        "box": {
          "id": "lat-commit-failure",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            20.0,
            2530.0,
            185.0,
            22.0
          ],
          "text": "t b b"
        }
      },
      {
        "box": {
          "id": "lat-commit-rejected",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            220.0,
            2530.0,
            185.0,
            22.0
          ],
          "text": "5"
        }
      },
      {
        "box": {
          "id": "lat-accept-once",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            420.0,
            2530.0,
            185.0,
            22.0
          ],
          "text": "t b b b"
        }
      },
      {
        "box": {
          "id": "lat-pending-off",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            620.0,
            2530.0,
            185.0,
            22.0
          ],
          "text": "0"
        }
      },
      {
        "box": {
          "id": "lat-terminal",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 4,
          "patching_rect": [
            820.0,
            2530.0,
            185.0,
            22.0
          ],
          "text": "sel 4 5 6"
        }
      },
      {
        "box": {
          "id": "lat-commit-applied",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            1020.0,
            2530.0,
            185.0,
            22.0
          ],
          "text": "3"
        }
      },
      {
        "box": {
          "id": "lat-offset-tag",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            20.0,
            2575.0,
            185.0,
            22.0
          ],
          "text": "prepend latencyoffset"
        }
      },
      {
        "box": {
          "id": "as-state",
          "maxclass": "newobj",
          "numinlets": 4,
          "numoutlets": 1,
          "patching_rect": [
            220.0,
            2575.0,
            185.0,
            22.0
          ],
          "text": "pak 0 -1 0 0"
        }
      },
      {
        "box": {
          "id": "as-unpack",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 4,
          "patching_rect": [
            420.0,
            2575.0,
            185.0,
            22.0
          ],
          "text": "unpack 0 0 0 0"
        }
      },
      {
        "box": {
          "id": "as-ready",
          "maxclass": "newobj",
          "numinlets": 4,
          "numoutlets": 1,
          "patching_rect": [
            620.0,
            2575.0,
            185.0,
            22.0
          ],
          "text": "expr ($i1 > 0) && ($i2 > 0) && ($i3 == 0) && ($i4 > 0)"
        }
      },
      {
        "box": {
          "id": "as-effective-change",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 3,
          "patching_rect": [
            820.0,
            2575.0,
            185.0,
            22.0
          ],
          "text": "change -1"
        }
      },
      {
        "box": {
          "id": "as-request-gate",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            1020.0,
            2575.0,
            185.0,
            22.0
          ],
          "text": "gate 1 0"
        }
      },
      {
        "box": {
          "id": "as-note-gate",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            20.0,
            2620.0,
            185.0,
            22.0
          ],
          "text": "gate 1 0"
        }
      },
      {
        "box": {
          "id": "as-spent",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            220.0,
            2620.0,
            185.0,
            22.0
          ],
          "text": "1"
        }
      },
      {
        "box": {
          "id": "as-unspent",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            420.0,
            2620.0,
            185.0,
            22.0
          ],
          "text": "0"
        }
      },
      {
        "box": {
          "id": "as-low-clear",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            620.0,
            2620.0,
            185.0,
            22.0
          ],
          "text": "0"
        }
      },
      {
        "box": {
          "id": "as-low-seen",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            820.0,
            2620.0,
            185.0,
            22.0
          ],
          "text": "1"
        }
      },
      {
        "box": {
          "id": "as-low-select",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            1020.0,
            2620.0,
            185.0,
            22.0
          ],
          "text": "sel 0"
        }
      },
      {
        "box": {
          "id": "as-invalidate",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            20.0,
            2665.0,
            185.0,
            22.0
          ],
          "text": "t b b"
        }
      },
      {
        "box": {
          "id": "as-generation",
          "maxclass": "newobj",
          "numinlets": 5,
          "numoutlets": 4,
          "patching_rect": [
            220.0,
            2665.0,
            185.0,
            22.0
          ],
          "text": "counter 1 1000000000"
        }
      },
      {
        "box": {
          "id": "as-generation-store",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            420.0,
            2665.0,
            185.0,
            22.0
          ],
          "text": "i 0"
        }
      },
      {
        "box": {
          "id": "as-commit",
          "maxclass": "newobj",
          "numinlets": 4,
          "numoutlets": 1,
          "patching_rect": [
            620.0,
            2665.0,
            185.0,
            22.0
          ],
          "text": "expr ($i1 == $i2) && ($i3 > 0) && ($i4 > 0)"
        }
      },
      {
        "box": {
          "id": "as-commit-select",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            820.0,
            2665.0,
            185.0,
            22.0
          ],
          "text": "sel 1"
        }
      },
      {
        "box": {
          "id": "as-request",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            1020.0,
            2665.0,
            185.0,
            22.0
          ],
          "text": "t b b"
        }
      },
      {
        "box": {
          "id": "as-play-observer",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [
            20.0,
            2710.0,
            185.0,
            22.0
          ],
          "text": "live.observer is_playing"
        }
      },
      {
        "box": {
          "id": "as-api-select",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            220.0,
            2710.0,
            185.0,
            22.0
          ],
          "text": "sel 0 1"
        }
      },
      {
        "box": {
          "id": "as-play-unknown",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            420.0,
            2710.0,
            185.0,
            22.0
          ],
          "text": "-1"
        }
      },
      {
        "box": {
          "id": "as-play-query",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            620.0,
            2710.0,
            185.0,
            22.0
          ],
          "text": "property is_playing"
        }
      },
      {
        "box": {
          "id": "as-play-change",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 3,
          "patching_rect": [
            820.0,
            2710.0,
            185.0,
            22.0
          ],
          "text": "change -2"
        }
      },
      {
        "box": {
          "id": "as-play-update",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            1020.0,
            2710.0,
            185.0,
            22.0
          ],
          "text": "t i b"
        }
      },
      {
        "box": {
          "id": "as-play-select",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            20.0,
            2755.0,
            185.0,
            22.0
          ],
          "text": "sel 0 1"
        }
      },
      {
        "box": {
          "id": "as-safety-change",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 3,
          "patching_rect": [
            220.0,
            2755.0,
            185.0,
            22.0
          ],
          "text": "change -1"
        }
      },
      {
        "box": {
          "id": "as-unsafe",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            420.0,
            2755.0,
            185.0,
            22.0
          ],
          "text": "sel 0"
        }
      },
      {
        "box": {
          "id": "as-control-0",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 3,
          "patching_rect": [
            620.0,
            2755.0,
            185.0,
            22.0
          ],
          "text": "change -999999."
        }
      },
      {
        "box": {
          "id": "as-control-1",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 3,
          "patching_rect": [
            820.0,
            2755.0,
            185.0,
            22.0
          ],
          "text": "change -999999."
        }
      },
      {
        "box": {
          "id": "as-control-2",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 3,
          "patching_rect": [
            1020.0,
            2755.0,
            185.0,
            22.0
          ],
          "text": "change -999999."
        }
      },
      {
        "box": {
          "id": "as-control-3",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 3,
          "patching_rect": [
            20.0,
            2800.0,
            185.0,
            22.0
          ],
          "text": "change -999999."
        }
      },
      {
        "box": {
          "id": "as-control-4",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 3,
          "patching_rect": [
            220.0,
            2800.0,
            185.0,
            22.0
          ],
          "text": "change -999999."
        }
      },
      {
        "box": {
          "id": "as-control-5",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 3,
          "patching_rect": [
            420.0,
            2800.0,
            185.0,
            22.0
          ],
          "text": "change -999999."
        }
      },
      {
        "box": {
          "id": "as-control-6",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 3,
          "patching_rect": [
            620.0,
            2800.0,
            185.0,
            22.0
          ],
          "text": "change -999999."
        }
      },
      {
        "box": {
          "id": "as-user-off",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            820.0,
            2800.0,
            185.0,
            22.0
          ],
          "text": "sel 0"
        }
      },
      {
        "box": {
          "id": "as-user-off-note",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            1020.0,
            2800.0,
            185.0,
            22.0
          ],
          "text": "7"
        }
      },
      {
        "box": {
          "id": "as-reason-unpack",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 4,
          "patching_rect": [
            20.0,
            2845.0,
            185.0,
            22.0
          ],
          "text": "unpack 0 0 0 0"
        }
      },
      {
        "box": {
          "id": "as-reason-allowed",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            220.0,
            2845.0,
            185.0,
            22.0
          ],
          "text": "expr ($i1 > 0) && ($i2 == 0)"
        }
      },
      {
        "box": {
          "id": "as-intent-store",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            420.0,
            2845.0,
            185.0,
            22.0
          ],
          "text": "i 0"
        }
      },
      {
        "box": {
          "id": "as-reason-bang",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            620.0,
            2845.0,
            185.0,
            22.0
          ],
          "text": "t b"
        }
      },
      {
        "box": {
          "id": "ac-control",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            820.0,
            2845.0,
            185.0,
            22.0
          ],
          "text": "route autocalenabled autocalvalid"
        }
      },
      {
        "box": {
          "id": "ac-state",
          "maxclass": "newobj",
          "numinlets": 6,
          "numoutlets": 1,
          "patching_rect": [
            1020.0,
            2845.0,
            185.0,
            22.0
          ],
          "text": "pak 1 0 0 0. 0 0"
        }
      },
      {
        "box": {
          "id": "ac-unpack",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 6,
          "patching_rect": [
            20.0,
            2890.0,
            185.0,
            22.0
          ],
          "text": "unpack 0 0 0 0. 0 0"
        }
      },
      {
        "box": {
          "id": "ac-eligible",
          "maxclass": "newobj",
          "numinlets": 6,
          "numoutlets": 1,
          "patching_rect": [
            220.0,
            2890.0,
            185.0,
            22.0
          ],
          "text": "expr ($i1 > 0) && ($i2 == 0) && ($i3 > 0) && ($f4 > 0.001) && ($i5 == 0) && ($i6 == 0)"
        }
      },
      {
        "box": {
          "id": "ac-change",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 3,
          "patching_rect": [
            420.0,
            2890.0,
            185.0,
            22.0
          ],
          "text": "change -1"
        }
      },
      {
        "box": {
          "id": "ac-select",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            620.0,
            2890.0,
            185.0,
            22.0
          ],
          "text": "sel 0 1"
        }
      },
      {
        "box": {
          "id": "ac-delay",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            820.0,
            2890.0,
            185.0,
            22.0
          ],
          "text": "delay 1000"
        }
      },
      {
        "box": {
          "id": "ac-delay-cancel",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            1020.0,
            2890.0,
            185.0,
            22.0
          ],
          "text": "stop"
        }
      },
      {
        "box": {
          "id": "ac-launch-gate",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            20.0,
            2935.0,
            185.0,
            22.0
          ],
          "text": "gate 1 0"
        }
      },
      {
        "box": {
          "id": "ac-launch",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            220.0,
            2935.0,
            185.0,
            22.0
          ],
          "text": "t b b b"
        }
      },
      {
        "box": {
          "id": "ac-attempted",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            420.0,
            2935.0,
            185.0,
            22.0
          ],
          "text": "1"
        }
      },
      {
        "box": {
          "id": "ac-retry",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            620.0,
            2935.0,
            185.0,
            22.0
          ],
          "text": "0"
        }
      },
      {
        "box": {
          "id": "ac-active",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            820.0,
            2935.0,
            185.0,
            22.0
          ],
          "text": "1"
        }
      },
      {
        "box": {
          "id": "ac-inactive",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            1020.0,
            2935.0,
            185.0,
            22.0
          ],
          "text": "0"
        }
      },
      {
        "box": {
          "id": "ac-cancel-active",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            20.0,
            2980.0,
            185.0,
            22.0
          ],
          "text": "gate 1 0"
        }
      },
      {
        "box": {
          "id": "ac-preference-change",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 3,
          "patching_rect": [
            220.0,
            2980.0,
            185.0,
            22.0
          ],
          "text": "change -1"
        }
      },
      {
        "box": {
          "id": "ac-preference-off",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            420.0,
            2980.0,
            185.0,
            22.0
          ],
          "text": "sel 0"
        }
      },
      {
        "box": {
          "id": "ac-cancel-code",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            620.0,
            2980.0,
            185.0,
            22.0
          ],
          "text": "19"
        }
      },
      {
        "box": {
          "id": "ac-play-stopped",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            820.0,
            2980.0,
            185.0,
            22.0
          ],
          "text": "sel 0"
        }
      },
      {
        "box": {
          "id": "ac-manual",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            1020.0,
            2980.0,
            185.0,
            22.0
          ],
          "text": "t b b"
        }
      },
      {
        "box": {
          "id": "ac-mark-valid",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            20.0,
            3025.0,
            185.0,
            22.0
          ],
          "text": "autocalvalid 1"
        }
      },
      {
        "box": {
          "id": "ac-nonzero",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            220.0,
            3025.0,
            185.0,
            22.0
          ],
          "text": "expr ($f1 < -0.000001) || ($f1 > 0.000001)"
        }
      },
      {
        "box": {
          "id": "ac-manual-valid",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            420.0,
            3025.0,
            185.0,
            22.0
          ],
          "text": "sel 1"
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
          ],
          "order": 0
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
          ],
          "order": 0
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
            2
          ],
          "destination": [
            "safety-pak",
            0
          ],
          "order": 0
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
          ],
          "order": 0
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
            "deviceon-change",
            0
          ],
          "destination": [
            "deviceon-change-reason",
            0
          ]
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
            "stopped-select",
            0
          ],
          "destination": [
            "stopped-select-reason",
            0
          ]
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
            "enabled-off",
            0
          ],
          "destination": [
            "enabled-off-reason",
            0
          ]
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
          ],
          "order": 0
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
          ],
          "order": 0
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
          "order": 1
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
          ],
          "order": 0
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
          ],
          "order": 0
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
          ],
          "order": 0
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
          ],
          "order": 0
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
          ],
          "order": 0
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
          ],
          "order": 0
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
          ],
          "order": 0
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
          "order": 1
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
      },
      {
        "patchline": {
          "source": [
            "popup",
            1
          ],
          "destination": [
            "ui-device-theme-select",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ui-device-theme-select",
            0
          ],
          "destination": [
            "ui-device-palette-0",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ui-device-palette-0",
            0
          ],
          "destination": [
            "ui-device-window",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ui-device-theme-select",
            1
          ],
          "destination": [
            "ui-device-palette-1",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ui-device-palette-1",
            0
          ],
          "destination": [
            "ui-device-window",
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
            "lat-engine",
            0
          ],
          "order": 5
        }
      },
      {
        "patchline": {
          "source": [
            "plugin",
            1
          ],
          "destination": [
            "lat-engine",
            1
          ],
          "order": 4
        }
      },
      {
        "patchline": {
          "source": [
            "beat-plugin",
            0
          ],
          "destination": [
            "lat-engine",
            2
          ],
          "order": 2
        }
      },
      {
        "patchline": {
          "source": [
            "beat-plugin",
            1
          ],
          "destination": [
            "lat-engine",
            3
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
            "lat-engine",
            4
          ],
          "order": 2
        }
      },
      {
        "patchline": {
          "source": [
            "control-route",
            1
          ],
          "destination": [
            "lat-permit-pak",
            0
          ],
          "order": 3
        }
      },
      {
        "patchline": {
          "source": [
            "control-route",
            2
          ],
          "destination": [
            "lat-permit-pak",
            1
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "api-valid",
            0
          ],
          "destination": [
            "lat-permit-pak",
            3
          ],
          "order": 6
        }
      },
      {
        "patchline": {
          "source": [
            "thisdevice",
            1
          ],
          "destination": [
            "lat-permit-pak",
            4
          ],
          "order": 2
        }
      },
      {
        "patchline": {
          "source": [
            "audio-alive",
            0
          ],
          "destination": [
            "lat-permit-pak",
            5
          ],
          "order": 4
        }
      },
      {
        "patchline": {
          "source": [
            "lat-permit-pak",
            0
          ],
          "destination": [
            "lat-permit-unpack",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-permit-unpack",
            0
          ],
          "destination": [
            "lat-permit-expr",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "lat-permit-unpack",
            1
          ],
          "destination": [
            "lat-permit-expr",
            1
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "lat-permit-unpack",
            2
          ],
          "destination": [
            "lat-permit-expr",
            2
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "lat-permit-unpack",
            3
          ],
          "destination": [
            "lat-permit-expr",
            3
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "lat-permit-unpack",
            4
          ],
          "destination": [
            "lat-permit-expr",
            4
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "lat-permit-unpack",
            5
          ],
          "destination": [
            "lat-permit-expr",
            5
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "lat-permit-unpack",
            6
          ],
          "destination": [
            "lat-permit-expr",
            6
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "lat-permit-unpack",
            7
          ],
          "destination": [
            "lat-permit-expr",
            7
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "lat-permit-unpack",
            8
          ],
          "destination": [
            "lat-permit-expr",
            8
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "lat-permit-unpack",
            0
          ],
          "destination": [
            "lat-reason-expr",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "lat-permit-unpack",
            1
          ],
          "destination": [
            "lat-reason-expr",
            1
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "lat-permit-unpack",
            2
          ],
          "destination": [
            "lat-reason-expr",
            2
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "lat-permit-unpack",
            3
          ],
          "destination": [
            "lat-reason-expr",
            3
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "lat-permit-unpack",
            4
          ],
          "destination": [
            "lat-reason-expr",
            4
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "lat-permit-unpack",
            5
          ],
          "destination": [
            "lat-reason-expr",
            5
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "lat-permit-unpack",
            6
          ],
          "destination": [
            "lat-reason-expr",
            6
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "lat-permit-unpack",
            7
          ],
          "destination": [
            "lat-reason-expr",
            7
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "lat-permit-unpack",
            8
          ],
          "destination": [
            "lat-reason-expr",
            8
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "lat-reason-expr",
            0
          ],
          "destination": [
            "lat-reason-tag",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "lat-reason-tag",
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
            "lat-reason-expr",
            0
          ],
          "destination": [
            "lat-guard-reason-tag",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "lat-guard-reason-tag",
            0
          ],
          "destination": [
            "lat-engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-permit-expr",
            0
          ],
          "destination": [
            "lat-permit",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-permit",
            0
          ],
          "destination": [
            "lat-permit-tag",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "lat-permit-tag",
            0
          ],
          "destination": [
            "lat-engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "api-clear",
            0
          ],
          "destination": [
            "lat-unknown",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "api-lost",
            0
          ],
          "destination": [
            "lat-unknown",
            0
          ],
          "order": 2
        }
      },
      {
        "patchline": {
          "source": [
            "bind-id",
            0
          ],
          "destination": [
            "lat-observe-0",
            1
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "lat-observe-0",
            0
          ],
          "destination": [
            "lat-permit-pak",
            6
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-unknown",
            0
          ],
          "destination": [
            "lat-permit-pak",
            6
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "bind-id",
            0
          ],
          "destination": [
            "lat-observe-1",
            1
          ],
          "order": 2
        }
      },
      {
        "patchline": {
          "source": [
            "lat-observe-1",
            0
          ],
          "destination": [
            "lat-permit-pak",
            7
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-unknown",
            0
          ],
          "destination": [
            "lat-permit-pak",
            7
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "bind-id",
            0
          ],
          "destination": [
            "lat-observe-2",
            1
          ],
          "order": 3
        }
      },
      {
        "patchline": {
          "source": [
            "lat-observe-2",
            0
          ],
          "destination": [
            "lat-permit-pak",
            8
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-unknown",
            0
          ],
          "destination": [
            "lat-permit-pak",
            8
          ],
          "order": 2
        }
      },
      {
        "patchline": {
          "source": [
            "bind-id",
            0
          ],
          "destination": [
            "lat-observe-3",
            1
          ],
          "order": 4
        }
      },
      {
        "patchline": {
          "source": [
            "lat-observe-3",
            0
          ],
          "destination": [
            "lat-permit-pak",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-unknown",
            0
          ],
          "destination": [
            "lat-permit-pak",
            2
          ],
          "order": 3
        }
      },
      {
        "patchline": {
          "source": [
            "api-valid",
            0
          ],
          "destination": [
            "lat-api-bound",
            0
          ],
          "order": 7
        }
      },
      {
        "patchline": {
          "source": [
            "lat-api-bound",
            0
          ],
          "destination": [
            "lat-requery-defer",
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
            "lat-requery-gate",
            0
          ],
          "order": 8
        }
      },
      {
        "patchline": {
          "source": [
            "lat-requery-defer",
            0
          ],
          "destination": [
            "lat-requery-gate",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-requery-gate",
            0
          ],
          "destination": [
            "lat-requery-trigger",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-requery-trigger",
            0
          ],
          "destination": [
            "lat-property-0",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-property-0",
            0
          ],
          "destination": [
            "lat-observe-0",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-requery-trigger",
            1
          ],
          "destination": [
            "lat-property-1",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-property-1",
            0
          ],
          "destination": [
            "lat-observe-1",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-requery-trigger",
            2
          ],
          "destination": [
            "lat-property-2",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-property-2",
            0
          ],
          "destination": [
            "lat-observe-2",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-requery-trigger",
            3
          ],
          "destination": [
            "lat-property-3",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-property-3",
            0
          ],
          "destination": [
            "lat-observe-3",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "popup",
            2
          ],
          "destination": [
            "lat-request-counter",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "lat-request-counter",
            0
          ],
          "destination": [
            "lat-request-trigger",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-request-trigger",
            2
          ],
          "destination": [
            "lat-pending-on",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "lat-request-trigger",
            0
          ],
          "destination": [
            "lat-request-tag",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-request-tag",
            0
          ],
          "destination": [
            "lat-engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-cancel-counter",
            0
          ],
          "destination": [
            "lat-cancel-tag",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-cancel-tag",
            0
          ],
          "destination": [
            "lat-engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-cancel-bang",
            0
          ],
          "destination": [
            "lat-cancel-counter",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "lat-cancel-bang",
            1
          ],
          "destination": [
            "lat-cancel-reason-tag",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-cancel-reason-tag",
            0
          ],
          "destination": [
            "lat-engine",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "control-route",
            0
          ],
          "destination": [
            "lat-cancel-filter-1",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "lat-cancel-filter-1",
            0
          ],
          "destination": [
            "lat-cancel-code-1",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-cancel-code-1",
            0
          ],
          "destination": [
            "lat-cancel-bang",
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
            "lat-cancel-filter-2",
            0
          ],
          "order": 4
        }
      },
      {
        "patchline": {
          "source": [
            "lat-cancel-filter-2",
            0
          ],
          "destination": [
            "lat-cancel-code-2",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-cancel-code-2",
            0
          ],
          "destination": [
            "lat-cancel-bang",
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
            "lat-cancel-filter-3",
            0
          ],
          "order": 2
        }
      },
      {
        "patchline": {
          "source": [
            "lat-cancel-filter-3",
            0
          ],
          "destination": [
            "lat-cancel-code-3",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-cancel-code-3",
            0
          ],
          "destination": [
            "lat-cancel-bang",
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
            "lat-cancel-filter-4",
            0
          ],
          "order": 2
        }
      },
      {
        "patchline": {
          "source": [
            "lat-cancel-filter-4",
            0
          ],
          "destination": [
            "lat-cancel-code-4",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-cancel-code-4",
            0
          ],
          "destination": [
            "lat-cancel-bang",
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
            "lat-cancel-filter-5",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "lat-cancel-filter-5",
            0
          ],
          "destination": [
            "lat-cancel-code-5",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-cancel-code-5",
            0
          ],
          "destination": [
            "lat-cancel-bang",
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
            "lat-cancel-filter-6",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "lat-cancel-filter-6",
            0
          ],
          "destination": [
            "lat-cancel-code-6",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-cancel-code-6",
            0
          ],
          "destination": [
            "lat-cancel-bang",
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
            "lat-cancel-code-7",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "lat-cancel-code-7",
            0
          ],
          "destination": [
            "lat-cancel-bang",
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
            "lat-cancel-filter-8",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "lat-cancel-filter-8",
            0
          ],
          "destination": [
            "lat-cancel-code-8",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-cancel-code-8",
            0
          ],
          "destination": [
            "lat-cancel-bang",
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
            "lat-cancel-filter-9",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "lat-cancel-filter-9",
            0
          ],
          "destination": [
            "lat-cancel-code-9",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-cancel-code-9",
            0
          ],
          "destination": [
            "lat-cancel-bang",
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
            "lat-cancel-code-10",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "lat-cancel-code-10",
            0
          ],
          "destination": [
            "lat-cancel-bang",
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
            "lat-cancel-filter-11",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "lat-cancel-filter-11",
            0
          ],
          "destination": [
            "lat-cancel-code-11",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-cancel-code-11",
            0
          ],
          "destination": [
            "lat-cancel-bang",
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
            "lat-cancel-filter-12",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "lat-cancel-filter-12",
            0
          ],
          "destination": [
            "lat-cancel-code-12",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-cancel-code-12",
            0
          ],
          "destination": [
            "lat-cancel-bang",
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
            "lat-cancel-code-13",
            0
          ],
          "order": 3
        }
      },
      {
        "patchline": {
          "source": [
            "lat-cancel-code-13",
            0
          ],
          "destination": [
            "lat-cancel-bang",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-permit",
            0
          ],
          "destination": [
            "lat-disallowed",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "lat-disallowed",
            0
          ],
          "destination": [
            "lat-cancel-code-14",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-cancel-code-14",
            0
          ],
          "destination": [
            "lat-cancel-bang",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "wave-samplerate",
            0
          ],
          "destination": [
            "lat-dsp-change-0",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-dsp-change-0",
            0
          ],
          "destination": [
            "lat-cancel-code-15",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-cancel-code-15",
            0
          ],
          "destination": [
            "lat-cancel-bang",
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
            "lat-dsp-change-1",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "lat-dsp-change-1",
            0
          ],
          "destination": [
            "lat-cancel-code-16",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-cancel-code-16",
            0
          ],
          "destination": [
            "lat-cancel-bang",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "wave-samplerate",
            2
          ],
          "destination": [
            "lat-dsp-change-2",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-dsp-change-2",
            0
          ],
          "destination": [
            "lat-cancel-code-17",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-cancel-code-17",
            0
          ],
          "destination": [
            "lat-cancel-bang",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "wave-samplerate",
            3
          ],
          "destination": [
            "lat-dsp-change-3",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-dsp-change-3",
            0
          ],
          "destination": [
            "lat-cancel-code-18",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-cancel-code-18",
            0
          ],
          "destination": [
            "lat-cancel-bang",
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
            "lat-poll",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "lat-engine",
            0
          ],
          "destination": [
            "lat-snapshot-0",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-poll",
            0
          ],
          "destination": [
            "lat-snapshot-0",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-engine",
            5
          ],
          "destination": [
            "lat-snapshot-5",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-poll",
            1
          ],
          "destination": [
            "lat-snapshot-5",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-engine",
            4
          ],
          "destination": [
            "lat-snapshot-4",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-poll",
            2
          ],
          "destination": [
            "lat-snapshot-4",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-engine",
            2
          ],
          "destination": [
            "lat-snapshot-2",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-poll",
            3
          ],
          "destination": [
            "lat-snapshot-2",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-engine",
            1
          ],
          "destination": [
            "lat-snapshot-1",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-poll",
            4
          ],
          "destination": [
            "lat-snapshot-1",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-engine",
            6
          ],
          "destination": [
            "lat-snapshot-6",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-poll",
            5
          ],
          "destination": [
            "lat-snapshot-6",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-engine",
            7
          ],
          "destination": [
            "lat-snapshot-7",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-poll",
            6
          ],
          "destination": [
            "lat-snapshot-7",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-engine",
            8
          ],
          "destination": [
            "lat-snapshot-8",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-poll",
            7
          ],
          "destination": [
            "lat-snapshot-8",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-engine",
            9
          ],
          "destination": [
            "lat-snapshot-9",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-poll",
            8
          ],
          "destination": [
            "lat-snapshot-9",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-engine",
            10
          ],
          "destination": [
            "lat-snapshot-10",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-poll",
            9
          ],
          "destination": [
            "lat-snapshot-10",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-engine",
            11
          ],
          "destination": [
            "lat-snapshot-11",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-poll",
            10
          ],
          "destination": [
            "lat-snapshot-11",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-engine",
            12
          ],
          "destination": [
            "lat-snapshot-12",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-poll",
            11
          ],
          "destination": [
            "lat-snapshot-12",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-snapshot-5",
            0
          ],
          "destination": [
            "lat-diagnostic-pack",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "lat-snapshot-2",
            0
          ],
          "destination": [
            "lat-diagnostic-pack",
            1
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "lat-snapshot-6",
            0
          ],
          "destination": [
            "lat-diagnostic-pack",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-snapshot-7",
            0
          ],
          "destination": [
            "lat-diagnostic-pack",
            3
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-snapshot-8",
            0
          ],
          "destination": [
            "lat-diagnostic-pack",
            4
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-snapshot-9",
            0
          ],
          "destination": [
            "lat-diagnostic-pack",
            5
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-snapshot-10",
            0
          ],
          "destination": [
            "lat-diagnostic-pack",
            6
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-snapshot-11",
            0
          ],
          "destination": [
            "lat-diagnostic-pack",
            7
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-snapshot-12",
            0
          ],
          "destination": [
            "lat-diagnostic-pack",
            8
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-snapshot-5",
            0
          ],
          "destination": [
            "lat-cancel-ui-tag",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "lat-cancel-ui-tag",
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
            "lat-diagnostic-pack",
            0
          ],
          "destination": [
            "lat-diagnostic-tag",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-diagnostic-tag",
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
            "lat-snapshot-1",
            0
          ],
          "destination": [
            "lat-result-store",
            1
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "lat-snapshot-4",
            0
          ],
          "destination": [
            "lat-status-token-pak",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "lat-request-trigger",
            1
          ],
          "destination": [
            "lat-status-token-pak",
            1
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "lat-status-token-pak",
            0
          ],
          "destination": [
            "lat-status-token-unpack",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-status-token-unpack",
            0
          ],
          "destination": [
            "lat-status-token-expr",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-status-token-unpack",
            1
          ],
          "destination": [
            "lat-status-token-expr",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-status-token-expr",
            0
          ],
          "destination": [
            "lat-status-token-gate",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-snapshot-0",
            0
          ],
          "destination": [
            "lat-status-token-gate",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-status-token-gate",
            0
          ],
          "destination": [
            "lat-status-int",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-status-int",
            0
          ],
          "destination": [
            "lat-status-change",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-request-trigger",
            2
          ],
          "destination": [
            "lat-status-reset",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "lat-status-reset",
            0
          ],
          "destination": [
            "lat-status-change",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-status-tag",
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
            "lat-status-change",
            0
          ],
          "destination": [
            "lat-success",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "lat-success",
            1
          ],
          "destination": [
            "lat-status-tag",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-success",
            0
          ],
          "destination": [
            "lat-accept-defer",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-permit",
            0
          ],
          "destination": [
            "lat-accept-pak",
            0
          ],
          "order": 2
        }
      },
      {
        "patchline": {
          "source": [
            "lat-pending-on",
            0
          ],
          "destination": [
            "lat-accept-pak",
            1
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "lat-snapshot-4",
            0
          ],
          "destination": [
            "lat-accept-pak",
            2
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "lat-request-trigger",
            1
          ],
          "destination": [
            "lat-accept-pak",
            3
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "lat-snapshot-2",
            0
          ],
          "destination": [
            "lat-accept-pak",
            4
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "lat-snapshot-1",
            0
          ],
          "destination": [
            "lat-accept-pak",
            5
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "lat-accept-unpack",
            0
          ],
          "destination": [
            "lat-commit-reason-expr",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "lat-accept-unpack",
            1
          ],
          "destination": [
            "lat-commit-reason-expr",
            1
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "lat-accept-unpack",
            2
          ],
          "destination": [
            "lat-commit-reason-expr",
            2
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "lat-accept-unpack",
            3
          ],
          "destination": [
            "lat-commit-reason-expr",
            3
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "lat-accept-unpack",
            4
          ],
          "destination": [
            "lat-commit-reason-expr",
            4
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "lat-accept-unpack",
            5
          ],
          "destination": [
            "lat-commit-reason-expr",
            5
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "lat-commit-reason-expr",
            0
          ],
          "destination": [
            "lat-commit-reason-store",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-commit-reason-store",
            0
          ],
          "destination": [
            "lat-cancel-ui-tag",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-accept-pak",
            0
          ],
          "destination": [
            "lat-accept-unpack",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-accept-unpack",
            0
          ],
          "destination": [
            "lat-accept-expr",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "lat-accept-unpack",
            1
          ],
          "destination": [
            "lat-accept-expr",
            1
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "lat-accept-unpack",
            2
          ],
          "destination": [
            "lat-accept-expr",
            2
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "lat-accept-unpack",
            3
          ],
          "destination": [
            "lat-accept-expr",
            3
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "lat-accept-unpack",
            4
          ],
          "destination": [
            "lat-accept-expr",
            4
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "lat-accept-unpack",
            5
          ],
          "destination": [
            "lat-accept-expr",
            5
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "lat-accept-expr",
            0
          ],
          "destination": [
            "lat-accept-gate",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "lat-accept-expr",
            0
          ],
          "destination": [
            "lat-commit-check",
            1
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "lat-accept-defer",
            0
          ],
          "destination": [
            "lat-commit-check",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-commit-check",
            0
          ],
          "destination": [
            "lat-commit-select",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-commit-select",
            0
          ],
          "destination": [
            "lat-commit-failure",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-commit-failure",
            1
          ],
          "destination": [
            "lat-commit-reason-store",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-commit-failure",
            0
          ],
          "destination": [
            "lat-commit-rejected",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-commit-rejected",
            0
          ],
          "destination": [
            "lat-status-tag",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-commit-select",
            1
          ],
          "destination": [
            "lat-accept-gate",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-accept-gate",
            0
          ],
          "destination": [
            "lat-accept-once",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-accept-once",
            2
          ],
          "destination": [
            "lat-pending-off",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-status-change",
            0
          ],
          "destination": [
            "lat-terminal",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "lat-terminal",
            0
          ],
          "destination": [
            "lat-pending-off",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "lat-terminal",
            1
          ],
          "destination": [
            "lat-pending-off",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "lat-terminal",
            2
          ],
          "destination": [
            "lat-pending-off",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "lat-cancel-bang",
            0
          ],
          "destination": [
            "lat-pending-off",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "lat-pending-off",
            0
          ],
          "destination": [
            "lat-accept-pak",
            1
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "lat-accept-once",
            1
          ],
          "destination": [
            "lat-result-store",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-accept-once",
            0
          ],
          "destination": [
            "lat-commit-applied",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-commit-applied",
            0
          ],
          "destination": [
            "lat-status-tag",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "lat-result-store",
            0
          ],
          "destination": [
            "lat-offset-tag",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-offset-tag",
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
            "as-state",
            0
          ],
          "destination": [
            "as-unpack",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "as-unpack",
            0
          ],
          "destination": [
            "as-ready",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "as-unpack",
            1
          ],
          "destination": [
            "as-ready",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "as-unpack",
            2
          ],
          "destination": [
            "as-ready",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "as-unpack",
            3
          ],
          "destination": [
            "as-ready",
            3
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
            "as-state",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "as-ready",
            0
          ],
          "destination": [
            "as-effective-change",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "as-effective-change",
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
            "as-ready",
            0
          ],
          "destination": [
            "as-request-gate",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "stop-select",
            0
          ],
          "destination": [
            "as-note-gate",
            1
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "as-note-gate",
            0
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
            "stop-select",
            0
          ],
          "destination": [
            "as-request-gate",
            1
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "as-spent",
            0
          ],
          "destination": [
            "as-state",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "as-unspent",
            0
          ],
          "destination": [
            "as-state",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "as-low-clear",
            0
          ],
          "destination": [
            "as-state",
            3
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "as-low-seen",
            0
          ],
          "destination": [
            "as-state",
            3
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
            "as-low-select",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "as-low-select",
            0
          ],
          "destination": [
            "as-low-seen",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "as-invalidate",
            1
          ],
          "destination": [
            "as-low-clear",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "as-invalidate",
            0
          ],
          "destination": [
            "as-generation",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "as-generation",
            0
          ],
          "destination": [
            "as-generation-store",
            1
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "as-generation",
            0
          ],
          "destination": [
            "as-commit",
            1
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "safety",
            0
          ],
          "destination": [
            "as-commit",
            2
          ],
          "order": 2
        }
      },
      {
        "patchline": {
          "source": [
            "stop-defer",
            0
          ],
          "destination": [
            "as-commit",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "as-commit",
            0
          ],
          "destination": [
            "as-commit-select",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "as-commit-select",
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
            "as-request-gate",
            0
          ],
          "destination": [
            "as-request",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "as-request",
            1
          ],
          "destination": [
            "as-spent",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "as-request",
            0
          ],
          "destination": [
            "as-generation-store",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "as-generation-store",
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
            "bind-id",
            0
          ],
          "destination": [
            "as-play-observer",
            1
          ],
          "order": 5
        }
      },
      {
        "patchline": {
          "source": [
            "api-valid",
            0
          ],
          "destination": [
            "as-api-select",
            0
          ],
          "order": 9
        }
      },
      {
        "patchline": {
          "source": [
            "as-api-select",
            0
          ],
          "destination": [
            "as-play-unknown",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "as-api-select",
            1
          ],
          "destination": [
            "as-play-query",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "as-play-query",
            0
          ],
          "destination": [
            "as-play-observer",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "as-play-observer",
            0
          ],
          "destination": [
            "as-play-change",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "as-play-unknown",
            0
          ],
          "destination": [
            "as-play-change",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "as-play-change",
            0
          ],
          "destination": [
            "as-play-update",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "as-play-update",
            1
          ],
          "destination": [
            "as-invalidate",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "as-play-update",
            0
          ],
          "destination": [
            "as-state",
            1
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "as-play-update",
            0
          ],
          "destination": [
            "as-commit",
            3
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "as-play-update",
            0
          ],
          "destination": [
            "as-play-select",
            0
          ],
          "order": 2
        }
      },
      {
        "patchline": {
          "source": [
            "as-play-select",
            0
          ],
          "destination": [
            "as-unspent",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "as-play-select",
            1
          ],
          "destination": [
            "stop-check-cancel",
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
            "as-safety-change",
            0
          ],
          "order": 3
        }
      },
      {
        "patchline": {
          "source": [
            "as-safety-change",
            0
          ],
          "destination": [
            "as-unsafe",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "as-unsafe",
            0
          ],
          "destination": [
            "as-invalidate",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "control-route",
            0
          ],
          "destination": [
            "as-control-0",
            0
          ],
          "order": 2
        }
      },
      {
        "patchline": {
          "source": [
            "as-control-0",
            0
          ],
          "destination": [
            "as-invalidate",
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
            "as-control-1",
            0
          ],
          "order": 5
        }
      },
      {
        "patchline": {
          "source": [
            "as-control-1",
            0
          ],
          "destination": [
            "as-invalidate",
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
            "as-control-2",
            0
          ],
          "order": 3
        }
      },
      {
        "patchline": {
          "source": [
            "as-control-2",
            0
          ],
          "destination": [
            "as-invalidate",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "control-route",
            3
          ],
          "destination": [
            "as-control-3",
            0
          ],
          "order": 3
        }
      },
      {
        "patchline": {
          "source": [
            "as-control-3",
            0
          ],
          "destination": [
            "as-invalidate",
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
            "as-control-4",
            0
          ],
          "order": 2
        }
      },
      {
        "patchline": {
          "source": [
            "as-control-4",
            0
          ],
          "destination": [
            "as-invalidate",
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
            "as-control-5",
            0
          ],
          "order": 2
        }
      },
      {
        "patchline": {
          "source": [
            "as-control-5",
            0
          ],
          "destination": [
            "as-invalidate",
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
            "as-control-6",
            0
          ],
          "order": 2
        }
      },
      {
        "patchline": {
          "source": [
            "as-control-6",
            0
          ],
          "destination": [
            "as-invalidate",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "as-control-2",
            0
          ],
          "destination": [
            "as-user-off",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "as-user-off",
            0
          ],
          "destination": [
            "as-unspent",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "as-user-off",
            0
          ],
          "destination": [
            "as-user-off-note",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "as-user-off-note",
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
            "as-state",
            0
          ],
          "destination": [
            "as-reason-unpack",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "as-reason-unpack",
            2
          ],
          "destination": [
            "as-reason-allowed",
            1
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
            "as-reason-allowed",
            0
          ],
          "order": 4
        }
      },
      {
        "patchline": {
          "source": [
            "control-route",
            2
          ],
          "destination": [
            "as-intent-store",
            1
          ],
          "order": 5
        }
      },
      {
        "patchline": {
          "source": [
            "as-reason-unpack",
            0
          ],
          "destination": [
            "as-reason-bang",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "as-reason-bang",
            0
          ],
          "destination": [
            "as-intent-store",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "as-intent-store",
            0
          ],
          "destination": [
            "as-reason-allowed",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "as-reason-allowed",
            0
          ],
          "destination": [
            "disarm-reason-gate",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "as-reason-allowed",
            0
          ],
          "destination": [
            "as-note-gate",
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
            "as-play-unknown",
            0
          ],
          "order": 2
        }
      },
      {
        "patchline": {
          "source": [
            "ready-trigger",
            2
          ],
          "destination": [
            "as-unspent",
            0
          ],
          "order": 3
        }
      },
      {
        "patchline": {
          "source": [
            "ready-trigger",
            2
          ],
          "destination": [
            "as-invalidate",
            0
          ],
          "order": 4
        }
      },
      {
        "patchline": {
          "source": [
            "popup",
            3
          ],
          "destination": [
            "ac-control",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ac-control",
            0
          ],
          "destination": [
            "ac-state",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "ac-control",
            1
          ],
          "destination": [
            "ac-state",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-permit",
            0
          ],
          "destination": [
            "ac-state",
            2
          ],
          "order": 3
        }
      },
      {
        "patchline": {
          "source": [
            "beat-peak",
            0
          ],
          "destination": [
            "ac-state",
            3
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "lat-pending-on",
            0
          ],
          "destination": [
            "ac-state",
            4
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "lat-pending-off",
            0
          ],
          "destination": [
            "ac-state",
            4
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "ac-state",
            0
          ],
          "destination": [
            "ac-unpack",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ac-unpack",
            0
          ],
          "destination": [
            "ac-eligible",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ac-unpack",
            1
          ],
          "destination": [
            "ac-eligible",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ac-unpack",
            2
          ],
          "destination": [
            "ac-eligible",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ac-unpack",
            3
          ],
          "destination": [
            "ac-eligible",
            3
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ac-unpack",
            4
          ],
          "destination": [
            "ac-eligible",
            4
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ac-unpack",
            5
          ],
          "destination": [
            "ac-eligible",
            5
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ac-eligible",
            0
          ],
          "destination": [
            "ac-change",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "ac-change",
            0
          ],
          "destination": [
            "ac-select",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ac-select",
            0
          ],
          "destination": [
            "ac-delay-cancel",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ac-delay-cancel",
            0
          ],
          "destination": [
            "ac-delay",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ac-select",
            1
          ],
          "destination": [
            "ac-delay",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ac-eligible",
            0
          ],
          "destination": [
            "ac-launch-gate",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "ac-delay",
            0
          ],
          "destination": [
            "ac-launch-gate",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ac-launch-gate",
            0
          ],
          "destination": [
            "ac-launch",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ac-attempted",
            0
          ],
          "destination": [
            "ac-state",
            5
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ac-retry",
            0
          ],
          "destination": [
            "ac-state",
            5
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ac-launch",
            2
          ],
          "destination": [
            "ac-attempted",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ac-active",
            0
          ],
          "destination": [
            "ac-cancel-active",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ac-inactive",
            0
          ],
          "destination": [
            "ac-cancel-active",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ac-launch",
            1
          ],
          "destination": [
            "ac-active",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ac-launch",
            0
          ],
          "destination": [
            "lat-request-counter",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ac-control",
            0
          ],
          "destination": [
            "ac-preference-change",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "ac-preference-change",
            0
          ],
          "destination": [
            "ac-retry",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "ac-preference-change",
            0
          ],
          "destination": [
            "ac-preference-off",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "ac-preference-off",
            0
          ],
          "destination": [
            "ac-cancel-active",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ac-cancel-active",
            0
          ],
          "destination": [
            "ac-cancel-code",
            0
          ],
          "order": 0
        }
      },
      {
        "patchline": {
          "source": [
            "ac-cancel-code",
            0
          ],
          "destination": [
            "lat-cancel-bang",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ac-cancel-active",
            0
          ],
          "destination": [
            "ac-inactive",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "lat-commit-applied",
            0
          ],
          "destination": [
            "ac-inactive",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "lat-terminal",
            0
          ],
          "destination": [
            "ac-inactive",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "lat-terminal",
            1
          ],
          "destination": [
            "ac-inactive",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "lat-terminal",
            2
          ],
          "destination": [
            "ac-inactive",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "as-play-change",
            0
          ],
          "destination": [
            "ac-play-stopped",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "ac-play-stopped",
            0
          ],
          "destination": [
            "ac-retry",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "popup",
            2
          ],
          "destination": [
            "ac-manual",
            0
          ],
          "order": 1
        }
      },
      {
        "patchline": {
          "source": [
            "ac-manual",
            1
          ],
          "destination": [
            "ac-inactive",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ac-manual",
            0
          ],
          "destination": [
            "ac-attempted",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "lat-commit-applied",
            0
          ],
          "destination": [
            "ac-mark-valid",
            0
          ],
          "order": 2
        }
      },
      {
        "patchline": {
          "source": [
            "ac-mark-valid",
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
            5
          ],
          "destination": [
            "ac-nonzero",
            0
          ],
          "order": 3
        }
      },
      {
        "patchline": {
          "source": [
            "ac-nonzero",
            0
          ],
          "destination": [
            "ac-manual-valid",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "ac-manual-valid",
            0
          ],
          "destination": [
            "ac-mark-valid",
            0
          ]
        }
      }
    ],
    "autosave": 0,
    "devicewidth": 360.0,
    "description": "Audio onset grid proximity monitor",
    "digest": "Vocal Timing Monitor 0.9 RC1.7.1 Studio - native embedded engine",
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
      ],
      "popup::theme": [
        "VTM Theme",
        "VTM Theme",
        0
      ],
      "popup::auto-calibrate": [
        "VTM Automatic calibration",
        "VTM Automatic calibration",
        0
      ],
      "popup::ac-valid": [
        "VTM Compensation valid",
        "VTM Compensation valid",
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