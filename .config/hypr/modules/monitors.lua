

------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "1.25",
})



-- for making electron apps not blurry
hl.config({
    xwayland = {
        force_zero_scaling = true
    }
})
