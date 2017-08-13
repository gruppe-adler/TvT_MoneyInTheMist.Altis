#define CT_STRUCTURED_TEXT          13
#define ST_LEFT                     0x00

#define MITM_PREPARATIONTIME_W      pixelGridNoUIScale * pixelW * 10
#define MITM_PREPARATIONTIME_H      pixelGridNoUIScale * pixelH * 3
#define MITM_PREPARATIONTIME_X      safeZoneX + safeZoneW - MITM_PREPARATIONTIME_W
#define MITM_PREPARATIONTIME_Y      safeZoneY + pixelGridNoUIScale * pixelH * 30

class mitm_preparationTime {
    idd = -1;
    fadein = 0;
    fadeout = 1;
    duration = 2;

    enableSimulation = 1;
    enableDisplay = 1;

    class ControlsBackground {
        class Countdown {
            onLoad = "uiNamespace setVariable ['mitm_preparationTime', _this select 0];";
            onUnload = "uiNamespace setVariable ['mitm_preparationTime', controlNull];";

            idc = -1;
            access = 0;
            type = CT_STRUCTURED_TEXT;
            style = ST_LEFT;
            colorBackground[] = {0,0,0,0.85};

            size = 0.018;
            text = "GAME STARTS IN: <br/>ASD";
            class Attributes {
                font = "PuristaLight";
                color = "#ffffff";
                align = "left";
                valign = "middle";
                shadow = false;
                shadowColor = "#ff0000";
                size = "2.4";
            };

            w = MITM_PREPARATIONTIME_W;
            h = MITM_PREPARATIONTIME_H;
            x = MITM_PREPARATIONTIME_X;
            y = MITM_PREPARATIONTIME_Y;
        };
    };
};
