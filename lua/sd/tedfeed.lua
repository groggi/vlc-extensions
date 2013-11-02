require "simplexml"

local feed = "http://feeds.feedburner.com/tedtalks_video"

function descriptor()
    return { title="TED Talks (Video)" }
end

function main()
    local rsspage = vlc.stream(feed)
    local line = rsspage:readline()
    local xmlcontent = ''

    -- read whole RSS document
    while line ~= nil do
    	xmlcontent = xmlcontent .. line

    	line = rsspage:readline()
    end

    -- parse RSS
    local tree = simplexml.parse_string(xmlcontent)

    -- go trough RSS
    local channel = tree.children[1]

    for _, item in ipairs(channel.children) do
    	if item.name == 'item' then
    		simplexml.add_name_maps(item)
    		
    		local title = vlc.strings.resolve_xml_special_chars(item.children_map['title'][1].children[1])
    		local url = vlc.strings.resolve_xml_special_chars(item.children_map['media:content'][1].attributes["url"])
    		local author = vlc.strings.resolve_xml_special_chars(item.children_map['itunes:author'][1].children[1])
    		local arturl = vlc.strings.resolve_xml_special_chars(item.children_map['media:thumbnail'][1].attributes["url"])


    		vlc.sd.add_item( {
    			path = url,
    			title = title,
    			arturl = arturl,
    			artist = author,
    		})
    	end
    end
end