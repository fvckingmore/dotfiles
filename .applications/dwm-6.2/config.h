/* See LICENSE file for copyright and license details. */
#include <X11/XF86keysym.h>

/* appearance */
static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const Gap default_gap        = {.isgap = 1, .realgap = 5, .gappx = 5};
static const unsigned int snap      = 5;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "Ubuntu Bold:size=8" };
static const char dmenufont[]       = "Ubuntu Bold:size=9"; 
static const char col_gray1[]       = "#222222"; //black
static const char col_gray2[]       = "#444444"; //dark gray
static const char col_gray3[]       = "#bbbbbb"; //light gray
static const char col_gray4[]       = "#eeeeee"; //white
static const char col_cyan[]        = "#005577"; //blue
static const char dCBlack[]        	= "#282a36";
static const char dCWhite[]        	= "#f8f8f2";
static const char dCCyan[]        	= "#8be9fd";
static const char dCGreen[]        	= "#50fa7b";
static const char dCOrange[]        = "#ffb86c";
static const char dCPink[]        	= "#ff79c6";
static const char dCPurple[]        = "#bd93f9";
static const char dCRed[]        	= "#ff5555";
static const char dCYellow[]        = "#f1fa8c";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	//[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	//[SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
	[SchemeNorm] = { dCWhite, dCBlack, dCBlack },
	[SchemeSel]  = { dCBlack, dCPink,  dCPink },
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       0,            1,           -1 },
	{ "Firefox",  NULL,       NULL,       1 << 8,       0,           -1 },
};

/* layout(s) */
static const float mfact     = 0.50; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define ALTKEY Mod1Mask
#define CTRLKEY ControlMask
#define VUP ControlMask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", dCBlack, "-nf", dCWhite, "-sb", dCPink, "-sf", dCBlack, NULL };
static const char *termcmd[]  = { "xfce4-terminal.wrapper", NULL };
static const char *filemgr[]  = { "pcmanfm", NULL };
static const char *ss[]  = { "xfce4-screenshooter", "-f", NULL };
static const char *ssw[]  = { "xfce4-screenshooter","-w", NULL };
static const char *ssr[]  = { "xfce4-screenshooter", "-r", NULL };
static const char *vup[]  = { "amixer", "-q", "sset", "Master", "5%+", "unmute" , NULL };
static const char *vdown[]  = { "amixer", "-q", "sset", "Master", "5%-", "unmute" , NULL };
static const char *taskmgr[]  = { "lxtask", NULL };
static const char *scrmenu[]  = { "/home/moreno/.config/screenMenu.sh", "-d", NULL };

#include "movestack.c"
#include "maximize.c"

static Key keys[] = {
	/* modifier                     key        		function        argument */
	{ MODKEY,                       XK_r,      		spawn,          {.v = dmenucmd } },
	{ MODKEY,             			XK_Return, 		spawn,          {.v = termcmd } },

	{ MODKEY,             			XK_e, 			spawn,          {.v = filemgr } },
	{ MODKEY,             			XK_t, 			spawn,          {.v = taskmgr } },
	{ 0, 		             		XK_Print, 		spawn,          {.v = ss } },
	{ ALTKEY,             			XK_Print, 		spawn,          {.v = ssw } },
	{ CTRLKEY,             			XK_Print, 		spawn,          {.v = ssr } },
	{ 0,             				XF86XK_AudioRaiseVolume, 	spawn,          {.v = vup } },
	{ 0,             				XF86XK_AudioLowerVolume, 	spawn,          {.v = vdown } },
	{ 0,             				XF86XK_Display, spawn,          {.v = scrmenu } },
	{ MODKEY|ShiftMask,             XK_Right,   	movestack,      {.i = +1 } },
    { MODKEY|ShiftMask,             XK_Left, 	    movestack,      {.i = -1 } },

	{ MODKEY,			           	XK_f,           togglemaximize,      {0} },

	{ MODKEY,                       XK_b,      		togglebar,      {0} },
	{ MODKEY,                       XK_Right,      	focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_Left,      	focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_comma,      	incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_period,      incnmaster,     {.i = -1 } },
	{ MODKEY|ControlMask,           XK_Left,      	setmfact,       {.f = -0.05} },
	{ MODKEY|ControlMask,           XK_Right,      	setmfact,       {.f = +0.05} },
	{ MODKEY|ShiftMask,             XK_Return, 		zoom,           {0} },
	{ MODKEY,                       XK_Tab,    		view,           {0} },
	{ MODKEY|ShiftMask,             XK_q,      		killclient,     {0} },
	{ MODKEY,                       XK_p,      		setlayout,      {.v = &layouts[0]} },
	{ MODKEY|ShiftMask,             XK_f,      		setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_o,      		setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,  		setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  		togglefloating, {0} },
	{ MODKEY,                       XK_0,      		view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      		tag,            {.ui = ~0 } },
	{ MODKEY,           			XK_Up,  		focusmon,       {.i = -1 } },
	{ MODKEY,           			XK_Down, 		focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask, 			XK_Up,  		tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask, 			XK_Down, 		tagmon,         {.i = +1 } },

	{ MODKEY,                       XK_minus,  		setgaps,        {.i = -2 } },
	{ MODKEY,                       XK_plus,  		setgaps,        {.i = +2 } },
	{ MODKEY|ShiftMask,             XK_minus,  		setgaps,        {.i = GAP_RESET } },
	{ MODKEY|ShiftMask,             XK_plus,  		setgaps,        {.i = GAP_TOGGLE} },

	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_e,      		quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

