--
-- Options to get some programs work more nicely (or at all)
--


defwinprop{
    class = "AcroRead",
    instance = "documentShell",
    acrobatic = true
}


defwinprop{
    class = "Xpdf",
    instance = "openDialog_popup",
    ignore_cfgrq = true,
}


-- Put all dockapps in the statusbar's systray, also adding the missing
-- size hints necessary for this to work.
defwinprop{
    is_dockapp = true,
    statusbar = "systray",
    --max_size = { w = 64, h = 64},
    --min_size = { w = 64, h = 64},
}


-- You might want to enable these if you really must use XMMS. 
--[[
defwinprop{
    class = "xmms",
    instance = "XMMS_Playlist",
    transient_mode = "off"
}

defwinprop{
    class = "xmms",
    instance = "XMMS_Player",
    transient_mode = "off"
}
--]]


-- Associate an application to a frame.
-- To rename a frame: mod_query.query_renameframe(_)

defwinprop {
  -- Netsoul client on PIE (EPITA)
  class = "Xm",
  instance = "ns_xm",
  target = "*scratchpad*",
}

defwinprop {
  -- Netsoul client
  class = "Soulmebaby",
  instance = "soulmebaby",
  target = "chatsframe",
}

defwinprop {
  class = "Pidgin",
  instance = "pidgin",
  target = "chatsframe",
}

defwinprop {
  -- Firefox for Debian
  class = "Iceweasel",
  instance = "Navigator",
  target = "browserframe",
}

defwinprop {
  -- Firefox for ArchLinux
  class = "Shiretoko",
  instance = "Navigator",
  target = "browserframe",
}

defwinprop {
  class = "Google-chrome",
  instance = "google-chrome",
  target = "browserframe",
}

-- Define some additional title shortening rules to use when the full
-- title doesn't fit in the available space. The first-defined matching 
-- rule that succeeds in making the title short enough is used.
ioncore.defshortening("(.*) - Mozilla(<[0-9]+>)", "$1$2$|$1$<...$2")
ioncore.defshortening("(.*) - Mozilla", "$1$|$1$<...")
ioncore.defshortening("XMMS - (.*)", "$1$|...$>$1")
ioncore.defshortening("[^:]+: (.*)(<[0-9]+>)", "$1$2$|$1$<...$2")
ioncore.defshortening("[^:]+: (.*)", "$1$|$1$<...")
ioncore.defshortening("(.*)(<[0-9]+>)", "$1$2$|$1$<...$2")
ioncore.defshortening("(.*)", "$1$|$1$<...")
