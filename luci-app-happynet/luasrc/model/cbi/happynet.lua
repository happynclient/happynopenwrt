-- HAPPYN VPN configuration page. Made by 981213

local fs = require "nixio.fs"

m = Map("happynet")
m.title = translate("HAPPYN VPN")
m.description = translate("happynet is a layer-two peer-to-peer virtual private network (VPN) based n2n which allows users to exploit features typical of P2P applications at network instead of application level.")

-- Basic config
-- edge
m:section(SimpleSection).template  = "happynet/happynet_status"

s = m:section(TypedSection, "happynet", translate("HAPPYN Edge Settings"))
s.anonymous = true
s.addremove = true

switch = s:option(Flag, "enabled", translate("Enable"))
switch.rmempty = false

tunname = s:option(Value, "tunname", translate("TUN device name"))
tunname.optional = false

mode = s:option(ListValue, "mode", translate("Interface mode"))
mode:value("dhcp")
mode:value("static")

ipaddr = s:option(Value, "ipaddr", translate("Interface IP address"))
ipaddr.optional = false
ipaddr.datatype = "ip4addr"
ipaddr:depends("mode", "static")

prefix = s:option(Value, "prefix", translate("Interface netmask"))
prefix:value("8", "8 (255.0.0.0)")
prefix:value("16", "16 (255.255.0.0)")
prefix:value("24", "24 (255.255.255.0)")
prefix:value("28", "28 (255.255.255.240)")
prefix.optional = false
prefix.datatype = "range(0,32)"
prefix:depends("mode", "static")

mtu = s:option(Value, "mtu", translate("MTU"))
mtu.datatype = "range(1,1500)"
mtu.optional = false

supernode = s:option(Value, "supernode", translate("Server Host"))
supernode.datatype = "host"
supernode.optional = false
supernode.rmempty = false

port = s:option(Value, "port", translate("Server Port"))
port.datatype = "port"
port.optional = false
port.rmempty = false

second_supernode = s:option(Value, "second_supernode", translate("Second Server Host"))
second_supernode.datatype = "host"
second_supernode.optional = false

second_port = s:option(Value, "second_port", translate("Second Server Port"))
second_port.datatype = "port"
second_port.optional = false

community = s:option(Value, "community", translate("HAPPYN Community name"))
community.optional = false

s:option(Value, "key", translate("Encryption key"))

route = s:option(Flag, "route", translate("Enable packet forwarding"))
route.rmempty = false

compress = s:option(Flag, "compress", translate("Enable data compress"))
compress.rmempty = true

select_rtt= s:option(Flag, "select_rtt", translate("auto connect fastest server"))
select_rtt.rmempty = true

masquerade = s:option(Flag, "masquerade", translate("Enable IP masquerade"))
masquerade.description = translate("Make packets from LAN to other edge nodes appear to be sent from the tunnel IP. This can make setting up your firewall easier")
masquerade.orientation = "horizontal"
masquerade:depends("route", 1)
masquerade.rmempty = false

-- supernode
--[[
s = m:section(TypedSection, "supernode", translate("HAPPYN Supernode Settings"))
s.anonymous = true
s.addremove = true

switch = s:option(Flag, "enabled", translate("Enable"))
switch.rmempty = false

port = s:option(Value, "port", translate("Port"))
port.datatype = "port"
port.optional = false

subnet = s:option(Value, "subnet", translate("DHCP Subnet"))
subnet.optional = false
--]]

-- Static route
--[[
s = m:section(TypedSection, "route", translate("HAPPYN routes"))
s.description = translate("Static route for happynet interface")
s.anonymous = true
s.addremove = true
s.template = "cbi/tblsection"

switch = s:option(Flag, "enabled", translate("Enable"))
switch.rmempty = false
--]]

---- IP address
--[[
o = s:option(Value, "ip", translate("IP"))
o.optional = false
o.datatype = "ip4addr"
o.rmempty = false
--]]

---- IP mask
--[[
o = s:option(Value, "mask", translate("Mask"))
o:value("8", "8 (255.0.0.0)")
o:value("16", "16 (255.255.0.0)")
o:value("24", "24 (255.255.255.0)")
o:value("28", "28 (255.255.255.240)")
o.optional = false
o.datatype = "range(0,32)"
o.default = "24"
--]]

---- Gateway
--[[
o = s:option(Value, "gw", translate("Gateway"))
o.optional = false
o.datatype = "ip4addr"
o.rmempty = false
--]]

---- Description
--[[
o = s:option(Value, "desc", translate("Description"))
o.optional = false
--]]

return m
