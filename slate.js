// Configs
S.cfga({
	"defaultToCurrentScreen" : true,
	"secondsBetweenRepeat" : 0.1,
	"checkDefaultsOnLoad" : true,
	"focusCheckWidthMax" : 3000,
	"orderScreensLeftToRight" : true
});

// Monitors
var monTbolt  = "2560x1600";
var monLaptop = "1920x1200";

// Operations
var lapFull = S.op("move", {
	"screen" : monLaptop,
	"x" : "screenOriginX",
	"y" : "screenOriginY",
	"width" : "screenSizeX",
	"height" : "screenSizeY"
});
var lapChat = S.op("corner", {
	"screen" : monLaptop,
	"direction" : "top-left",
	"width" : "screenSizeX/9",
	"height" : "screenSizeY"
});
var lapMain = lapChat.dup({ "direction" : "top-right", "width" : "8*screenSizeX/9" });
var tboltFull = S.op("move", {
	"screen" : monTbolt,
	"x" : "screenOriginX",
	"y" : "screenOriginY",
	"width" : "screenSizeX",
	"height" : "screenSizeY"
});
var tboltBig = S.op("move", {
	"screen" : monTbolt,
	"x" : "screenOriginX+screenSizeX/3",
	"y" : "screenOriginY",
	"width" : "screenSizeX*2/3",
	"height" : "screenSizeY"
});
var tboltLeft = tboltFull.dup({ "width" : "screenSizeX/3" });
var tboltMid = tboltLeft.dup({ "x" : "screenOriginX+screenSizeX/3" });
var tboltRight = tboltLeft.dup({ "x" : "screenOriginX+(screenSizeX*2/3)" });
var tboltLeftTop = tboltLeft.dup({ "height" : "screenSizeY/2" });
var tboltLeftBot = tboltLeftTop.dup({ "y" : "screenOriginY+screenSizeY/2" });
var tboltMidTop = tboltMid.dup({ "height" : "screenSizeY/2" });
var tboltMidBot = tboltMidTop.dup({ "y" : "screenOriginY+screenSizeY/2" });
var tboltRightTop = tboltRight.dup({ "height" : "screenSizeY/2" });
var tboltRightBot = tboltRightTop.dup({ "y" : "screenOriginY+screenSizeY/2" });

// Batch bind everything. Less typing.
S.bnda({
	// Basic Location Bindings

	// Resize Bindings
	// NOTE: some of these may *not* work if you have not removed the expose/spaces/mission control bindings
	"j:ctrl;alt;cmd" : S.op("resize", { "width" : "+10%", "height" : "+0", "anchor": "bottom-right" }),
	"j:ctrl;alt;shift;cmd" : S.op("resize", { "width" : "-10%", "height" : "+0", "anchor": "bottom-right" }),
	"l:ctrl;alt;cmd" : S.op("resize", { "width" : "+10%", "height" : "+0", "anchor": "bottom-left" }),
	"l:ctrl;alt;shift;cmd" : S.op("resize", { "width" : "-10%", "height" : "+0", "anchor": "bottom-left" }),
	"i:ctrl;alt;cmd" : S.op("resize", { "width" : "+0", "height" : "+10%", "anchor": "bottom-left" }),
	"i:ctrl;alt;shift;cmd" : S.op("resize", { "width" : "+0", "height" : "+10%", "anchor": "bottom-left" }),
	",:ctrl;alt;cmd" : S.op("resize", { "width" : "+0", "height" : "+10%", "anchor": "top-left" }),
	",:ctrl;alt;shift;cmd" : S.op("resize", { "width" : "+0", "height" : "+10%", "anchor": "top-left" }),
	"u:ctrl;alt;cmd" : S.op("resize", { "width" : "+10%", "height" : "+10%", "anchor": "bottom-right" }),
	"u:ctrl;alt;shift;cmd" : S.op("resize", { "width" : "-10%", "height" : "-10%", "anchor": "bottom-right" }),
	"o:ctrl;alt;cmd" : S.op("resize", { "width" : "+10%", "height" : "+10%", "anchor": "bottom-left" }),
	"o:ctrl;alt;shift;cmd" : S.op("resize", { "width" : "-10%", "height" : "-10%", "anchor": "bottom-left" }),
	"m:ctrl;alt;cmd" : S.op("resize", { "width" : "+10%", "height" : "+10%", "anchor": "top-right" }),
	"m:ctrl;alt;shift;cmd" : S.op("resize", { "width" : "-10%", "height" : "-10%", "anchor": "top-right" }),
	".:ctrl;alt;cmd" : S.op("resize", { "width" : "+10%", "height" : "+10%", "anchor": "top-left" }),
	".:ctrl;alt;shift;cmd" : S.op("resize", { "width" : "-10%", "height" : "-10%", "anchor": "top-left" }),

	// Push Bindings
	"l:ctrl;cmd" : S.op("push", { "direction" : "right", "style" : "bar-resize:screenSizeX/2" }),
	"j:ctrl;cmd" : S.op("push", { "direction" : "left", "style" : "bar-resize:screenSizeX/2" }),
	"i:ctrl;cmd" : S.op("push", { "direction" : "up", "style" : "bar-resize:screenSizeY/2" }),
	",:ctrl;cmd" : S.op("push", { "direction" : "down", "style" : "bar-resize:screenSizeY/2" }),
	"k:ctrl;cmd" : S.op("move", { "x" : "screenOriginX", "y" : "screenOriginY", "width" : "screenSizeX", "height" : "screenSizeY"}),
	"u:ctrl;cmd" : S.op("corner", { "direction" : "top-left", "width" : "screenSizeX/2", "height" : "screenSizeY/2"}),
	"o:ctrl;cmd" : S.op("corner", { "direction" : "top-right", "width" : "screenSizeX/2", "height" : "screenSizeY/2"}),
	"m:ctrl;cmd" : S.op("corner", { "direction" : "bottom-left", "width" : "screenSizeX/2", "height" : "screenSizeY/2"}),
	".:ctrl;cmd" : S.op("corner", { "direction" : "bottom-right", "width" : "screenSizeX/2", "height" : "screenSizeY/2"}),


	// Nudge Bindings
	"right:ctrl;alt;cmd" : S.op("nudge", { "x" : "+10%", "y" : "+0" }),
	"left:ctrl;alt;cmd" : S.op("nudge", { "x" : "-10%", "y" : "+0" }),
	"up:ctrl;alt;cmd" : S.op("nudge", { "x" : "+0", "y" : "-10%" }),
	"down:ctrl;alt;cmd" : S.op("nudge", { "x" : "+0", "y" : "+10%" }),

	// Throw Bindings
	"n:ctrl;cmd" : S.op("throw", { "screen" : "next", "width" : "screenSizeX", "height" : "screenSizeY" }),

	// Window Hints
	"esc:cmd" : S.op("hint"),

	// Switch currently doesn't work well so I'm commenting it out until I fix it.
	"tab:ctrl;cmd" : S.op("switch"),

	// Grid
	"esc:ctrl" : S.op("grid")
});


// Log that we're done configuring
S.log("[SLATE] -------------- Finished Loading Config --------------");
