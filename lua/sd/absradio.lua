local base_url = "http://icecast.timlradio.co.uk"
local regex_value = ">([^<]*)"

function descriptor()
    return { title="Absolute Radio" }
end

function main()
    page, msg = vlc.stream(base_url)
    
    if not page then
        vlc.msg.dbg(msg)
        return nil
    end

    line = page:readline()
    last_element = {}
    while line ~= nil do
        if string.match(line, "XSPF") then
            vlc.sd.add_item(last_element)
            last_element = {}
            last_element["path"] = base_url .. string.match(line, "<a href=\"([^\"]*)\">XSPF</a>")
        elseif string.match(line, "Stream Description:") then
            line = page:readline()
            last_element["title"] = string.match(line, regex_value)
        elseif string.match(line, "Bitrate") then
            line = page:readline()
            last_element["title"] = last_element["title"] .. " | Bitrate: " .. string.match(line, regex_value)
        elseif string.match(line, "Content Type") then
            line = page:readline()
            last_element["title"] = last_element["title"] .. " | Type: " .. string.match(line, regex_value)
        elseif string.match(line, "Stream Genre") then
            line = page:readline()
            last_element["category"] = string.match(line, regex_value)
        end

        line = page:readline()
    end
end