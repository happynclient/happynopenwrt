-- HAPPYNET Luci configuration page

module("luci.controller.happynet", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/happynet") then
		return
	end
    local icon_name = "favicon.png"
    local icon_path = "/luci-static/resources/icons/" .. icon_name
    
    local page = entry({"admin", "vpn", "happynet"}, cbi("happynet"), _("HAPPYN VPN"), 45)
    page.icon = icon_path

	entry({"admin", "vpn"}, firstchild(), "VPN", 45).dependent = false
	entry({"admin", "vpn", "happynet"}, cbi("happynet"), _("HAPPYN VPN"), 45).dependent = true
	entry({"admin", "vpn", "happynet", "status"}, call("act_status")).leaf = true
end

function act_status()
	local e = {}
	e.running = luci.sys.call("pgrep happynet >/dev/null") == 0
	luci.http.prepare_content("application/json")
	luci.http.write_json(e)
end
